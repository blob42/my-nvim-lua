-- helper module for setting custom lsp settings per project
-- will be used for setting autostart of lspclient per projects
--
local M = {}
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local augroup_name = "perproject"

local function setup_autocommands ()
  augroup( augroup_name ,{}) -- automatically clears prev group commands
  autocmd({"BufRead", "BufWinEnter", "BufNewFile"},{
    group  = augroup_name,
    pattern = "*",
    callback = require("perproject").per_project_jsonfile,
  })

  autocmd({"DirChanged"},{
    group = augroup_name,
    pattern = "window",
    callback = require("perproject").per_project_jsonfile,
  })
end


local _PP_CONF = { 
  basename = ".pnvim.json",
  callbacks = pp_callbacks,
}

local pp_callbacks = {
  -- @enabled: bool

  lsp_autostart = function(enabled)
    if enabled then
      local other_matching_configs = require('lspconfig.util').get_other_matching_providers(vim.bo.filetype)
      for _, config in ipairs(other_matching_configs) do
        config.launch()
      end
    end
  end

}

local function call_pp_callback(proj_opts)
  for key, val in pairs(proj_opts) do
    -- pp_callbacks[opt] ~= nil and pp_callbacks[opt].__call()
    if pp_callbacks[key] ~= nil then
      pp_callbacks[key](val)
    end

  end
end

local ok, Path = pcall(require, "plenary.path")

if not ok then
  print("[perproject] plenary required !")
end

-- local scandir = require("plenary.scandir")

local function per_project_file()
  local cwd = Path.new(vim.fn.getcwd())
  local pp_dir = cwd:joinpath(_PP_CONF_.basename)

  if pp_dir:is_dir() then

    -- find if there is perproject dir
    local function on_exit(results)

      vim.schedule(function()
        for _, res in ipairs(results) do
          pp_options[vim.fs.basename(res)] = true
        end
      end)
    end
    scandir.scan_dir_async(pp_dir.filename, {
      -- on_insert = on_insert,
      on_exit = on_exit,
    })
  else
    print("no " .. _PP_CONF.basename)
  end

  -- TODO:
  -- check if there is a custom .nvim-lsp dir in working dir
  -- each file inside .nvim-lsp represent a active option if
  -- it is present
  -- example
  -- workingDir/
  --      .perproject/
  --            lsp.autostart  --> autostart lsp for this project
end

M.per_project_jsonfile = function()
  local cwd = Path.new(vim.fn.getcwd())
  local pp_file = cwd:joinpath(_PP_CONF.basename)
  if pp_file:is_file() then
    local ok, decoded = pcall(vim.json.decode, (pp_file:read()))
    if not ok then
      vim.notify(string.format("[perproject] could not parse %s : %s", _PP_CONF.basename, decoded), vim.log.levels.ERROR)
      return
    end
    call_pp_callback(decoded)
    -- pp_options = vim.tbl_deep_extend("force", pp_options, proj_opts or {})
  end
end

local function setup_callbacks(conf)
  if conf.callbacks and
    type(conf.callbacks) == "table" then
    for cb_name, cb in pairs(conf.callbacks) do
      if type(cb) == "function" then
        print("setting up callback, ", cb_name)
        pp_callbacks[cb_name] = cb
      end
    end

  end
end

function M.setup(conf)
  local config = conf or {}
  setup_callbacks(config)
  setup_autocommands()
end

return M
