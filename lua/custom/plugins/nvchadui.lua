local fn = vim.fn
local sep_style = vim.g.statusline_sep_style
local separators = (type(sep_style) == "table" and sep_style)
  or require("nvchad_ui.icons").statusline_separators[sep_style]
local sep_r = separators["right"]
local myicons = require("custom.chadrc").ui.myicons

-- called in chadrc
--
return {
  fileInfo = function ()
    local icon = "  "
    local filename = (fn.expand "%" == "" and "Empty ") or fn.expand "%:t"
    local modified = (vim.bo[0].modified and "+ ") or ""

    if filename ~= "Empty " then
      local devicons_present, devicons = pcall(require, "nvim-web-devicons")

      if devicons_present then
        local ft_icon = devicons.get_icon(filename)
        icon = (ft_icon ~= nil and " " .. ft_icon) or ""
      end

      filename = " " .. filename .. " "
    end

    return "%#St_file_info#" .. icon ..  filename .. modified ..  "%#St_file_sep#" .. sep_r
  end,

  LSP_Diagnostics = function()
    if not rawget(vim, "lsp") then
      return ""
    end

    local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    local info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })

    errors = (errors and errors > 0) and ("%#St_lspError#" .. myicons.lsp.diagnostic_err .. " " .. errors .. " ") or ""
    warnings = (warnings and warnings > 0) and ("%#St_lspWarning#" .. myicons.lsp.diagnostic_warn .. " " .. warnings .. " ") or ""
    hints = (hints and hints > 0) and ("%#St_lspHints#" .. myicons.lsp.diagnostic_hint .. " " .. hints .. " ") or ""
    info = (info and info > 0) and ("%#St_lspInfo#" .. myicons.lsp.diagnostic_info .. " " .. info .. " ") or ""

    return errors .. warnings .. hints .. info
  end
}

