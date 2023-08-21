local command = vim.api.nvim_create_user_command
local del_command = vim.api.nvim_del_user_command


command("DapPyMethod", function()
    require("dap-python").test_method()
end, {})

command("DapPyClass", function()
    require("dap-python").test_class()
end, {})
