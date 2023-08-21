-- vim: foldlevel=1 foldmethod=marker
--
-- TODO: plugins to test
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
-- - XXX ~~Reload all lua modules with `"plenaery.reload".reload_module(mod)`~~ XXX

return {


    -- My Plugins

    ["~/.config/nvim/my_packages/perproject"] = { -- {{{
        opt = true,
        after = { "nvim-lspconfig", "navigator.lua" },
        require = { "nvim-lspconfig", "navigator.lua" },
        config = function()
            require("perproject").setup()
            -- callbacks = {
            --   foo = function()
            --     print("FOO")
            --   end
            -- }
            -- })
        end
    }, -- }}}


    -- treesitter

    ["nvim-treesitter/nvim-treesitter"] = { -- {{{
        -- commit = "4f8b2480", -- pin to latest working commit
        -- custom config in chadrc -> custom.configs.treesitter
        lock = false,
        setup = function()
            require("core.lazy_load").on_file_open "nvim-treesitter"
            require("core.lazy_load").on_file_open "nvim-treesitter-textobjects"
            require("core.lazy_load").on_file_open "nvim-treesitter-context"
            require("core.lazy_load").on_file_open "syntax-tree-surfer"
            -- require("core.lazy_load").on_file_open "nvim-treesitter-textsubjects"
            -- require("core.lazy_load").on_file_open "nvim-ts-rainbow"
        end,
    },
    ["nvim-treesitter/nvim-treesitter-textobjects"] = {
        lock = false,
        opt = true,
    },
    -- ["RRethy/nvim-treesitter-textsubjects"] = {
    --     opt = true,
    -- },

    ["ziontee113/syntax-tree-surfer"] = {
        lock = false,
        opt = true,
        config = function()
            require("syntax-tree-surfer").setup()
        end
    },
    -- Treesitter dev/exploration tool
    -- https://git.blob42.xyz/blob42/playground/commit/460fe1b3e3b2971c52c5f02a7dbbb132f1f30584
    ["nvim-treesitter/playground"] = {
    -- ["https://git.blob42.xyz/blob42/playground"] = {
        lock = false,
        -- opt = true,
        cmd = { "TSPlayground*" },
        -- commit = "460fe1b3e3b2971c52c5f02a7dbbb132f1f30584",
    },

    ["nvim-treesitter/nvim-treesitter-context"] = {
        lock = false,
        opt = true,
        config = function()
            require("custom.plugins.configs.treesitter-context").setup()
        end
    }, -- }}}


    -- autocomplete

    ["hrsh7th/cmp-buffer"] = { -- {{{
        config = function()
            local disabled_ft = {
                "guihua",
                "clap_input",
                "guihua_rust,",
                "TelescopePrompt"
            }

            require("cmp").setup.buffer {
                enabled = function()
                    for _, v in ipairs(disabled_ft) do
                        if vim.o.ft == v then return false end
                    end
                    return true
                end
            }
        end
    }, -- }}}

    ["zbirenbaum/copilot-cmp"] = {
        after = {"copilot.lua"},
        config = function()
            require("copilot_cmp").setup()
        end
    },


    -- Code Refactoring
    ["ThePrimeagen/refactoring.nvim"] = {
        module = {"refactoring"},
        setup = function()
            require("core.utils").load_mappings "refactoring"
        end,
        config = function()
            require("custom.plugins.configs.refactoring").setup()
        end,
        after = {"telescope.nvim"},
        requires = {
            {"nvim-lua/plenary.nvim"},
            {"nvim-treesitter/nvim-treesitter"}
        }
    },

    -- AI/Deep Learning Helpers
    -- Github Copilot

    ["zbirenbaum/copilot.lua"] = {
        opt = true,
        cmd = "Copilot",
        keys = {"<leader>ghp"},
        setup = function()
            require("core.utils").load_mappings "copilot"
        end,
        config = function()
            require("custom.plugins.configs.copilot").setup()
        end,
    },

    -- ["github/copilot.vim"] = {
    --     opt = true,
    --     keys = {"<leader>ghp"},
    --     setup= function()
    --         require("core.utils").load_mappings "copilot"
    --     end
    -- },

    ["MunifTanjim/nui.nvim"] = {
        module = {"nui.layout", "nui.popup"},
        module_pattern = {"nui.*"}
    },

    -- TODO: review/test the following
    -- https://github.com/dpayne/CodeGPT.nvim
    -- https://github.com/thmsmlr/gpt.nvim
    ["dpayne/CodeGPT.nvim"] = {
        -- keys = {"<leader>gpT"},
        event = "BufRead",
        config = function()
            require("codegpt.config")
            require("custom.plugins.configs.code-gpt").setup()
        end
    },
    ["jackMort/ChatGPT.nvim"] = {
        -- lock = true,
        opt = true,
        keys = {"<leader>gpt"},
        module_pattern = {"chatgpt*"},
        after = {"nui.nvim", "telescope.nvim"},
        setup = function()
            require("custom.plugins.configs.chat-gpt").load_api_key()
        end,
        config = function()
            require("custom.plugins.configs.chat-gpt").setup()
        end,
        requires = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }
    },

    -- snippets
    ["honza/vim-snippets"] = { -- {{{
        module = { "cmp", "cmp_nvim_lsp" },
        event = "InsertEnter",
    },

    ["L3MON4D3/LuaSnip"] = {
        lock = false,
        module = "luasnip",
        config = function() -- overriding default nvchad config here
            -- load default config first
            require("custom.plugins.configs.luasnip").setup()

            vim.g.my_snippets_paths = { vim.fn.stdpath('config') .. '/mysnippets' }
            require("luasnip").filetype_extend("markdown", { "markdown_zk" })

            -- load snippets from "honza/vim-snippets"
            -- includes ultisnips and snipmate snippets
            -- default priority for snipmate is 1000
            require("luasnip.loaders.from_snipmate").lazy_load({ override_priority = 500 })
            require("luasnip.loaders.from_snipmate").lazy_load {
                paths = vim.g.my_snippets_paths,
                override_priority = 600
            }

            -- my luasnip snippets
            require("luasnip.loaders.from_lua").lazy_load {
                paths = vim.g.my_snippets_paths,
                override_priority = 2000, -- highest priority for my luasnips
            }
        end
    },


    -- vim templates 
    ["https://codeberg.org/jgoguen/tmpl.vim"] = {
        setup = function()
            
        end
    },

    -- }}}

    -- text formatting
    --
    ["dhruvasagar/vim-table-mode"] = {
        opt = true,
        cmd = {"TableModeToggle"},
    },

    ["folke/todo-comments.nvim"] = { -- {{{
        lock = true,
        -- commit = "6124066",
        -- after = "nvim-treesitter",
        setup = function()
            -- require("core.lazy_load").on_file_open "todo-comments"
            require("core.utils").load_mappings "todo-comments"
        end,
        config = function()
            require("custom.plugins.configs.todo-comments").setup()
        end
    },

    ["tpope/vim-surround"] = {},

    ["tpope/vim-abolish"] = {},

    ["godlygeek/tabular"] = {
        cmd = {"Tabularize"}
    }, -- }}}

    ["FooSoft/vim-argwrap"] = {
        -- setup = function()
        --     
        -- end
    },

    ["mbbill/undotree"] = {
        cmd = {"UndotreeToggle"}
    },


    -- helper to select icons and fonts
    ["ziontee113/icon-picker.nvim"] = {
        cmd = {"IconPicker*"},
        setup = function()
            require("core.utils").load_mappings "iconpicker"
        end,
        config = function()
            require("icon-picker").setup({
                disable_legacy_commands = true
            })
        end,
    },

    -- ["p00f/nvim-ts-rainbow"] = {
    --   opt = true,
    -- },


    -- dap

    ["mfussenegger/nvim-dap"] = { 
        -- lock = true,
        module = {"dap"},
        setup = function()
            require("core.utils").load_mappings "dap"
        end,
        config = function()
            -- require('spike.dap').setup()
            -- require("custom.plugins.configs.dap").setup()
        end
    },

    ["mfussenegger/nvim-dap-python"] = {
        after = {"nvim-dap"},
        config = function()
            -- expand share folder
            local venv_path = vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/bin/python'
            local ok, dappy = pcall(require, 'dap-python')
                if not ok then
                    vim.notify("dap-python not found", vim.log.levels.ERROR)
                    return
                end
            dappy.setup(venv_path)
            dappy.test_runner = 'pytest'
        end,
        cond = function()
            -- filetype is python
            return vim.bo.filetype == "python"
        end
    },

    ["rcarriga/nvim-dap-ui"] = {
        -- tag = "*",
        lock = true,
        commit = "1e21b3b",
        after = {"nvim-dap"},
        config = function()
            require('custom.plugins.configs.dapui').setup()
        end
    },

    ["theHamsta/nvim-dap-virtual-text"] = {
        lock = false,
        after = {"nvim-dap"},
        config = function()
            require("custom.plugins.configs.dap-virt-text").setup_virt_text()
        end
    }, 

    -- User Interface / UX
    ["stevearc/dressing.nvim"] = {
        lock = true,
        config = function()
            require("custom.plugins.configs.dressing").setup()
        end
    },

    -- allows to preview commands after they are registerd by plugin
    -- the current registerd norm command works by first selecting a visual selection
    -- then doing the changes, it's an enhanced multi cursor
    ["smjonas/live-command.nvim"] = {
        lock = true,
        cmd = require("custom.plugins.configs.live-command").get_cmds(),
        opt = true,
        config = function()
            require("custom.plugins.configs.live-command").setup()
        end
    },

    ["folke/which-key.nvim"] = { -- {{{
        lock = true,
        disable = false,
        keys = { "<leader>", "<BS>", "<Space>", "\"", "`", "'", "z", "g" }
    },


    -- scren saver
    -- ["folke/drop.nvim"] = {
    --     opt = true,
    --     config = function()
    --         require("drop").setup()
    --     end
    -- },

    -- repeat operator for plugin commands
    ["tpope/vim-repeat"] = {
        keys = { "." },
    },

    ["nvim-telescope/telescope.nvim"] = {
        -- lock = true,
        disable = false,
    },
    ["tom-anders/telescope-vim-bookmarks.nvim"] = {
        opt = true,
        module = "telescope",
        after = { "telescope.nvim", "vim-bookmarks" },
        -- cmd = "Telescope",
        -- requires = "vim-bookmarks",
        -- after = {"vim-bookmarks", "telescope"},
        -- module = "telescope",
        config = function()
            require("telescope").load_extension("vim_bookmarks")
        end
    },
    ["nvim-telescope/telescope-fzf-native.nvim"] = {
        opt = true,
        module = "telescope",
        after = { "telescope.nvim" },
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    },
    ["ibhagwan/fzf-lua"] = {
        lock = true,
        after = "ui",
        eonfig = function()
            require("custom.plugins.configs.fzflua")
            require("plugins.configs.others").devicons()
        end,
        setup = function()
            require("core.utils").load_mappings "fzf_lua"
        end
    }, -- }}}

    -- Theme customization


    ["jesseleite/nvim-noirbuddy"] = {
        requires = {"tjdevries/colorbuddy.nvim", branch = "dev"},
        after = {"base46"},
        config = function()
            require("custom.plugins.configs.noirbuddy").setup()
            -- require("noirbuddy").setup()
        end,
    },

    -- Color picker
    ["uga-rosa/ccc.nvim"] = { -- {{{{{{
        -- commit = "427471b",
        cmd    = { "Ccc*", "<Plug>(ccc-insert)" },
        setup  = function()
            require("core.utils").load_mappings "ccc"
        end,
        config = function()
            require("ccc").setup({})
        end
    }, -- }}}}}}

    -- navigation / jumping / buffer modification

    -- ["justinmk/vim-sneak"] = {
    --   lock = true,
    --   keys = {"s", "S"},
    -- },

    ["ggandor/leap.nvim"] = { -- {{{
        config = function()
            require "custom.plugins.configs.leap"
        end
    }, -- }}}

    ["cbochs/grapple.nvim"] = {
        -- commit = "50b8271",
        cmd = {"Grapple*"},
        module = {"grapple"},

        setup = function()
            require("core.utils").load_mappings "grapple"
        end,
        config = function()
            require('custom.plugins.configs.grapple').setup()
        end
    },
    -- tmux helpers
    ["christoomey/vim-tmux-navigator"] = {
        cond = function()
            return vim.env.TMUX ~= nil
        end
    },

    ["https://git.sp4ke.xyz/sp4ke/vim-vimux"] = {
        cond = function()
            return vim.env.TMUX ~= nil
        end,
        setup = function()
            require("core.utils").load_mappings "vimux"
            -- vim.g.VimuxDebug = 1
            vim.g.VimuxHeight = 20
        end
    },

    -- Job management (use nvim startjob )
    -- Run async commands (make & errors)
    -- TODO: replace with https://github.com/skywind3000/asynctasks.vim

    ["skywind3000/asyncrun.vim"] = { -- {{{
        -- lock = true,
        cmd = "AsyncRun",
        setup = function()
            require("core.utils").load_mappings "asyncrun"
            vim.g.asyncrun_open = 8
        end
    }, -- }}}

    -- TODO: asynctsks vs overseer: task runner and job management 
    -- NOTE: asynctasks uses AsyncRun !!
    ["stevearc/overseer.nvim"] = {
        cmd = {"Overseer*"},
        setup = function()
            require 'core.utils'.load_mappings 'overseer'
        end,
        config = function()
            require("custom.plugins.configs.overseer").setup()
        end,
    },


    -- Git
    ["lewis6991/gitsigns.nvim"] = {
        ft = "gitcommit",
        setup = function()
            require("core.lazy_load").gitsigns()
        end,
        config = function()
            require("custom.plugins.configs.gitsigns").setup()
        end,
    },

    ["tpope/vim-fugitive"] = {
        cmd = { "G", "Git", "G*" }
    },

    ["sindrets/diffview.nvim"] = {
        requires = { "nvim-lua/plenary.nvim" },
        after = { "plenary.nvim" },

        config = function()
            require("diffview").setup({
                enhanced_diff_hl = true,
            })
        end
    },

    -- sessions, projects and views

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

    ["windwp/nvim-projectconfig"] = {
        after = {"CodeGPT.nvim"},
        event = "BufRead",
        config = function()
            require("custom.plugins.configs.projectconfig").setup()
        end,
    },

    --
    -- Misc / General plugins

    -- Read info files
    ["https://gitlab.com/HiPhish/info.vim.git"] = { -- {{{{{{
        cmd = "Info",
    }, -- }}}}}}


    -- options are defined in plugin/globals.vim
    ["MattesGroeger/vim-bookmarks"] = { -- {{{
        config = function()
            require("core.utils").load_mappings "vim_bookmarks"
        end
    }, -- }}}

    -- create new vim modes
    ["Iron-E/nvim-libmodal"] = { -- {{{
        lock = true,
        module = "libmodal",
    }, -- }}}

    -- get rid of bad habits
    ["ja-ford/delaytrain.nvim"] = {
    -- ["~/src/delaytrain.nvim"] = {
        event = "BufRead",
        config = function()
            require('delaytrain').setup({
                delay_ms = 1001, -- How long repeated usage of a key should be prevented
                grace_period = 1, -- How many repeated keypresses are allowed
                keys = { -- Which keys (in which modes) should be delayed
                    ['n'] = { 'h', 'j', 'k', 'l' },
                    -- ['nvi'] = { '<Left>', '<Down>', '<Up>', '<Right>' },
                },
                ignore_filetypes = {
                    "qf",
                    "NvimTree",
                    "help",
                    "qf",
                    "netrw",
                    "neorepl",
                    "dapui*",
                    "mason",
                    "guihua*",
                    "terminal*",
                    "db*",
                    "aerial*",
                    "grapple",
                    "fugitive",
                    "query"
                },
            })
        end
    },

    ["dstein64/vim-startuptime"] = {
        cmd = {"StartupTime"}
    },

    -- ["takac/vim-hardtime"] = {-- {{{
    --   -- keys = { "h", "j", "k", "l" },
    --   setup = function()
    --     vim.g.hardtime_default_on = 1
    --     vim.g.hardtime_showmsg = 1
    --     vim.g.list_of_normal_keys = {"h","j","k","l"}
    --     vim.g.list_of_visual_keys = {"h","j","k","l"}
    --     vim.g.hardtime_ignore_quickfix = 1
    --     vim.g.hardtime_ignore_buffer_patterns = {
    --         "NERD.*",
    --         "netrw",
    --         "TelescopePrompt",
    --         "fugitive",
    --         "guihua*",
    --     }
    --     vim.g.hardtime_maxcount = 2
    --   end,
    -- },-- }}}

    -- ["chentoast/marks.nvim"] = {
    --   opt = true,
    --   keys = {"m", "d"},
    --   cmd = {"Marks*", "Bookmarks*"},
    --   config = function ()
    --     require("custom.plugins.configs.marks").setup()
    --   end
    -- },

    -- ------------------
    -- LSP
    -- ------------------

    ["neovim/nvim-lspconfig"] = { -- {{{
        -- lock = true,
        after = {"mason.nvim", "mason-lspconfig.nvim", "neodev.nvim" },
        module = { "lspconfig" },
        config = function()
            require("plugins.configs.lspconfig").setup()
        end
    },
    ["williamboman/mason-lspconfig.nvim"] = {
        -- lock = true,
        requires = { "williamboman/mason.nvim", "nvim-lspconfig" },
        -- after = "mason.nvim",
        module = { "mson-lspconfig.nvim", "mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({})
        end,
    },
    ["ray-x/guihua.lua"] = {
        -- lock = true,
        module = { "navigator" },
        module_pattern = {"guihua*"},
        run = "cd lua/fzy && make",
        config = function()
            require("guihua.maps").setup {
                maps = {
                    close_view = "<C-x>",
                }
            }
        end

    },
    -- ["https://git.sp4ke.xyz/sp4ke/navigator.lua"] =
    --
    ["ray-x/navigator.lua"] = {
        -- lock = true,
        opt = true,
        module = "navigator",
        after = { "nvim-lspconfig", "base46", "ui", "mason.nvim", "mason-lspconfig.nvim", "neodev.nvim", "null-ls.nvim"},
        requires = { "neovim/nvim-lspconfig", "ray-x/guihua.lua", "nvim-treesitter/nvim-treesitter" },
        setup = function()
            require("core.lazy_load").on_file_open "navigator.lua"
        end,
        config = function()
            require("custom.plugins.configs.navigator").setup()
            require("base46").load_highlight "lsp"
            require("core.utils").load_mappings "navigator"

            -- TODO: use nvchadui_lsp features manually
            -- require("nvchad_ui.lsp")
        end
    },

    ["ray-x/lsp_signature.nvim"] = {
        lock = true,
        after = { "navigator.lua" },
        config = function()
            require("custom.plugins.configs.lsp_signature").setup()
        end

    }, -- }}}

    ["jose-elias-alvarez/null-ls.nvim"] = {
        lock = true,
        requires = {"nvim-lua/plenary.nvim"},
        event = "BufRead",
        setup = function()
            require('core.utils').load_mappings 'null_ls'
        end,
        config = function()
            require("custom.plugins.configs.null-ls").setup()
        end,
    },

    -- side panel with symbols (replaced by Navigator :LspSymbols cmd)
    -- ["liuchengxu/vista.vim"] = {
    --   cmd = "Vista",
    --   setup = function()
    --     require("core.utils").load_mappings "vista"
    --   end
    -- },
    --

    ['stevearc/aerial.nvim'] = {
        -- lock = true,
        after = { "base46" },
        keys = { "<Right>" },
        cmd = { "Aerial*" },
        config = function()
            require("core.utils").load_mappings "aerial"
            require("custom.plugins.configs.aerial").setup()
        end
    },

    -- -------------------------------------------------------
    -- Programming Languages Plugins
    -- -------------------------------------------------------

    -- -------
    -- lua dev
    -- -------

    -- Eval Lua lines/selections

    -- ["bfredl/nvim-luadev"] = {{{{
    --   lock = true,
    --   cmd = "Luadev",
    --   keys = {
    --     "<Plug>(Luadev-RunLine)",
    --     "<Plug>(Luadev-Run)",
    --     "<Plug>(Luadev-RunWord)",
    --     "<Plug>(Luadev-Complete)",
    --   },
    --   setup = function()
    --     local autocmd = vim.api.nvim_create_autocmd
    --     autocmd("FileType", {
    --       pattern = "lua",
    --       callback = function ()
    --         vim.keymap.set({'n', 'i'}, '<leader>r', '<Plug>(Luadev-RunLine)', {
    --           desc = "Luadev RunLine"
    --         })
    --       end,
    --     })
    --   end
    -- },}}}

    -- power Repl {{{
    ["hkupty/iron.nvim"] = {
        loack = true,
        cmd = { "Iron*" },
        setup = function()
            require("core.utils").load_mappings "iron"
        end,
        config = function()
            require("custom.plugins.configs.iron").setup()
        end
    },

    -- REPL for Lua development
    ["ii14/neorepl.nvim"] = {
        lock = true,
        cmd = "Repl",
        after = "nvim-cmp",
        config = function()
            local autocmd = vim.api.nvim_create_autocmd
            autocmd("FileType", {
                pattern = "neorepl",
                callback = function()
                    require('cmp').setup.buffer({ enabled = false })

                    -- custom keymap example
                    -- activate corresponding section in mappings
                    -- mappings = require("custom.utils").set_plugin_mappings "neorepl"
                end
            })
        end
    },

    -- Lua dev env
    -- check setup in configs/navigator.lua
    -- ["folke/lua-dev.nvim"] = {
    --     lock = true,
    --     module = "lua-dev",
    -- }, -- }}}

    -- neodev (replaces lua-dev)
    ["folke/neodev.nvim"] = {
        lock = true,
        -- commit = "d6212c1"
        -- module = "neodev",
        ft = {'lua'},
        module = {'neodev'},
        config = function()
            require('custom.plugins.configs.neodev').setup()
        end
    },
    ["hrsh7th/cmp-nvim-lua"] = { -- NOTE: needs to be disabled for neodev
        disable = true,
    },

    -- golang dev

    ["ray-x/go.nvim"] = { -- {{{
        -- lock = true,
        -- after = {"nvim-lspconfig", "navigator.lua", "guihua.lua"},
        ft = { "go" },
        opt = true,
        after = {"null-ls.nvim"},
        config = function()
            require("custom.plugins.configs.gonvim").setup()
            require("core.utils").load_mappings "gonvim"
        end
    }, -- }}}

    -- Rust dev
    ["simrat39/rust-tools.nvim"] = { -- {{{
        lock = false,
        ft = { "rust" },
        opt = true,
        config = function()
            require("custom.plugins.configs.rust-tools").setup()
        end
    }, -- }}}


    -- PlantUML
    ["aklt/plantuml-syntax"] = {
        opt = true,
        setup = function()
            require("custom.plugins.configs.plantuml").lazy_load_module()
        end
    },
    ["weirongxu/plantuml-previewer.vim"] = {
        ft = {"plantuml"},
    },
    ["scrooloose/vim-slumlord"] = {
        opt = true,
        -- ft = {"plantuml"},
    },

    -- Diagram Tools
    ["jbyuki/venn.nvim"] = {
        keys = { "<leader>V" },
        config = function()
            require("custom.plugins.configs.venn").enable()
            require("core.utils").load_mappings "venn"
        end,
    },

    -- sql tools
    -- https://github.com/tpope/vim-dadbod
    -- https://github.com/kristijanhusak/vim-dadbod-ui
    ["tpope/vim-dadbod"] = {
        ft = "sql",
        cmd = {"DBUI"},
    },
    ["kristijanhusak/vim-dadbod-ui"] = {
        after = {"vim-dadbod"},
    },


    -- zk nvim
    ["mickael-menu/zk-nvim"] = {
        lock = true,
        module = {"zk"},
        cmd = {"Zk*"},
        setup = function()
            require("core.utils").load_mappings "zk"
        end,
        config = function()
            require("custom.plugins.configs.zk").setup()
        end
    },

    -- Python jupyter notebooks
    -- actual jupter kernel to neovim adapter
    -- ["dccsillag/magma-nvim"] = {
    --     keys = '<leader>jup',
    --     opt = true,
    --     run = ':UpdateRemotePlugins',
    -- },

    -- edit ipynb files 
    -- ["goerz/jupytext.vim"] = {
    --     after = {"magma-nvim"},
    -- },

    -- jupyter notebook
    -- dependencies: jupyter jupytext
    ["luk400/vim-jukit"] = {
        lock = false,
        keys = '<leader>jup',
        setup = function()
            patterns = {
                '.*ipynb$'
            }
            require('spike.utils').lazy_load_module(patterns, 'vim-jukit')
        end,
        opt = true,
    },

    -- theseraus{{{
    -- ["Ron89/thesaurus_query.vim"] = { },

    -- setup in after/plugin/vim-lexical
    -- requires a thesearus file like from here:
    -- https://www.gutenberg.org/files/3202/files/
    ["preservim/vim-lexical"] = { },-- }}}
}
