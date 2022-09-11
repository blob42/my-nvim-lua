-- vim: foldlevel=1
--
-- TODO: interesting plugins to install
-- - neovim minisurround to replace vim-surround
--
-- #### notes on Lua and requiring modules
-- https://github.com/wbthomason/packer.nvim/issues/955
-- - when you require(...) a file in lua, it gets cached, so future require calls don't hit the filesystem.
-- This means reloading your lua config won't apply any changes because the old files are cached.
-- - Cached required modules are stored in `package.loaded` table
-- - for example if `require("foo.bar")` was issued it's cache would be in
--   `package.loaded["foo.bar"]`
--
-- - to remove the cached module
--
--   lua << EOF
--
--     for k, v in pairs(package.loaded) do
--       if string.match(k, "^my_lua_config") then
--         package.loaded[k] = nil
--       end
--     end
--
--   EOF
--
-- #### Proper way to reload packer while picking up all changes from configs/setup
-- - Remove the cached module using package.loaded["foo.bar"] = nil
-- - Execute :PackerCompile
--
-- This doesn't seem to work:
-- - XXX ~~Reload all lua modules with `"pleanery.reload".reload_module(mod)`~~ XXX

return {
  ["nvim-treesitter/nvim-treesitter"] = {
    setup =  function()
      require("core.lazy_load").on_file_open "nvim-treesitter"
      require("core.lazy_load").on_file_open "nvim-treesitter-textobjects"
      require("core.lazy_load").on_file_open "nvim-treesitter-textsubjects"
      -- require("core.lazy_load").on_file_open "nvim-ts-rainbow"
    end
  },
  ["nvim-treesitter/nvim-treesitter-textobjects"] = {
    opt = true,
  },
  ["RRethy/nvim-treesitter-textsubjects"] = {
    opt = true,
  },
  -- ["p00f/nvim-ts-rainbow"] = {
  --   opt = true,
  -- },
  ["hrsh7th/cmp-buffer"] = {
    config = function ()
      local disabled_ft = {
        "guihua",
        "clap_input",
        "guihua_rust,"
      }

      require("cmp").setup.buffer {
        enabled = function ()
          for _, v in ipairs(disabled_ft) do
            if vim.o.ft == v then return false end
          end
          return true
        end
      }
    end
  },

  ["mfussenegger/nvim-dap"] = {
    lock = true,
    module = "dap"
  },

  ["rcarriga/nvim-dap-ui"] = {
    lock = true,
    after = "nvim-dap",
    config = function ()
      require('dapui').setup()
    end
  },

  ["theHamsta/nvim-dap-virtual-text"] = {
    lock = true,
    after = "nvim-dap"
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
    lock = true,
    disable = false,
    keys = {"<leader>", "<BS>", "<Space>"}
  },

  ["nvim-telescope/telescope.nvim"] = {
    lock = true,
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
    lock = true,
    cmd = "AsyncRun",
    config = function()
      require("core.utils").load_mappings "asyncrun"
      vim.g.asyncrun_open = 8
    end
  },

  ["tpope/vim-fugitive"] = {
    lock = true,
    cmd = {"G", "Git", "G*"}
  },

  -- session and view
  ["vim-scripts/restore_view.vim"] = {}, -- TODO: check if still needed

  -- ["rmagatti/auto-session"] = {
  --   config = function ()
  --       require("auto-session").setup {
  --         log_level = "error",
  --         auto_session_suppress_dirs = {"~/", "~/projects", "/"},
  --         auto_save_enabled = false,
  --       }
  --   end
  -- },

  -- text formatting and navigation
  -- repeat operator for plugin commands
  ["tpope/vim-repeat"] = {
    keys = {"."},
  },

  ["ggandor/leap.nvim"] = {
    config = function()
      require "custom.plugins.configs.leap"
    end
  },
  -- ["justinmk/vim-sneak"] = {
  --   lock = true,
  --   keys = {"s", "S"},
  -- },
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
  },


  -- ["chentoast/marks.nvim"] = {
  --   opt = true,
  --   keys = {"m", "d"},
  --   cmd = {"Marks*", "Bookmarks*"},
  --   config = function ()
  --     require("custom.plugins.configs.marks").setup()
  --   end
  -- },

  -- snippets 
  ["L3MON4D3/LuaSnip"] = {
    lock = true,
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
  -- ------------------
  -- LSP 
  -- ------------------
  ["honza/vim-snippets"] = {
    module = {"cmp", "cmp_nvim_lsp"},
    event = "InsertEnter",
  },
  ["neovim/nvim-lspconfig"] = {
    lock = true,
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
    lock = true,
    requires = {"williamboman/mason.nvim", "nvim-lspconfig"},
    after = "mason.nvim",
    module = "mson-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({})
    end,
  },
  ["ray-x/guihua.lua"] = {
    lock = true,
    module = {"navigator"},
    run=  "cd lua/fzy && make"
  },
  -- ["https://git.sp4ke.xyz/sp4ke/navigator.lua"] = 
    --
  ["ray-x/navigator.lua"] = {
    lock = true,
    opt = true,
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

  ["ray-x/lsp_signature.nvim"] = {
    after = {"navigator.lua"},
    config = function()
      require("custom.plugins.configs.lsp_signature").setup()
    end

  },

  -- per language plugins

  -- -------
  -- lua dev
  -- -------

  -- Eval Lua lines/selections
  ["bfredl/nvim-luadev"] = {
    lock = true,
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

  -- REPL for Lua development
  ["ii14/neorepl.nvim"] = {
    lock = true,
    cmd = "Repl",
    after = "nvim-cmp",
    config = function ()
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
  },

  -- Lua dev env
  -- check setup in configs/navigator.lua
  ["folke/lua-dev.nvim"] = {
    module = "lua-dev",
    before = {"navigator.lua"},
  },

  -- golang dev
  ["ray-x/go.nvim"] = {
    lock = true,
    -- after = {"nvim-lspconfig", "navigator.lua", "guihua.lua"},
    ft = {"go"},
    opt = true,
    config = function()
      require("go").setup({
        run_in_floaterm = true,
        icons = false,
        -- icons = { breakpoint = "🧘", currentpos = "🏃" }, -- set to false to disable
        lsp_cfg = false, -- handled by navigator
        -- lsp_keymaps = false, -- use navigator
        -- lsp_diag_signs = false,
        lsp_codelens = false, -- use navigator
        textobjects = true,
      })
    end
  }
}
