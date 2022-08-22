local core = require "fzf-lua.core"
local utils = require "fzf-lua.utils"
local config = require "fzf-lua.config"

M = {}

M.keymaps = function(opts)

  opts = config.normalize_opts(opts, config.globals.nvim.keymaps)
  if not opts then return end

  local modes = {
    n = "blue",
    i = "red",
    c = "yellow"
  }
  local keymaps = {}

  local add_keymap = function(keymap)
    -- hijack fields
    local keymap_desc = keymap.desc == nil and keymap.rhs or keymap.desc
    keymap.str = string.format("%s │ %-40ls │ %s",
      utils.ansi_codes[modes[keymap.mode] or "blue"](keymap.mode),
      keymap.lhs:gsub("%s", "<Space>"),
      keymap_desc)

    local k = string.format("[%s:%s:%s]",
      keymap.buffer, keymap.mode, keymap.lhs)
    keymaps[k] = keymap
  end

  for mode, _ in pairs(modes) do
    local global = vim.api.nvim_get_keymap(mode)
    for _, keymap in pairs(global) do
      add_keymap(keymap)
    end
    local buf_local = vim.api.nvim_buf_get_keymap(0, mode)
    for _, keymap in pairs(buf_local) do
      add_keymap(keymap)
    end
  end

  local entries = {}
  for _, v in pairs(keymaps) do
    table.insert(entries, v.str)
  end

  opts.fzf_opts['--no-multi'] = ''

  core.fzf_exec(entries, opts)
end

return M
