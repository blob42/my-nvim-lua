-- helper module for setting custom lsp settings per project
-- will be used for setting autostart of lspclient per projects


local ok, Path = pcall(require, "plenary.path")
if not ok then
  print("plenary required !")
end
-- local scandir = require("")
local pp = require("spike.perproject")

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local augroup_name = "spike_lsp"
local custom

local function per_project_file()
  local cwd = Path.new(vim.fn.getcwd())
  local pp_dir = cwd:joinpath(pp.base_dirname)
  if pp_dir:is_dir() then
    print(pp_dir)
  else
    -- print("no " .. pp.base_dirname)
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

per_project_file()


augroup( augroup_name ,{}) -- automatically clears prev group commands
autocmd({"BufReadPre"},{
  group  = augroup_name,
  pattern = "*",
  callback = per_project_file,
})
autocmd({"DirChanged"},{
  group = augroup_name,
  pattern = "window",
  callback = per_project_file
})

