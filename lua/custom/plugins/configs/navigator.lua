local present, navigator = pcall(require, "navigator")

if not present then
  return
end


local config = {
  -- debug = true,
  transparency = nil,
  default_mapping = true,
  icons = {
    icons = true, -- set to false to use system default ( if you using a terminal does not have nerd/icon)
    -- Code action
    code_action_icon = ' ', -- "",
    -- code lens
    code_lens_action_icon = '👓',
    -- Diagnostics
    diagnostic_head = '🐛',
    diagnostic_err = '📛',
    diagnostic_warn = '👎',
    diagnostic_info = [[👩]],
    diagnostic_hint = [[💁]],

    diagnostic_head_severity_1 = '🈲',
    diagnostic_head_severity_2 = '☣️',
    diagnostic_head_severity_3 = '👎',
    diagnostic_head_description = '👹',
    diagnostic_virtual_text = '🦊',
    diagnostic_file = '🚑',
    -- Values
    value_changed = '📝',
    value_definition = '🐶🍡', -- it is easier to see than 🦕
    side_panel = {
      section_separator = '',
      line_num_left = '',
      line_num_right = '',
      inner_node = '├○',
      outer_node = '╰○',
      bracket_left = '⟪',
      bracket_right = '⟫',
    },
    -- Treesitter
    match_kinds = {
      var = ' ', -- "👹", -- Vampaire
      method = 'ƒ ', --  "🍔", -- mac
      ['function'] = ' ', -- "🤣", -- Fun
      parameter = '  ', -- Pi
      associated = '🤝',
      namespace = '🚀',
      type = ' ',
      field = '🏈',
      module = '📦',
      flag = '🎏',
    },
    treesitter_defult = '🌲',
    doc_symbols = '',
  },
  lsp = {
    document_highlight = false,
    mason = true,
    format_on_save = false, -- applies to all formatting feature of neovim 
                            -- including auto-fold
  }
}

navigator.setup(config)
