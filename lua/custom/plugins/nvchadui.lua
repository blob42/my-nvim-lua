-- called in chadrc

-- statusline=%!v:lua.require('nvchad_ui').statusline()
-- vim.o.statusline="%.40(%{expand('%:p:h:t')}/%t%)"

local fn = vim.fn
local sep_style = vim.g.statusline_sep_style
local separators = (type(sep_style) == "table" and sep_style)
    or require("nvchad_ui.icons").statusline_separators[sep_style]
local sep_l = separators["left"]
local sep_r = separators["right"]
local myicons = require("custom.chadrc").ui.myicons

local modes = {
    ["n"] = { "NORMAL", "St_NormalMode" },
    ["niI"] = { "NORMAL i", "St_NormalMode" },
    ["niR"] = { "NORMAL r", "St_NormalMode" },
    ["niV"] = { "NORMAL v", "St_NormalMode" },
    ["no"] = { "N-PENDING", "St_NormalMode" },
    ["i"] = { "INSERT", "St_InsertMode" },
    ["ic"] = { "INSERT (completion)", "St_InsertMode" },
    ["ix"] = { "INSERT completion", "St_InsertMode" },
    ["t"] = { "TERMINAL", "St_TerminalMode" },
    ["nt"] = { "NTERMINAL", "St_NTerminalMode" },
    ["v"] = { "VISUAL", "St_VisualMode" },
    ["V"] = { "V-LINE", "St_VisualMode" },
    ["Vs"] = { "V-LINE (Ctrl O)", "St_VisualMode" },
    [""] = { "V-BLOCK", "St_VisualMode" },
    ["R"] = { "REPLACE", "St_ReplaceMode" },
    ["Rv"] = { "V-REPLACE", "St_ReplaceMode" },
    ["s"] = { "SELECT", "St_SelectMode" },
    ["S"] = { "S-LINE", "St_SelectMode" },
    [""] = { "S-BLOCK", "St_SelectMode" },
    ["c"] = { "COMMAND", "St_CommandMode" },
    ["cv"] = { "COMMAND", "St_CommandMode" },
    ["ce"] = { "COMMAND", "St_CommandMode" },
    ["r"] = { "PROMPT", "St_ConfirmMode" },
    ["rm"] = { "MORE", "St_ConfirmMode" },
    ["r?"] = { "CONFIRM", "St_ConfirmMode" },
    ["!"] = { "SHELL", "St_TerminalMode" },
}

local function is_dapmode()
    if not _BLOB42_DAPMODE_LOADED then return false end
    return require("spike.dap.dapmode").is_active()
    -- return false
end

return {
    mode = function()
        local m = vim.api.nvim_get_mode().mode
        local current_mode = "%#" .. modes[m][2] .. "# " ..  modes[m][1]
        local mode_sep1 = "%#" .. modes[m][2] .. "Sep" .. "#" .. sep_r

        if is_dapmode() then
            local dap_mode = "%#St_DapMode#DAP" .. "%#St_DapModeSep#"
            return current_mode .. mode_sep1 .. "%#St_DapModeSep2#" .. sep_r .. dap_mode .. sep_r
        end

        return current_mode .. mode_sep1 .. "%#ST_EmptySpace#" .. sep_r
    end,

    fileInfo = function()
        local icon = "  "
        local filepath = fn.expand "%:p:h:t" .. '/%t'
        local filetype = '%y '
        local filename = (fn.expand "%" == "" and "Empty ") or filepath
        local modified = (vim.bo[0].modified and "+ ") or ""

        if filename ~= "Empty " then
            local devicons_present, devicons = pcall(require, "nvim-web-devicons")

            if devicons_present then
                local ft_icon = devicons.get_icon(filename)
                icon = (ft_icon ~= nil and " " .. ft_icon) or ""
            end

            filename = " " .. filetype  .. filename .. " "
        end

        return "%#St_file_info#" .. icon .. filename .. "[%n] " .. modified .. "%#St_file_sep#" .. sep_r
    end,

    LSP_Diagnostics = function()
        if not rawget(vim, "lsp") then
            return ""
        end

        local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        local info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })

        errors = (errors and errors > 0) and ("%#St_lspError#" .. myicons.lsp.diagnostic_err .. " " .. errors .. " ") or
            ""
        warnings = (warnings and warnings > 0) and
            ("%#St_lspWarning#" .. myicons.lsp.diagnostic_warn .. " " .. warnings .. " ") or ""
        hints = (hints and hints > 0) and ("%#St_lspHints#" .. myicons.lsp.diagnostic_hint .. " " .. hints .. " ") or ""
        info = (info and info > 0) and ("%#St_lspInfo#" .. myicons.lsp.diagnostic_info .. " " .. info .. " ") or ""

        if vim.o.columns > 120 then
            return errors .. warnings .. hints .. info
        else
            return ""
        end
    end,

    LSP_progress = function()
        if not rawget(vim, "lsp") or vim.lsp.status then
            return ""
        end

        local Lsp = vim.lsp.status()[1]

        -- hide spammy null-ls progress
        if Lsp and Lsp.name:match "null%-ls" then
            return ""
        end

        if vim.o.columns < 120 or not Lsp then
            return ""
        end

        local msg = Lsp.message or ""
        local percentage = Lsp.percentage or 0
        local title = Lsp.title or ""
        local spinners = { "", "" }
        local ms = vim.loop.hrtime() / 1000000
        local frame = math.floor(ms / 120) % #spinners
        local content = string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)

        return ("%#St_LspProgress#" .. content) or ""
    end,

    LSP_status = function()
        local lsp_status = ""
        local dap_status = ""
        if rawget(vim, "lsp") then
            for _, client in ipairs(vim.lsp.get_active_clients()) do
                if client.attached_buffers[vim.api.nvim_get_current_buf()] then
                    lsp_status = (vim.o.columns > 100 and "%#St_LspStatus#" .. "[" .. client.name .. "]") or "%#St_LspStatus#" .. " "
                end
            end
        end


        if _BLOB42_DAPMODE_LOADED then
            local present, dap = pcall(require, "dap")
            if present then
                local session = dap.session()
                if session ~= nil and session.initialized == true then
                    dap_status = "%#St_Dap#" .. "%* "
                end
            end
        end

        return lsp_status .. dap_status
    end,

    cwd = function()
        local dir_icon = "%#St_cwd_icon#" .. " "
        local dir_name = "%#St_cwd_text#" .. " " .. fn.fnamemodify(fn.getcwd(), ":p:~") .. " "
        return (vim.o.columns > 85 and ("%#St_file_sep_rev#" .. sep_r .. dir_name)) or ""
    end,

    cursor_position = function()

        text = '%l,%c%V%\\ %p%%'

        return "%#St_pos_text#" .. " " .. text .. " "
    end,

    git = function()
      if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
        return ""
      end

      local git_status = vim.b.gitsigns_status_dict

      local added = (git_status.added and git_status.added ~= 0) and ("  " .. git_status.added) or ""
      local changed = (git_status.changed and git_status.changed ~= 0) and ("  " .. git_status.changed) or ""
      local removed = (git_status.removed and git_status.removed ~= 0) and ("  " .. git_status.removed) or ""
      local branch_name = "   " .. git_status.head .. " "

      if vim.o.columns > 120 then
          return "%#St_gitIcons#" .. branch_name .. added .. changed .. removed
      else
          return ""
      end
    end

}
