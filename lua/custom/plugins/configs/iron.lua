local ok, iron = pcall(require, "iron.core")
if not ok then return end

local M = {}

local ironSetup = {
  config = {
    scratch_repl = true,
    highlight_last = "IronLastSent",
    repl_definition = {
      sh = {
        command = {"sh"}
      },
      python = require("iron.fts.python").ipython,
    },
    repl_open_cmd = require('iron.view').bottom(20),
  },
  keymaps = {
    send_motion = "<leader>io",
    visual_send = "<leader>io",
    send_file = "<leader>ii",
    send_line = "<leader>il",
    cr = "<leader>i<cr>",
    interrupt = "<leader>i<leader>",
    exit = "<leader>iq"
  }

}

function M.setup()
  iron.setup(ironSetup)
end


return M
-- M.setup()
