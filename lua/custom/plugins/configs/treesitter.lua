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
        disable = function(lang, bufnr)
            return lang == "help"
        end
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<Space>",
            node_incremental = "<BS>",
            node_decremental = "<Space>",
            scope_incremental = "<CR>",
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
                ["af"] = { query = "@function.outer", desc = "TS function" },
                ["if"] = { query = "@function.inner", desc = "TS function" },
                ["aF"] = { query = "@myfield", desc = "TS field" },
                ["ac"] = { query = "@class.outer", desc = "TS class" },
                ["ic"] = { query = "@class.inner", desc = "TS class" },
                ["aC"] = { query = "@conditional.outer", desc = "TS conditional" },
                ["iC"] = { query = "@conditional.inner", desc = "TS conditional" },
                ["ae"] = { query = "@block.outer", desc = "TS block" },
                ["ie"] = { query = "@block.inner", desc = "TS block" },
                ["al"] = { query = "@loop.outer", desc = "TS loop" },
                ["il"] = { query = "@loop.inner", desc = "TS loop" },
                ["is"] = { query = "@statement.inner", desc = "TS statement" },
                ["as"] = { query = "@statement.outer", desc = "TS statement" },
                ["ad"] = { query = "@comment.outer", desc = "TS comment" },
                ["am"] = { query = "@call.outer", desc = "TS Call" },
                ["im"] = { query = "@call.inner", desc = "TS Call" },
            }
        },

        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist

            goto_next_start = {
                ["]]"] = "@function.outer",
                ["]C"] = "@class.outer",
                ["]f"] = "@field.outer",
            },

            goto_next_end = {
                ["]["] = "@function.outer",
            },
            goto_previous_start = {
                ["[["] = "@function.outer",
                ["[C"] = "@class.outer",
                ["[f"] = "@field.outer",
            },
            goto_previous_end = {
                ["[]"] = "@function.outer",
            }
        },

        swap = {
            enable = false,  -- swap using syntax-tree-surfer
            swap_next = {
                ["~"] = "@parameter.inner"
            },
        }
    },

    playground = {
        enable = true,
    }
}
