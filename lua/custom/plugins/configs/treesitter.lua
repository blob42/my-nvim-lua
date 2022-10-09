return {
  ensure_installed = {
    "query",
    "css",
    "lua",
    "go",
    "rust",
    "fish",
    "bash",
    "python",
    "c",
    "cpp",
    "haskell",
    "javascript",
    "html",
    "markdown",
    "markdown_inline",
    "make",
    "sql",
    "yaml",
    "toml",
    "vue",
  },

  highlight = {
    enable = true,
    disable = function (lang, bufnr)
      return lang == "help"
    end
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<Tab>",
      scope_incremental = "<CR>",
      node_decremental = "<S-Tab>",
    }
  },


  -- textsubjects = {
  --   enable = true,
  --   prev_selection = "<Tab>",
  --   keymaps = {
  --     ["<CR>"] = "textsubjects-smart", -- works in visual mode
  --   }
  -- },
  --
  rainbow = {
    enable = true,
    extended_mode = true,
  },

  textobjects = {
    enable = true,

    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["aF"] = "@field.outer",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aC"] = "@conditional.outer",
        ["iC"] = "@conditional.inner",
        ["ae"] = "@block.outer",
        ["ie"] = "@block.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["is"] = "@statement.inner",
        ["as"] = "@statement.outer",
        ["ad"] = "@comment.outer",
        ["am"] = "@call.outer",
        ["im"] = "@call.inner",
      }
    },

    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist

      goto_next_start = {
        ["]]"] = "@function.outer",
        ["]C"] = "@class.outer",
      },

      goto_next_end = {
        ["]["] = "@function.outer",
      },
      goto_previous_start = {
        ["[["] = "@function.outer",
        ["[C"] = "@class.outer"
      },
      goto_previous_end = {
        ["[]"] = "@function.outer",
      }
    },

    swap = {
      enable = true,
      swap_next = {
        ["~"] = "@parameter.inner"
      },
    }
  },

  playground = {
    enable = true,
  }
}
