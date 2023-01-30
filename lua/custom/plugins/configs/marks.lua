local present, marks = pcall(require, "marks")

if not present then
  return
end


local M = {}

local config = {
  bookmark_0 = {
        sign= "",
        virt_text = "vim",
        annotate = true,
  }

}

M.setup = function()
  marks.setup(config)
end

return M
