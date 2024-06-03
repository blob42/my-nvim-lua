local M = {}

M.setup = function()
    vim.g.tabby_keybinding_accept = '<M-j>'
    vim.g.tabby_filetype_dict = {
        bash = "shellscript",
        sh = "shellscript",
        cs = "csharp",
        objc = "objective-c",
        objcpp = "objective-cpp",
        make = "makefile",
        cuda = "cuda-cpp",
        text = "plaintext",
        rust = "rust",
        go = "go",
        javascript = "javascript"
    }
    
    vim.cmd("call tabby#OnVimEnter()")
end

return M
