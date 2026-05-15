local M = {}

local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"
local specs_by_name = {}
local build_state_dir = vim.fn.stdpath("state") .. "/native-pack-builds"
local install_specs_by_name = {}
local missing_plugins = {}

local function plugin_name(spec)
	if spec.name then
		return spec.name
	end

	local repo = spec[1]
	if type(repo) ~= "string" then
		error("plugin spec is missing a repository string")
	end

	return repo:match("/([^/]+)$") or repo
end

local function plugin_src(spec)
	if spec.url then
		return spec.url
	end

	if spec.dir then
		return spec.dir
	end

	local repo = spec[1]
	if type(repo) ~= "string" then
		error("plugin spec is missing a repository string")
	end

	if repo:match("^https?://") then
		return repo
	end

	return "https://github.com/" .. repo
end

local function list_plugin_modules()
	local modules = {}

	for name, type_name in vim.fs.dir(plugin_dir) do
		if type_name == "file" and name:sub(-4) == ".lua" then
			modules[#modules + 1] = "plugins." .. name:sub(1, -5)
		end
	end

	table.sort(modules)
	return modules
end

local function normalize_key(spec, key)
	local mode = key.mode or "n"
	local lhs = key[1]
	local rhs = key[2]

	if not lhs or not rhs then
		error(("invalid key spec for %s"):format(specs_by_name[plugin_name(spec)].name))
	end

	return {
		mode = mode,
		lhs = lhs,
		rhs = rhs,
		desc = key.desc,
	}
end

local function flatten_spec(spec, acc)
	acc = acc or {}
	if type(spec) ~= "table" then
		return acc
	end

	if type(spec[1]) == "string" then
		acc[#acc + 1] = spec
		return acc
	end

	for _, item in ipairs(spec) do
		flatten_spec(item, acc)
	end

	return acc
end

local function collect_specs()
	local function add_install_spec(spec)
		local name = plugin_name(spec)
		local version = spec.branch or spec.version
		if install_specs_by_name[name] then
			return
		end

		if version == false or version == "*" then
			version = nil
		end

		install_specs_by_name[name] = {
			src = plugin_src(spec),
			name = name,
			version = version,
		}

		for _, dep in ipairs(spec.dependencies or {}) do
			if type(dep) == "string" then
				add_install_spec({ dep })
			elseif type(dep) == "table" and type(dep[1]) == "string" then
				add_install_spec(dep)
			end
		end
	end

	for _, module in ipairs(list_plugin_modules()) do
		local ok, module_specs = pcall(require, module)
		if not ok then
			error(("failed loading %s: %s"):format(module, module_specs))
		end

		for _, spec in ipairs(flatten_spec(module_specs)) do
			local name = plugin_name(spec)
			spec._name = name
			specs_by_name[name] = spec

			if spec.init then
				spec.init()
			end

			add_install_spec(spec)
		end
	end

	return vim.tbl_values(install_specs_by_name)
end

local function packadd(name)
	return pcall(vim.cmd, "packadd " .. name)
end

local function note_missing(name)
	missing_plugins[name] = true
end

local function load_dependency(dep)
	if type(dep) == "string" then
		local dep_name = dep:match("/([^/]+)$") or dep
		local spec = specs_by_name[dep_name]
		if spec then
			M.load(dep_name)
			return
		end

		if not packadd(dep_name) then
			note_missing(dep_name)
		end
		return
	end

	if type(dep) == "table" and type(dep[1]) == "string" then
		local dep_name = plugin_name(dep)
		if not specs_by_name[dep_name] then
			specs_by_name[dep_name] = dep
		end
		M.load(dep_name)
	end
end

local function resolve_opts(spec)
	if type(spec.opts) == "function" then
		return spec.opts(spec)
	end

	return spec.opts
end

local function default_setup(spec, opts)
	if not opts then
		return
	end

	local main = spec.main or spec._name:gsub("%.nvim$", "")
	require(main).setup(opts)
end

local function run_mapping(rhs)
	if type(rhs) == "function" then
		rhs()
		return
	end

	local cmd = rhs:match("^<cmd>(.*)<[Cc][Rr]>$")
	if cmd then
		vim.cmd(cmd)
		return
	end

	local keys = vim.api.nvim_replace_termcodes(rhs, true, false, true)
	vim.api.nvim_feedkeys(keys, "m", false)
end

local function run_build(spec)
	if not spec.build or spec._built then
		return
	end

	spec._built = true

	local stamp = build_state_dir .. "/" .. spec._name
	if vim.uv.fs_stat(stamp) then
		return
	end

	vim.schedule(function()
		local ok = pcall(vim.cmd, spec.build)
		if ok then
			pcall(vim.fn.mkdir, build_state_dir, "p")
			pcall(vim.fn.writefile, { spec.build }, stamp)
		end
	end)
end

function M.load(name)
	local spec = specs_by_name[name]
	if not spec or spec._loaded then
		return spec ~= nil and spec._loaded
	end

	for _, dep in ipairs(spec.dependencies or {}) do
		load_dependency(dep)
	end

	local ok = packadd(name)
	if not ok then
		note_missing(name)
		return false
	end

	spec._loaded = true

	local opts = resolve_opts(spec)
	if spec.config then
		spec.config(spec, opts)
	elseif opts ~= nil then
		default_setup(spec, opts)
	end

	run_build(spec)
	return true
end

local function on_event(events, callback)
	local group = vim.api.nvim_create_augroup("native-pack-" .. table.concat(events, "-"), { clear = false })
	vim.api.nvim_create_autocmd(events, {
		group = group,
		once = true,
		callback = callback,
	})
end

local function setup_keys(spec)
	for _, key in ipairs(spec.keys or {}) do
		local normalized = normalize_key(spec, key)
		vim.keymap.set(normalized.mode, normalized.lhs, function()
			if M.load(spec._name) then
				run_mapping(normalized.rhs)
			end
		end, { desc = normalized.desc, silent = true })
	end
end

local function setup_spec(spec)
	setup_keys(spec)

	if spec.start or (not spec.event and not spec.defer and not spec.keys) then
		M.load(spec._name)
		return
	end

	if spec.defer then
		vim.schedule(function()
			M.load(spec._name)
		end)
		return
	end

	if spec.event then
		local events = type(spec.event) == "table" and spec.event or { spec.event }
		on_event(events, function()
			M.load(spec._name)
		end)
	end
end

function M.setup()
	specs_by_name = {}
	install_specs_by_name = {}
	missing_plugins = {}

	local install_specs = collect_specs()
	vim.pack.add(install_specs)

	for _, spec in pairs(specs_by_name) do
		setup_spec(spec)
	end

	if next(missing_plugins) then
		vim.schedule(function()
			local names = vim.tbl_keys(missing_plugins)
			table.sort(names)
			vim.notify(
				("Installed plugins are not available until restart: %s"):format(table.concat(names, ", ")),
				vim.log.levels.WARN
			)
		end)
	end
end

return M
