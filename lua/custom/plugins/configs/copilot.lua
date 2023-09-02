local ok, copilot = pcall(require, 'copilot')
if not ok then 
    vim.notify("missing module copilot", vim.log.levels.WARN)
    return
end

local M = {}

local config = {
  panel = {
    enabled = true,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>"
    },
    layout = {
      position = "bottom", -- | top | left | right
      ratio = 0.4
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 100,
    keymap = {
      accept = "<M-j>",
      accept_word = false,
      accept_line = false,
      next = "<M-Right>",
      prev = "<M-Left>",
      dismiss = "<M-Down>",
    },
  },
  filetypes = {
    python = true,
    yaml = false,
    markdown = true,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = 'node', -- Node.js version must be > 16.x
  server_opts_overrides = {
      -- trace = "verbose"
      inlineSuggestCount = 4,
  },
}

M.setup = function()
    copilot.setup(config)
end

return M

