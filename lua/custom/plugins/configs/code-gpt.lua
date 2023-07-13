local ok, codegpt = pcall(require, "codegpt")
if not ok then
    vim.notify("missing module codegpt", vim.log.levels.WARN)
    return
end

local M = {}

M.setup = function()
    vim.g["codegpt_commands"] = {
        ["tests"] = {
            language_instructions = {
                python = "Use pytest framework."
            }
        },
        ["docu4"] = {
            system_message_template = "You are a technical documentation assistant to a software developer. You will help improving project documentation.",
            user_message_template = "Improve the following text: ```{{text_selection}}```\n. Use a professional. Write as if you are writing a python project documentation for a Github repo. {{command_args}}",
            model = "gpt-4"
        },
    }
end

return M
