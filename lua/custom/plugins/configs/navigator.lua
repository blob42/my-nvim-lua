local present, navigator = pcall(require, "navigator")

if not present then
  return
end


local config = {
  -- debug = true,
  transparency = nil,
  default_mapping = true,
  -- keymaps = {
  --
  -- },
  -- TODO: remap all keys to restore default keys maps like `gi`
  lsp = {
    document_highlight = false,
    mason = true,
    format_on_save = false, -- applies to all formatting feature of neovim 
                            -- including auto-fold
  }
}

navigator.setup(config)
