-- helper module for setting custom lsp settings per project
-- will be used for setting autostart of lspclient per projects

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local augroup_name = "spike_lsp"

local function per_project_file()
  local cwd = vim.fn.getcwd()
  -- TODO:
  -- check if there is a custom .nvim-lsp file in dir
  -- read custom lsp config from file in table format
  -- clean merge it ? with local template config to avoid random vars
  -- setup local callback functions automatically called if certain settings
  -- are present.
end


augroup( augroup_name ,{})
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
