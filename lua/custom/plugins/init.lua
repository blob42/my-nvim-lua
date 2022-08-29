-- vim: foldlevel=0

return {
  ["nvim-treesitter/nvim-treesitter-textobjects"] = {
    after = "nvim-treesitter",
    config = function()
      require("custom.plugins.configs.treesitter-to")
    end
  },
  ["mfussenegger/nvim-dap"] = {
    module = "dap"
  },

  -- side panel with symbols (replaced by Navigator :LspSymbols cmd)
  -- ["liuchengxu/vista.vim"] = {
  --   cmd = "Vista",
  --   setup = function()
  --     require("core.utils").load_mappings "vista"
  --   end
  -- },
  --
  ["folke/which-key.nvim"] = {
    disable = false,
  },
  ["nvim-telescope/telescope.nvim"] = {
     disable = true
  },
  ["ibhagwan/fzf-lua"] = {
    lock = true,
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
  ["tpope/vim-fugitive"] = {
    cmd = {"G", "Git", "G*"}
  },

  -- session and view
  ["vim-scripts/restore_view.vim"] = {},
  ["rmagatti/auto-session"] = {
    config = function ()
        require("auto-session").setup {
          log_level = "error",
          auto_session_suppress_dirs = {"~/", "~/projects", "/"},
          auto_save_enabled = false,
        }
    end
  },

  -- text formatting and navigation
  -- repeat operator for plugin commands
  ["tpope/vim-repeat"] = {
    keys = {"."},
  },
  ["justinmk/vim-sneak"] = {
    keys = {"s", "S"},
    setup = function()
      vim.cmd[[
        let g:sneak#s_next=1
      ]]
    end
  },
  ["tpope/vim-surround"] = {},
  ["godlygeek/tabular"] = {
    cmd = "Tabularize"
  },
  --
  -- misc general plugins
  -- Read info files
  --
  ["https://gitlab.com/HiPhish/info.vim.git"] = {
    cmd = "Info",
    setup = function()
      require("custom.plugins.info").set_mappings()
    end
  },

  -- snippets 
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

  -- LSP 
  ["honza/vim-snippets"] = {
    module = {"cmp", "cmp_nvim_lsp"},
    event = "InsertEnter",
  },
  ["neovim/nvim-lspconfig"] = {
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.util.default_config = vim.tbl_extend(
        "force",
        lspconfig.util.default_config,
        {
          autostart = false
        }
      )
    end-- disable lspconfig, handled by navigator
  },
  ["williamboman/mason-lspconfig.nvim"] = {
    requires = {"williamboman/mason.nvim", "nvim-lspconfig"},
    after = "mason.nvim",
    module = "mson-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({})
    end,
  },
  --
  -- ["https://git.sp4ke.xyz/sp4ke/navigator.lua"] = {
  ["ray-x/navigator.lua"] = {
    after = { "nvim-lspconfig", "base46", "ui" },
    requires =  {"neovim/nvim-lspconfig", "ray-x/guihua.lua", "nvim-treesitter/nvim-treesitter"},
    setup = function()
      require("core.utils").load_mappings "navigator"
    end,
    config = function()
      require("custom.plugins.configs.navigator").setup()
      require("base46").load_highlight "lsp"

      -- TODO: use nvchadui_lsp features manually
      -- require("nvchad_ui.lsp")
    end
  },
  ["ray-x/guihua.lua"] = {
    module = "navigator",
    run=  "cd lua/fzy && make"
  },

  -- per language plugins

  -- lua dev
  ["bfredl/nvim-luadev"] = {
    cmd = "Luadev",
    keys = {
      "<Plug>(Luadev-RunLine)",
      "<Plug>(Luadev-Run)",
      "<Plug>(Luadev-RunWord)",
      "<Plug>(Luadev-Complete)",
    },
    setup = function()
      local autocmd = vim.api.nvim_create_autocmd
      autocmd("FileType", {
        pattern = "lua",
        callback = function ()
          vim.keymap.set({'n', 'i'}, '<leader>r', '<Plug>(Luadev-RunLine)', {
            desc = "Luadev RunLine"
          })
        end,
      })
    end
  },
    ["ii14/neorepl.nvim"] = {
      cmd = "Repl",
      after = "nvim-cmp",
      setup = function ()
        local autocmd = vim.api.nvim_create_autocmd
        autocmd("FileType",{
          pattern = "neorepl",
          callback = function ()
            require('cmp').setup.buffer({enabled = false})

            -- custom keymap example
            -- activate corresponding section in mappings
            -- mappings = require("custom.utils").set_plugin_mappings "neorepl"
          end
        })
      end

    }

}
