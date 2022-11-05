local ok, grapple = pcall(require, "grapple")
if not ok then 
    vim.notify("missing module grapple", vim.log.levels.WARN)
    return
end

