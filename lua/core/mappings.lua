-- n, v, i, t, c = mode name.s

local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local M = {}

M.general = {
  i = {

    ["jk"] =    { "<esc>", "escape"},

    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "move left" },
    ["<C-l>"] = { "<Right>", "move right" },
    ["<C-j>"] = { "<Down>", "move down" },
    ["<C-k>"] = { "<Up>", "move up" },

    ["<C-s>"] = { "<cmd> update <CR>", "update file (save on changes)"},

    -- luasnip change choice 
    ["<C-u>"] = {"<Plug>luasnip-next-choice", "change luasnip choice"},
  },

  n = {
    ["<ESC>"] = { "<cmd> noh <CR>", "no highlight" },

    -- switch between windows
    ["<C-h>"] = { "<C-w>h", "window left" },
    ["<C-l>"] = { "<C-w>l", "window right" },
    ["<C-j>"] = { "<C-w>j", "window down" },
    ["<C-k>"] = { "<C-w>k", "window up" },

    -- Window resizing

    ["<C-Left>"]  = { "<cmd> vert res +2 <CR>", "window width +" },
    ["<C-Right>"]  = { "<cmd> vert res -2 <CR>", "window width -" },
    ["<C-Up>"]  = { "<cmd>res +2 <CR>", "window height +" },
    ["<C-Down>"]  = { "<cmd>res -2 <CR>", "window height -" },

    -- quit dont save
    ["<leader>qq"] = {"<cmd> quitall! <cr>", "quit/close all windows, don't save"},

    ["Q"] = {"<cmd> q!<cr>", "quit now"},

    -- easier horizontal scrolling
    ["zl"] = {"zL", "horizontal scroll left"},
    ["zh"] = {"zH", "horizontal scroll right"},

   -- Use fast jump to exact location and reserve `` for other usage
   ["''"] = {"``", "jump back to exact location"},

   -- Go to the first non-blank character of a line
   ["0"] = {"^"},
   -- Just in case you need to go to the very beginning of a line
   ["^"] = {"0"},


   ["<leader>ww"] = { "<cmd> set wrap! <CR><cmd> echo 'wrap = '.&wrap <CR>"},

    -- save
    ["<C-s>"] = { "<cmd> update <CR>", "save file" },

    -- Copy all
    ["<C-c>"] = { "<cmd> %y+ <CR>", "copy whole file" },

    -- line numbers
    ["<leader>n"] = { "<cmd> set nu! <CR>", "toggle line number" },
    ["<leader>rn"] = { "<cmd> set rnu! <CR>", "toggle relative number" },

    -- update nvchad
    ["<leader>uu"] = { "<cmd> :NvChadUpdate <CR>", "update nvchad" },

    ["<leader>tt"] = {
      function()
        require("base46").toggle_theme()
      end,
      "toggle theme",
    },

    -- luasnip edit snippets
    ["<leader>se"] = {
      function()
        require("luasnip.loaders").edit_snippet_files()
      end,
      "luasnip edit snippets"},

    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    -- ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    -- ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
     ["j"] = { "gj" },
     ["k"] = { "gk" },

    -- new buffer
    ["<S-b>"] = { "<cmd> enew <CR>", "new buffer" },

    -- new tab
    ["<leader><Tab>"] = {"<cmd> tabe <CR>", "new tab"},


    -- Fast tab
    ["<S-H>"]  = { "gT", "Previous tab"},
    ["<S-L>"]  = { "gt", "Previous tab"},

    -- close buffer + hide terminal buffer
    ["<leader>xx"] = {
      function()
        require("core.utils").close_buffer()
      end,
      "close buffer",
    },
    ["<Down>"] = {"<cmd> close <CR>", "close window"},


    -- yank from cusor to eol to system and primary clipboard
    ["<leader>y"] = {'"*y$"+y$', "yank from cursor to eol to primary and clipboard"},

    -- folding levels
    ["<leader>f0"] = {":set foldlevel=0<CR>", "set fold level"},
    ["<leader>f1"] = {":set foldlevel=1<CR>", "set fold level"},
    ["<leader>f2"] = {":set foldlevel=2<CR>", "set fold level"},
    ["<leader>f3"] = {":set foldlevel=3<CR>", "set fold level"},
    ["<leader>f4"] = {":set foldlevel=4<CR>", "set fold level"},
    ["<leader>f5"] = {":set foldlevel=5<CR>", "set fold level"},
    ["<leader>f6"] = {":set foldlevel=6<CR>", "set fold level"},
    ["<leader>f7"] = {":set foldlevel=7<CR>", "set fold level"},
    ["<leader>f8"] = {":set foldlevel=8<CR>", "set fold level"},
    ["<leader>f9"] = {":set foldlevel=9<CR>", "set fold level"},

    ["<leader>en"] = {"<cmd> cn <CR>", "next error"},
    ["<leader>rp"] = {"<cmd> cp <CR>", "previous error"},


    ["g."] = {":cwd<CR>", "change dir to current file", opts = { remap = true}},

    -- Packer commands
    ["<leader>ps"] = {"<cmd> PackerSync <CR>", "packer sync"},

    -- Notify cmd watcher (see /scripts/utils/fifo_watch.sh)
    ["<leader><leader>,"] = {
      function()
        local fifo_patch="/tmp/fifo_vimnotify"
        os.execute("echo do >" .. fifo_patch )
      end,
      "notify <scripts/utils/fifo_watch>"
    },


    -- config files
    -- ["<leader>ev"] = {
    --   function()
    --     local vim_config_files = {""}
    --   end
    --   , "edit vim config"},
  },

  t = { ["<C-x>"] = { termcodes "<C-\\><C-N>", "escape terminal mode" } },

  v = {
    -- ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    -- ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
     ["j"] = { "gj" },
     ["k"] = { "gk" },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', opts = { silent = true } },

    -- yank from cursor to eol to system and primary clipboard
    ["<leader>y"] = {'"*y gv"+y', "yank line to clipboards"},

    -- visual shifting
    ["<"] = {"<gv"},
    [">"] = {">gv"},

    -- Allow using the repeat operator with a visual selection (!)
    -- http://stackoverflow.com/a/8064607/127816
    ["."] = {":normal .<CR>", opts = { silent = true}},

  },

  -- command line mappings
  c = {
    ["Tabe"] = {"tabe"},

    -- Change Working Directory to that of the current file
    ["cwd"] = {"lcd %:p:h", "change dir to current file"},
    ["cd."] = {"lcd %:p:h", "change dir to current file"},
  }
}

M.tabufline = {
  plugin = true,

  n = {
    -- cycle through buffers
    ["<TAB>"] = {
      function()
        require("core.utils").tabuflineNext()
      end,
      "goto next buffer",
    },

    ["<S-Tab>"] = {
      function()
        require("core.utils").tabuflinePrev()
      end,
      "goto prev buffer",
    },

    -- pick buffers via numbers
    ["<Bslash>"] = { "<cmd> TbufPick <CR>", "Pick buffer" },
  },
}

M.comment = {
  plugin = true,

  -- toggle comment in both modes
  n = {
    ["<leader>/"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "toggle comment",
    },
  },

  v = {
    ["<leader>/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "toggle comment",
    },
  },
}

M.lspconfig = {
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
      "floating diagnostic",
    },

    ["[d"] = {
      function()
        vim.diagnostic.goto_prev()
      end,
      "goto prev",
    },

    ["d]"] = {
      function()
        vim.diagnostic.goto_next()
      end,
      "goto_next",
    },

    ["<leader>q"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "diagnostic setloclist",
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
      "add workspace folder",
    },

    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "remove workspace folder",
    },

    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "list workspace folders",
    },
  },
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<Left>"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
  },
}

M.fzf_lua = {
  plugin = true,

  n = {
    -- find
    ["<C-p>"] = { "<cmd> FzfLua files <CR>", "find files" },

    -- grep
    ["<leader>fw"] = { "<cmd> FzfLua grep_cword <CR>", "grep cword" },
    ["<leader>f."] = { "<cmd> FzfLua live_grep_native <CR>", "grep live native" },
    ["<leader>f*"] = { "<cmd> FzfLua live_grep_glob <CR>", "grep with glob (SPACE-- globs)"},

    -- continue
    ["<leader>ff"] = { "<cmd> FzfLua resume <CR>", "resume last search"},

    ["<leader>;"] =  { "<cmd> FzfLua buffers <CR>", "find buffers" },
    ["<leader>fb"] =  { "<cmd> FzfLua builtins <CR>", "FzfLua builtins" },
    ["<leader>fh"] = { "<cmd> FzfLua help_tags <CR>", "find help pages" },
    ["<leader>fo"] = { "<cmd> FzfLua oldfiles <CR>", "find oldfiles" },
    ["<leader>tk"] = { "<cmd> lua require'custom.plugins.fzflua'.keymaps() <CR>", "show keymaps" },

  }
}


M.telescope = {
  plugin = true,

  n = {
    -- find
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "find files" },
    ["<C-p>"] = { "<cmd> Telescope find_files <CR>", "find files" },

    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "find all" },
    ["<leader>f*"] = { "<cmd> Telescope live_grep <CR>", "live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
    ["<leader>;"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "find oldfiles" },
    ["<leader>tk"] = { "<cmd> Telescope keymaps <CR>", "show keys" },

    -- git
    ["<leader>tg"] = {" ", "telescope git commands"},
    ["<leader>tgc"] = { "<cmd> Telescope git_commits <CR>", "git commits" },
    ["<leader>tgs"] = { "<cmd> Telescope git_status <CR>", "git status" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "pick hidden term" },

    -- theme switcher
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "nvchad themes" },
  },
}

M.nvterm = {
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
  },
}

M.whichkey = {
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
}

M.blankline = {
  plugin = true,

  n = {
    ["<leader>bc"] = {
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

      "Jump to current_context",
    },
  },
}

-- Tagbar equivalent with LSP
M.vista = {
  plugin = true,

  n = {
    ["<Right>"] = { "<cmd> Vista!! <CR>", "toggle Vista "} ,
  },
}

M.asyncrun = {
  plugin = true,

  n = {
    ["``"] = {"<cmd> call asyncrun#quickfix_toggle(8)<CR>", "toggle quickfix window"} ,
    ["<leader>m"] = {":AsyncRun -program=" .. vim.o.makeprg .. "<CR>", "make using asyncrun"},
    ["<leader><leader>r"] = {":AsyncRun ", "custom asyncrun command"},
    ["<leader>pd"] = {"<cmd> AsyncRun lpr -P PDF_PRINT %<CR>", "PDF print file"},
    ["<leader>pp"] = {"<cmd> AsyncRun lpr %<CR>"},
  },
}

return M
