return {
  ["nvim-treesitter/nvim-treesitter-textobjects"] = {
    after = "nvim-treesitter",
    -- config = function()
    --   require("custom.plugins.configs.treesitter-to")
    -- end
  },
  ["mfussenegger/nvim-dap"] = {
    module = "dap"
  },
  ["liuchengxu/vista.vim"] = {
    cmd = "Vista",
    setup = function()
      require("core.utils").load_mappings "vista"
    end
  },
  ["folke/which-key.nvim"] = {
    disable = false,
  },
  ["nvim-telescope/telescope.nvim"] = {
     disable = true
  },
  ["ibhagwan/fzf-lua"] = {
    after = "ui",
    config = function()
      require("custom.plugins.configs.fzflua")
      require("plugins.configs.others").devicons()
    end,
    setup = function()
      require("core.utils").load_mappings "fzf_lua"
    end
  },
  -- Run async commands (make & errors)
  ["skywind3000/asyncrun.vim"] = {
    cmd = "AsyncRun",
    config = function()
      require("core.utils").load_mappings "asyncrun"
      vim.g.asyncrun_open = 8
    end
  },
  -- restore view
  ["vim-scripts/restore_view.vim"] = {},

  -- repeat operator for plugin commands
  ["tpope/vim-repeat"] = {
    keys = {"."},
  },
  ["justinmk/vim-sneak"] = {
    keys = {"s", "S"},
    setup = function()
      vim.cmd[[
        let g:sneak#label=1
      ]]
    end
  },

  -- Read info files
  ["https://gitlab.com/HiPhish/info.vim.git"] = {
    cmd = "Info",
    setup = function()
      require("custom.plugins.info").set_mappings()
    end
  },
  ["L3MON4D3/LuaSnip"] = {
    config = function()
      -- load default config first
      require("plugins.configs.others").luasnip()

      vim.g.my_snippets_paths = {"./custom_snippets"}
      require("luasnip").filetype_extend("markdown", { "markdown_zk" })

      -- load snippets from "honza/vim-snippets"
      -- includes ultisnips and snipmate snippets
      require("luasnip.loaders.from_snipmate").lazy_load({ override_priority = 800 })
      require("luasnip.loaders.from_snipmate").lazy_load {
        paths = vim.g.my_snippets_paths,
        override_priority = 800
      }
    end
  },
  ["honza/vim-snippets"] = {
    module = {"cmp", "cmp_nvim_lsp"},
    event = "InsertEnter",
  }
}
