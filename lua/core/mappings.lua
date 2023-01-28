-- vim: foldmethod=marker foldlevel=1
-- n, v, i, t, c = mode name.s

local function termcodes(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local M = {}

M.general = { --{{{
    i = { --{{{

        ["jk"] = { "<esc>", "escape" },


        -- navigate within insert mode
        ["<C-h>"] = { "<Left>", "move left" },
        ["<C-l>"] = { "<Right>", "move right" },
        ["<C-j>"] = { "<Down>", "move down" },
        ["<C-k>"] = { "<Up>", "move up" },

        ["<C-s>"] = { "<cmd> update <CR>", "update file (save on changes)" },

        -- luasnip change choice
        ["<C-l>"] = { "<Plug>luasnip-next-choice", "change luasnip choice" },
        -- ["<C-u>"] = { "<cmd>lua require('luasnip.extras.select_choice')()<CR>", "change luasnip choice" },
    }, --}}}

    n = { --{{{
        ["<ESC>"] = {
            function()
                if vim.o.filetype == "qf" then
                    vim.cmd("q")
                else
                    vim.cmd("noh")
                end
            end,
            "no highlight"
        },

        -- smoth scrolling with M-j M-k
        ["<M-j>"] = { "<C-e>", "scroll down"},
        ["<M-k>"] = { "<C-y>", "scroll down"},

        -- switch between windows
        ["<C-h>"] = { "<C-w>h", "window left" },
        ["<C-l>"] = { "<C-w>l", "window right" },
        ["<C-j>"] = { "<C-w>j", "window down" },
        ["<C-k>"] = { "<C-w>k", "window up" },

        -- Window resizing

        ["<C-Left>"]  = { "<cmd> vert res +2 <CR>", "window width +" },
        ["<C-Right>"] = { "<cmd> vert res -2 <CR>", "window width -" },
        ["<C-Up>"]    = { "<cmd>res +2 <CR>", "window height +" },
        ["<C-Down>"]  = { "<cmd>res -2 <CR>", "window height -" },

        ["<leader>="] = { "<C-w>=", "adjust viewports " },

        -- quit dont save
        ["<leader>qq"] = { "<cmd> quitall! <cr>", "quit/close all windows, don't save" },

        -- ["Q"] = { "<cmd> q!<cr>", "quit now" },

        -- easier horizontal scrolling
        ["zl"] = { "zL", "horizontal scroll left" },
        ["zh"] = { "zH", "horizontal scroll right" },

        -- Use fast jump to exact location and reserve `` for other usage
        ["''"] = { "``", "jump back to exact location" },

        -- Go to the first non-blank character of a line
        ["0"] = { "^" },
        -- Just in case you need to go to the very beginning of a line
        ["^"] = { "0" },


        ["<leader>ww"] = { "<cmd> set wrap! <CR><cmd> echo 'wrap = '.&wrap <CR>" },

        -- save
        ["<C-s>"] = { "<cmd> update <CR>", "save file" },

        -- Copy all
        ["<leader>Y"] = { "<cmd> %y+ <CR>", "copy whole file" },

        -- line numbers
        ["<BS>n"] = { "<cmd> set nu!<CR><cmd> set rnu!<CR>", "toggle line number" },

        -- option toggle cursor line
        ["<BS>l"] = { "<cmd> set cul!<CR>", "toggle line number" },

        ["<BS>c"] = { "<cmd>cclose<CR><cmd>lclose<CR>", "close quickfix" },

        ["<BS>d"] = { "<cmd>DelayTrainToggle<CR>", "disable delay train" },


        ["<leader>dgH"] = { ":lua require'spike.diagnostics'.set_diagnostics_level(-1)<CR>", "hide all diagnostics"},
        ["<leader>dge"] = { ":lua require'spike.diagnostics'.set_diagnostics_level(1)<CR>", "diagnostic severity level error"},
        ["<leader>dgw"] = { ":lua require'spike.diagnostics'.set_diagnostics_level(2)<CR>", "diagnostic severity level warning"},
        ["<leader>dgi"] = { ":lua require'spike.diagnostics'.set_diagnostics_level(3)<CR>", "diagnostic severity level info"},
        ["<leader>dgh"] = { ":lua require'spike.diagnostics'.set_diagnostics_level(4)<CR>", "diagnostic severity level hint"},

        -- update nvchad
        -- ["<leader>uu"] = { "<cmd> :NvChadUpdate <CR>", "update nvchad" },


        -- lua source current file
        ["<leader>."] = { "<cmd> :w | source %<CR>", "save and source script " },
        ["<leader>rm"] = { function()
            local ok, core = pcall(require, "core")
            if not ok then
                return
            end
            -- reload nvchad mappings
            require("plenary.reload").reload_module("core.utils")
            require("plenary.reload").reload_module("core.default_config")
            require("plenary.reload").reload_module("core.mappings")
            require("core.utils").load_mappings()
            print("mappings reloaded !")
        end, "config reload mappings" },

        ["<leader>ss"] = { "<cmd> mks! <CR>", "save session" },
        ["<leader>sl"] = { "<cmd> source Session.vim <CR>", "load session" },

        ["<leader>tt"] = {
            function()
                require("base46").toggle_theme()
            end,
            "toggle theme",
        },



        -- luasnip edit snippets
        ["<leader>sne"] = {
            function()
                require("luasnip.loaders").edit_snippet_files()
            end,
            "luasnip edit snippets"
        },

        -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
        -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
        -- empty mode is same as using <cmd> :map
        -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
        -- ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
        -- ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
        ["j"] = { "gj" },
        ["k"] = { "gk" },

        -- new buffer
        ["<leader>bb"] = { "<cmd> enew <CR>", "new buffer" },
        ["<leader>bv"] = { "<cmd> enew <CR>", "new buffer" },

        -- new tab
        ["<leader><Tab>"] = { "<cmd> tabe <CR>", "new tab" },


        -- Fast tab NOTE:these are used for screen movements
        -- ["<S-H>"] = { "gT", "Previous tab" },
        -- ["<S-L>"] = { "gt", "Previous tab" },

        -- close buffer + hide terminal buffer
        ["<leader>x"] = {
            function()
                require("core.utils").close_buffer()
            end,
            "close buffer",
        },

        -- quick close window
        ["<C-x><C-x>"] = { "<C-w>c", "close window" },

        -- Increase number is with double <C-a> and decrease with simple C-x


        -- yank from cusor to eol to system and primary clipboard
        -- Y handles until end of line
        -- yy handles linewise
        -- ["<leader>y"] = { '"*y$"+y$', "yank from cursor to eol to primary and clipboard" },

        -- folding levels
        -- ["<leader>fd"] = { function()
        --   vim.ui.select({"fold level 0", "1", "2", "3", "4", "5", "6", "7"},
        --   {
        --     prompt = "fold lvl: ",
        --   },
        --   function(item, idx)
        --     P(idx)
        --     -- local foldlevel = tonumber(item)
        --     -- if foldlevel == nil then P("need number for fold level !") end
        --     -- vim.o.foldlevel = foldlevel
        --   end)
        -- end,
        --
        -- "set fold level"},
        ["<leader>f0"] = { ":set foldlevel=0<CR>", "set fold level" },
        ["<leader>f1"] = { ":set foldlevel=1<CR>", "set fold level" },
        ["<leader>f2"] = { ":set foldlevel=2<CR>", "set fold level" },
        ["<leader>f3"] = { ":set foldlevel=3<CR>", "set fold level" },
        ["<leader>f4"] = { ":set foldlevel=4<CR>", "set fold level" },
        -- ["<leader>f5"] = { ":set foldlevel=5<CR>", "set fold level" },
        -- ["<leader>f6"] = { ":set foldlevel=6<CR>", "set fold level" },
        -- ["<leader>f7"] = { ":set foldlevel=7<CR>", "set fold level" },
        -- ["<leader>f8"] = { ":set foldlevel=8<CR>", "set fold level" },
        -- ["<leader>f9"] = { ":set foldlevel=9<CR>", "set fold level" },

        ["<leader>tf"] = { "<cmd> set foldmethod=expr<CR>|<cmd> set foldexpr=nvim_treesitter#foldexpr()<CR>",
            "enable Treesitter folding" },

        ["<leader>tp"] = {
            function()
                vim.cmd("TSPlaygroundToggle")
            end,
            "Treesitter playground"
        },

        -- Moving lines around
        ["<M-Down>"] = { "<cmd>:m +1<CR>==", "move line up" },
        ["<M-Up>"] = { "<cmd>:m .-2<CR>==", "move line up" },

        -- syntax-tree-surfer
        -- visual selection from nomral mode
        ["vm"] = { "<cmd>STSSelectMasterNode<CR>", "select master node" },
        ["vn"] = { "<cmd>STSSelectCurrentNode<CR>", "select current node" },

        -- normal mode swapping
        -- swappint up/down

        ["vU"] = { function()
            vim.opt.opfunc = "v:lua.STSSwapUpNormal_Dot"
            return "g@l"
        end, "TS swap Up master node with sibling", opts = { expr = true } },
        ["<BS><Up>"] = { function()
            vim.opt.opfunc = "v:lua.STSSwapUpNormal_Dot"
            return "g@l"
        end, "TS swap Up master node with sibling", opts = { expr = true } },

        ["vD"] = { function()
            vim.opt.opfunc = "v:lua.STSSwapDownNormal_Dot"
            return "g@l"
        end, "TS swap Down master node with sibling", opts = { expr = true } },
        ["<BS><Down>"] = { function()
            vim.opt.opfunc = "v:lua.STSSwapDownNormal_Dot"
            return "g@l"
        end, "TS swap Down master node with sibling", opts = { expr = true } },


        -- swapping left/right sibling nodes
        ["<M-Right>"] = { function()
            vim.opt.opfunc = "v:lua.STSSwapCurrentNodeNextNormal_Dot"
            return "g@l"
        end, "TS swap right with sibling", opts = { expr = true } },

        ["<M-Left>"] = { function()
            vim.opt.opfunc = "v:lua.STSSwapCurrentNodePrevNormal_Dot"
            return "g@l"
        end, "TS swap left with sibling", opts = { expr = true } },

        ["]e"] = { "<cmd> cn <CR>", "quickfix next error" },
        ["[e"] = { "<cmd> cp <CR>", "quickfix previous error" },


        -- Tabularize mappings
        ["<leader>a&"]     = { "<cmd> Tabularize /&<CR>" },
        ["<leader>a="]     = { "<cmd> Tabularize /^[^=]*\zs=<CR>" },
        ["<leader>a:"]     = { "<cmd> Tabularize /:<CR>" },
        ["<leader>a,"]     = { "<cmd> Tabularize /,<CR>" },
        ["<leader>a<Bar>"] = { "<cmd> Tabularize /<Bar><CR>" },


        ["g."] = { ":cwd<CR>", "change dir to current file", opts = { remap = true } },
        ["<leader>g."] = { ":Gcd<CR>", "change dir to git root" },


        -- Packer commands
        --
        -- PackerSnapshot
        ["<leader>pS"] = { function()
            local snapname = "snapshot_" .. os.date("%Y_%m_%d_%H%M")
            local packer = require 'packer'
            packer.snapshot(snapname)
        end
            , "packer snapshot" },
        ["<leader>pst"] = { "<cmd> PackerStatus<CR>", "packer status" },
        -- ["<leader>psc"] = { "<cmd> PackerSync<CR>", "packer sync" },
        ["<leader>pc"] = { "<cmd> PackerCompile<CR>", "packer compile" },

        ["<leader>pr"] = { function()

            -- require("plenary.reload").reload_module("plugins")
            -- require("plenary.reload").reload_module("custom.plugins")
            -- vim.cmd "LuaCacheClear"
            -- package.loaded["plugins"] = nil
            --
            -- package.loaded["custom.plugins"] = nil
            -- dofile(vim.fn.stdpath("config") .. '/lua/plugins/init.lua')
            -- dofile(vim.fn.stdpath("config") .. '/lua/custom/plugins/init.lua')
            --
            require("spike.utils").unload_lua_ns("plugins")
            require("spike.utils").unload_lua_ns("custom")
            require("plugins")
            -- require("spike.utils").unload_lua_ns("custom")
            vim.cmd "PackerCompile"
            print("reloaded plugin config !")
        end,
            "packer reload/compile"
        },

        -- Notify cmd watcher (see /scripts/utils/fifo_watch.sh)
        --[[ ["<leader><down>"] = {
                    function()
                        local fifo_patch = "/tmp/fifo_vimnotify"
                        os.execute("echo do >" .. fifo_patch)
                    end,
                    "notify <scripts/utils/fifo_watch>"
                }, ]]


        -- TODO: move to lspconfig section
        -- ["<leader>lsp"] = { "<cmd> lua require('custom.plugins.configs.navigator').enable()<CR>", "lsp enable"},
        ["<leader>lsp"] = { "<cmd> LspStart<CR>", "lsp enable" },
        ["<M-s><M-s>"] = { "<cmd> LspStart<CR>", "lsp enable" },
        ["<M-t><M-t>"] = { "<cmd> LspStop<CR>", "lsp disable" },
        ["<leader>lst"] = { "<cmd> LspStop<CR>", "lsp disable" },



        ---------------
        -- Programming languages specifics
        ---------------

        -- config files
        ["<leader>ev"] = { "<cmd> source ~/.config/nvim/Session.vim<CR>", "edit vim config" },
    }, --}}}

    t = { ["<C-x>"] = { termcodes "<C-\\><C-N>", "escape terminal mode" } },

    v = { --{{{


        -- yank from cursor to eol to system and primary clipboard
        ["<leader>y"] = { '"*y gv"+y', "yank line to clipboards" },

        -- visual shifting
        ["<"] = { "<gv" },
        [">"] = { ">gv" },

        -- Allow using the repeat operator with a visual selection (!)
        -- http://stackoverflow.com/a/8064607/127816
        ["."] = { ":normal .<CR>", opts = { silent = true } },

        -- Tabularize mappings
        ["<leader>a&"]     = { "<cmd> Tabularize /&<CR>" },
        ["<leader>a="]     = { "<cmd> Tabularize /^[^=]*\zs=<CR>" },
        ["<leader>a:"]     = { "<cmd> Tabularize /:<CR>" },
        ["<leader>a,"]     = { "<cmd> Tabularize /,<CR>" },
        ["<leader>a<Bar>"] = { "<cmd> Tabularize /<Bar><CR>" },

    }, --}}}

    -- command line mappings
    c = { --{{{
        ["Tabe"] = { "tabe" },

        -- Change Working Directory to that of the current file
        ["cwd"] = { "lcd %:p:h", "change dir to current file" },
        ["cd."] = { "lcd %:p:h", "change dir to current file" },
        ["w!!"] = { "w !doas tee %", "write file with root perms" },
        ["%%"]  = { "<C-R>=fnameescape(expand('%:h')).'/'<cr>",
            "alias to current working dir" },
        ["Tab"] = { "Tabularize" },


        ["%c"] = { "~/.config/nvim/", "shortcut to nvim config dir" },
        -- ["tsf"] = { "set foldmethod=expr | set foldexpr=nvim_treesitter#foldexpr()",
        -- "enable Treesitter folding"}
    }, --}}}


    -- operator pending
    o = {
        ["S"] = { "<Plug>(leap-forward-to)", opts = { remap = true} },
    },

    -- select mode (with completion) see after/plugin/mappings.*
    s = {
        ["<BS><BS>"] = {"<BS>i", "delete then go insert"},
    },

    -- visual exclusive mode (ignore select)
    x = { -- {{{

        -- ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
        -- ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
        ["j"] = { "gj" },
        ["k"] = { "gk" },

        -- Don't copy the replaced text after pasting in visual mode
        -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
        ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', opts = { silent = true } },

        -- syntax-tree-surfer
        ["J"] = { "<cmd>STSSelectNextSiblingNode<CR>", "select next sibling node" },
        ["K"] = { "<cmd>STSSelectPrevSiblingNode<CR>", "select prev sibling node" },
        ["H"] = { "<cmd>STSSelectParentNode<CR>", "select prev sibling node" },
        ["L"] = { "<cmd>STSSelectChildNode<CR>", "select prev sibling node" },

        -- swap nodes tip: start first with master/child node selection then use these
        ["<M-Up>"] = { "<cmd>STSSwapPrevVisual<CR>", "swap prev sibling node" },
        ["<M-Left>"] = { "<cmd>STSSwapPrevVisual<CR>", "swap prev sibling node" },
        ["<M-Down>"] = { "<cmd>STSSwapNextVisual<CR>", "swap next sibling node" },
        ["<M-Right>"] = { "<cmd>STSSwapNextVisual<CR>", "swap next sibling node" },

    }, -- }}}
} --}}}

M.tabufline = { --{{{
    plugin = true,

    n = {
        -- cycle through buffers
        ["<C-b>"] = {
            function()
                require("core.utils").tabuflineNext()
            end,
            "goto next buffer",
        },

        ["<C-f>"] = {
            function()
                require("core.utils").tabuflinePrev()
            end,
            "goto prev buffer",
        },

        -- pick buffers via numbers
        ["<Bslash>"] = { "<cmd> TbufPick <CR>", "Pick buffer" },
    },
} --}}}

M.comment = { --{{{
    plugin = true,

    -- toggle comment in both modes
    n = {
        ["<leader>/"] = {
            function()
                -- require("Comment.api").toggle.linewise.current()
                vim.notify("use gcc !")
            end,
            "toggle comment",
        },
    },

    v = {
        ["<leader>/"] = {
            function()
                vim.notify("use gcc !")
            end,
            -- "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
            "toggle comment",
        },
    },
} --}}}

M.lspconfig = { --{{{
    plugin = true,

    -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

    n = {
        ["gD"] = {
            function()
                vim.lsp.buf.declaration()
            end,
            "lsp declaration",
        },

        ["gd"] = {
            function()
                vim.lsp.buf.definition()
            end,
            "lsp definition",
        },

        ["K"] = {
            function()
                vim.lsp.buf.hover()
            end,
            "lsp hover",
        },

        ["gm"] = {
            function()
                vim.lsp.buf.implementation()
            end,
            "lsp implementation",
        },

        ["<leader>ls"] = {
            function()
                vim.lsp.buf.signature_help()
            end,
            "lsp signature_help",
        },

        ["<leader>D"] = {
            function()
                vim.lsp.buf.type_definition()
            end,
            "lsp definition type",
        },

        ["<leader>ra"] = {
            function()
                require("nvchad_ui.renamer").open()
            end,
            "lsp rename",
        },

        ["<leader>ca"] = {
            function()
                vim.lsp.buf.code_action()
            end,
            "lsp code_action",
        },

        ["gr"] = {
            function()
                vim.lsp.buf.references()
            end,
            "lsp references",
        },

        ["<leader>f"] = {
            function()
                vim.diagnostic.open_float()
            end,
            "lsp floating diagnostic",
        },

        ["[d"] = {
            function()
                vim.diagnostic.goto_prev()
            end,
            "lsp goto prev",
        },

        ["d]"] = {
            function()
                vim.diagnostic.goto_next()
            end,
            "lsp goto_next",
        },

        ["<leader>q"] = {
            function()
                vim.diagnostic.setloclist()
            end,
            "lsp diagnostic setloclist",
        },

        ["<leader>fm"] = {
            function()
                vim.lsp.buf.formatting {}
            end,
            "lsp formatting",
        },

        ["<leader>wa"] = {
            function()
                vim.lsp.buf.add_workspace_folder()
            end,
            "lsp add workspace folder",
        },

        ["<leader>wr"] = {
            function()
                vim.lsp.buf.remove_workspace_folder()
            end,
            "lsp remove workspace folder",
        },

        ["<leader>wl"] = {
            function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            "lsp list workspace folders",
        },
    },
} --}}}

M.dap = { -- {{{
    plugin = true,
    n = {
        ["<leader>ds"] = {
            function()
                local mydap = require("spike.dap")

                mydap.setup()
                require('spike.dap.utils').init_breakpoints()
                -- set a breakpoint at current line if there are none in
                --  the project

                if vim.o.filetype == "go" then
                    mydap.go_debug()
                elseif vim.o.filetype == "rust" then
                    local rt = require("rust-tools")
                    -- make sure lsp is running ?
                    rt.debuggables.debuggables()
                end
            end,
            "start dap session"
        },

        ["<leader>dS"] = {
            function()
                if vim.o.filetype == "go" then
                    vim.cmd("GoDbgStop")
                end
            end,
            "stop dap session"
        },

        ["<leader>dd"] = { "<cmd> DapToggleBreakpoint <CR>" },

        ["<leader>dc"] = {
            function()
                vim.ui.input({ prompt = "condition> " }, function(input)
                    require("dap").set_breakpoint(input)
                end)
            end,
            "dap conditional breakpoint"
        },
        ["<leader>dm"] = {
            function()
                require('spike.dap.dapmode').start()
            end,
            "enter dap mode"
        },
        ["<leader>dr"] = { "<cmd>lua require'dap'.run_last()<CR>", "[dap] rerun last" },
        ["<leader>dl"] = {
            function()
                require('spike.dap.utils').dap_logpoint()
            end,
            "[dap] add log point"
        },
        ["<leader>dt"] = { "<cmd>lua require'dapui'.toggle()<CR>", "[dap] toggle UI" },
    },

} -- }}}

M.nvimtree = { --{{{
    plugin = true,

    n = {
        -- toggle
        ["<Left>"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
    },
} --}}}

M.fzf_lua = { --{{{
    plugin = true,

    n = {
        -- find
        -- ["<C-p>"] = { "<cmd> FzfLua files <CR>", "FzfLua find files" },
        -- ["<C-p>"] = { function ()
        --   local ignored_bufs = {
        --     "qf",
        --   }
        --   for _, ignored in ipairs(ignored_bufs) do
        --     if vim.bo.filetype == ignored then
        --       local default_keyseq = termcodes("<C-p>")
        --       vim.api.nvim_feedkeys(default_keyseq, 'n', false)
        --       return
        --     end
        --   end
        --   vim.cmd "FzfLua files"
        -- end, "FzfLua find files" },

        ["<leader>fl"] = { "<cmd> FzfLua lines <CR>", "FzfLua grep open buffer lines" },

        -- grep
        -- ["<leader>fw"] = { "<cmd> FzfLua grep_cword <CR>", "FzfLua grep cword" },
        ["<leader>ff"] = { "<cmd> FzfLua live_grep_native <CR>", "FzfLua grep live native" },
        -- ["<leader>ff"] = { "<cmd> FzfLua grep_project <CR>", "FzfLua grep live project" },
        ["<leader>f*"] = { "<cmd> FzfLua live_grep_glob <CR>", "FzfLua grep with glob (SPACE-- globs)" },

        -- continue
        -- ["<leader>fr"] = { "<cmd> FzfLua resume <CR>", "FzfLua resume last search" },

        -- ["<leader>;"] = { "<cmd> FzfLua buffers <CR>", "FzfLua find buffers" },
        -- ["<leader>fb"] = { "<cmd> FzfLua builtin <CR>", "FzfLua builtins" },
        -- ["<leader>fh"] = { "<cmd> FzfLua help_tags <CR>", "FzfLua find help pages" },
        -- ["<leader>fm"] = { "<cmd> FzfLua marks <CR>", "FzfLua marks" },
        -- ["<leader>fo"] = { "<cmd> FzfLua oldfiles <CR>", "FzfLua find oldfiles" },
        -- ["<leader>tk"] = { "<cmd> FzfLua keymaps <CR>", "FzfLua show keymaps" },

    }
} --}}}

M.telescope = { --{{{
    plugin = true,

    n = {
        -- find
        -- ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "find files" },
        -- ["<C-p>"] = { "<cmd> Telescope find_files <CR>", "find files" },
        --
        ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "find all" },
        ["<C-p>"] = {
            function()
                local ignored_bufs = {
                    "qf",
                    "guihua",
                    "NvimT*",
                    "aerial*",
                }
                for _, ignored in ipairs(ignored_bufs) do
                    if vim.o.filetype:match(ignored) then
                        local default_keyseq = termcodes("<C-p>")
                        vim.api.nvim_feedkeys(default_keyseq, 'n', false)
                        return
                    end
                end
                vim.cmd "Telescope find_files"
            end, "FzfLua find files"
        },
        ["<leader>f."] = { "<cmd> Telescope live_grep <CR>", "telescope live grep" },
        ["<leader>fw"] = { "<cmd> Telescope grep_string <CR>", "telescope grep cword" },
        ["<leader>;"] = { "<cmd> Telescope buffers <CR>", "telescope find buffers" },
        ["<leader>fb"] = { "<cmd> Telescope builtin <CR>", "telescope builtins" },
        ["<leader>fB"] = { "<cmd> Telescope vim_bookmarks <CR>", "telescope bookmarks" },
        ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "help page" },
        ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "telescope find oldfiles" },
        ["<leader>fm"] = { "<cmd> Telescope marks <CR>", "Telescope marks" },
        ["<leader>fM"] = { "<cmd> Telescope man_pages <CR>", "Telescope marks" },
        ["<leader>tk"] = { "<cmd> Telescope keymaps <CR>", "Telescope show keys" },
        ["<leader>fr"] = { "<cmd> Telescope resume <CR>", "telescope resume last search" },
        ["<leader>fc"] = { "<cmd> Telescope commands <CR>", "telescope commands" },

        -- git
        ["<leader>fg"] = { " ", "telescope git commands" },
        ["<leader>fgc"] = { "<cmd> Telescope git_commits <CR>", "teles git commits" },
        ["<leader>fgs"] = { "<cmd> Telescope git_status <CR>", "teles git status" },
        ["<leader>fgf"] = { "<cmd> Telescope git_files <CR>", "teles git files" },

        -- pick a hidden term
        -- ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "pick hidden term" },

        -- theme switcher
        ["<leader>th"] = { "<cmd> Telescope themes <CR>", "nvchad themes" },
    },
} --}}}

M.nvterm = { --{{{
    plugin = true,

    t = {
        -- toggle in terminal mode
        ["<A-i>"] = {
            function()
                require("nvterm.terminal").toggle "float"
            end,
            "toggle floatinvg term",
        },

        ["<A-h>"] = {
            function()
                require("nvterm.terminal").toggle "horizontal"
            end,
            "toggle horizontal term",
        },
    },

    n = {
        -- toggle in normal mode
        ["<A-i>"] = {
            function()
                require("nvterm.terminal").toggle "float"
            end,
            "toggle floating term",
        },

        ["<A-h>"] = {
            function()
                require("nvterm.terminal").toggle "horizontal"
            end,
            "toggle horizontal term",
        },

        ["<A-v>"] = {
            function()
                require("nvterm.terminal").toggle "vertical"
            end,
            "toggle vertical term",
        },

        -- new

        ["<leader>h"] = {
            function()
                require("nvterm.terminal").new "horizontal"
            end,
            "new horizontal term",
        },

        ["<leader>v"] = {
            function()
                require("nvterm.terminal").new "vertical"
            end,
            "new vertical term",
        },


        -- Running commands
        ["<leader>rf"] = {function()
            local nvterm_utils = require('spike.utils.nvterm')
            nvterm_utils.run_cmd(nil, { mode = "float" })
        end, "run cmd in floating terminal"},

        ["<leader>rv"] = {function()
            local nvterm_utils = require('spike.utils.nvterm')
            nvterm_utils.run_cmd(nil, { mode = "vertical" })
        end, "run cmd in vertical terminal"},


        ["<leader><UP>"] = {function()
            local nvterm_utils = require('spike.utils.nvterm')
            nvterm_utils.rerun_last_cmd()
        end, "rerun last float term cmd"},
    },
} --}}}

M.whichkey = { --{{{
    plugin = true,

    n = {
        ["<leader>wK"] = {
            function()
                vim.cmd "WhichKey"
            end,
            "which-key all keymaps",
        },
        ["<leader>wk"] = {
            function()
                local input = vim.fn.input "WhichKey: "
                vim.cmd("WhichKey " .. input)
            end,
            "which-key query lookup",
        },
    },
} --}}}

M.blankline = { --{{{
    plugin = true,

    n = {
        ["<BS>k"] = {
            function()
                local ok, start = require("indent_blankline.utils").get_current_context(
                    vim.g.indent_blankline_context_patterns,
                    vim.g.indent_blankline_use_treesitter_scope
                )

                if ok then
                    vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
                    vim.cmd [[normal! _]]
                end
            end,

            "Jump to current context",
        },
    },
} --}}}

-- code outline panel
M.aerial = {
    plugin = true,
    n = {
        ["<Right>"] = { "<cmd> AerialToggle right<CR>" },
    }
}

M.asyncrun = { --{{{
    plugin = true,

    n = {
        -- TODO: find new mapping to close quickfix
        -- ["``"] = { "<cmd> call asyncrun#quickfix_toggle(8)<CR>", "toggle quickfix window" },
        -- HELP: 
        -- adding ! after AsyncRun disables autoscroll
        ["<leader>m"] = { ":AsyncRun -program=" .. vim.o.makeprg .. "<CR>", "make using quickfix asyncrun" },
        ["<leader>mf"] = { function()
            require('spike.utils.nvterm').run_cmd(vim.o.makeprg, { mode = "float"} )
        end, "run make in a floating terminal" },
        ["<leader>rx"] = {function()
            vim.ui.input( { prompt="tmux cmd:> " }, function (input)
                vim.cmd("AsyncRun -mode=term -pos=tmux " .. input)
            end)
        end, "custom asyncrun command (tmux)" },
        ["<leader>pd"] = { "<cmd> AsyncRun lpr -P PDF_PRINT %<CR>", "PDF print file" },
        ["<leader>pp"] = { "<cmd> AsyncRun lpr %<CR>" },
    },
} --}}}

M.overseer = {
    plugin = true,
    n = {
        ["<leader>oo"] = {"<cmd> OverseerOpen <CR>", "open overseer"},
        ["<leader>ot"] = {"<cmd> OverseerToggle <CR>", "open overseer"},
    }
}

M.vim_bookmarks = { --{{{
    n = {
        ["<BS>m"] = { "<cmd> Telescope vim_bookmarks<CR>", "show bookmarks" },
        ["mk"] = { "<cmd> BookmarkToggle<CR>", "toggle bookmarks" },
        ["<leader>mm"] = { "<cmd> BookmarkAnnotate<CR>", "annotation bookmarks" },
        ["<leader>mc"] = { "<cmd> BookmarkClear<CR>", "clear bookmarks in buffer" },
        ["<leader>mx"] = { "<cmd> BookmarkClearAll<CR>", "clear bookmarks in all buffers" },
        ["]b"] = { "<cmd>BookmarkNext<CR>", "jump to next bookmark" },
        ["[b"] = { "<cmd>BookmarkNext<CR>", "jump to prev bookmark" },
    },
} --}}}

M.iron = { -- {{{{{{
    plugin = true,
    n = {
        ["<leader>ir"] = { "<cmd>IronRepl<CR>", "start IronRepl" },
    }
}
-- }}}
--
-- color picker
M.ccc = {
    plugin = true,
    n = {
        ["<leader>cp"] = { "<cmd>CccPick<CR>", "color picker" }
    },
}
-- }}}

-- M.neorepl = {{{{
--   plugin = true,
--
--   i = {
--     ["C-p"] = { "<Plug>(neorepl-hist-prev)"},
--   }
--
-- }
-- }}}

M.vimux = {
    plugin = true,
    n = {
        -- rerun last
        ["<leader><Down>"] = { "<cmd>VimuxRunLastCommand<CR>", "vimux run last command" },
        -- prompt
        ["<leader>vv"] = { "<cmd>VimuxPromptCommand<CR>", "vimux prompt command" },
        ["<leader>vc"] = { "<cmd>VimuxInterruptRunner<CR>", "vimux interrupt command" },
        ["<leader>vl"] = { "<cmd>VimuxClearTerminalScreen<CR>", "vimux clear terminal" },
        ["<leader>vx"] = { "<cmd>VimuxCloseRunner<CR>", "vimux close runner" },
    }
}

-- extra mappings for golang
M.gonvim = {
    plugin = true,
    n = {
        -- ["<leader>da"] = { "<cmd> GoDebug -a<CR>", "go debug attach" },
        ["<leader>gotf"] = { "<cmd> GoTestFunc<CR>" },
    }
}

M["todo-comments"] = {
    plugin = true,
    n = {
        ["]t"] = { "<cmd> lua require'todo-comments'.jump_next()<CR>", "jump to next todo" },
        ["[t"] = { "<cmd> lua require'todo-comments'.jump_prev()<CR>", "jump to prev todo" },
        ["<leader>qt"] = { "<cmd> TodoQuickFix <CR>", "todo quickfix" },
        ["<leader>ft"] = { "<cmd> TodoTelescope <CR>", "todo telescope" },
    }
}

-- git
M.gitsigns = {
    plugin = true,
    n = {
        ["<leader>gs"] = { "<cmd> lua require'gitsigns'.stage_hunk()<CR>",
            "Git stage hunk",
        },
        ["<leader>gS"] = { "<cmd> lua require'gitsigns'.stage_buffer()<CR>",
            "Git stage buffer",
        },
        ["<leader>gR"] = { "<cmd> lua require'gitsigns'.reset_buffer_index()<CR>",
            "Unstage all hunks for current buffer in the index",
        },
        ["<leader>gr"] = { "<cmd> lua require'gitsigns'.reset_buffer()<CR>",
            "Reset the lines of all hunks in the buffer",
        },
        ["<leader>gp"] = { "<cmd> lua require'gitsigns'.preview_hunk()<CR>",
            "Git preview hunk",
        },
        ["<leader>gu"] = { "<cmd> lua require'gitsigns'.undo_stage_hunk()<CR>",
            "Git undo stage hunk",
        },
        ["]h"] = { "<cmd> lua require'gitsigns'.next_hunk()<CR>",
            "Git next hunk",
        },
        ["[h"] = { "<cmd> lua require'gitsigns'.prev_hunk()<CR>",
            "Git prev hunk",
        }
    }
}

M.grapple = {
    plugin = true,
    n = {
        ["<leader>J"] = { "<cmd> lua require'grapple'.cycle_forward()<CR>" },
        ["<leader>K"] = { "<cmd> lua require'grapple'.cycle_backward()<CR>" },
        ["<leader>T"] = { "<cmd> GrappleTag<CR>"},
        ["<leader>N"] = { function()
            vim.ui.input({ prompt = "tag: " }, function(input)
                require("grapple").tag({ key = input })
            end)
        end, "grapple tag with name" },
        --TODO: keybind for popup select names
        ["<leader><leader>m"] = { "<cmd> lua require'grapple'.select({key='mappings'})<CR>" },
        ["<leader><leader>p"] = { "<cmd> lua require'grapple'.select({key='plugins'})<CR>" },
        ["<leader><leader>P"] = { "<cmd> lua require'grapple'.select({key='Plugins'})<CR>" },
        ["<leader><leader>g"] =  { "<cmd> lua require'grapple'.popup_tags()<CR>" },
    }
}

local function get_zk_notedirs()
            local abs_dirs = vim.fn.system("fd . -t d " .. vim.env['ZK_NOTEBOOK_DIR'])
            local note_dirs = {}
            for _,v in ipairs(vim.split(abs_dirs, "\n")) do
                local ndir = string.gsub(v, vim.env['ZK_NOTEBOOK_DIR'] .. '/', '')
                ndir = ndir:gsub("(.*)(/)$", "%1")
                if ndir ~= "" then
                    table.insert(note_dirs,ndir)
                end
            end

            vim.ui.select(note_dirs, { prompt = "dir:> " },
            function(choice)
                if choice then
                    require("zk.commands").get("ZkNew")({ dir = choice })
                end
            end)
end

M.zk = {
    plugin = true,
    n = {
        ["<leader>zk"] = {function()
            vim.ui.input({ prompt = "note title:"}, function (input)
                if input then
                    require("zk.commands").get("ZkNew")({ title = input})
                end
            end)
        end, "zk new note"},
        ["<leader>zK"] = {get_zk_notedirs, "zk new note, custom dir"},
        ["<leader>zo"] = {"<Cmd>ZkNotes { sort = { 'modified' }}<CR>","zk list notes"},
        ["<leader>zt"] = {"<Cmd>ZkTags<CR>","zk list tags"},
        -- ["<leader>zf"] = {"<Cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>","zk notes matching a given query"},
        ["<leader>zf"] = {function()
            vim.ui.input({ prompt = "zk match:"}, function (input)
                if input then
                    require("zk.commands").get("ZkNotes")({ sort = { "modified" }, match = input})
                end
            end)
        end,"zk notes matching a given query"},
        ["<leader>zl"] = {"<Cmd>ZkLinks<CR>","zk links"},
        ["<leader>zh"] = {"<Cmd>ZkBacklinks<CR>","zk backlinks"},
        -- mappings to lsp commands are in zk.lua config file
    }
}

M.copilot = {
    plugin = true,
    n = {
        -- copilot options here
    }
}

M.navigator = {
    plugin = true,
    n = {
        ["<leader>gt"] = { function() require('navigator.treesitter').buf_ts() end, 'TS buf symbols'},
        ["<leader>gT"] = { function() require('navigator.treesitter').bufs_ts() end, 'TS bufs symbols'},
        ['<Leader>ct'] = { function() require('navigator.ctags').ctags() end, 'lsp ctags' },
    }
}

M.refactoring = {
    plugin = true,
    v = {
        ["<leader>rr"] = {":lua require'refactoring'.select_refactor()<CR>", "refactoring using telescope", opts = { expr = false }},
    }
}

return M
