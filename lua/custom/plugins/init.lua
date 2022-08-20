return {
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
  -- Run async commands (make & errors)
  ["skywind3000/asyncrun.vim"] = {
    config = function()
      require("core.utils").load_mappings "asyncrun"
      vim.g.asyncrun_open = 8
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
  ["honza/vim-snippets"] = {}
}
