local present, leap = pcall(require, "leap")
if not present then
  return
end

leap.set_default_keymaps()
leap.opts.special_keys.next_match = "<Space>"
leap.opts.special_keys.prev_match = "<BS>"
