local ok, codegpt = pcall(require, "codegpt")
if not ok then
    vim.notify("missing module codegpt", vim.log.levels.WARN)
    return
end

local M = {}

M.setup = function()
    vim.g["codegpt_commands"] = {
        ["q4"] = {
            callback_type = "code_popup",
            system_message_template = "You are a {{filetype}} software pair assistant AI. Answer my questions. Think step by step out loud.",
            user_message_template = "I have a question about the following {{language}} code: ```{{filetype}} {{text_selection}}``` {{command_args}}"

        },
        ["tests"] = {
            language_instructions = {
                python = "Use pytest framework."
            }
        },
        ["code4"] = {
            system_message_template = "You are a Programming pair Assistant AI. You are helpful with improving and optimizing source code using the best idiomatic practicies.",
            model = "gpt-4",
            user_message_template = "I have the following {{language}} code: ```{{filetype}}\n{{text_selection}}```\n{{command_args}}. {{language_instructions}} Think step by step then only return the code snippet and nothing else."
        },
        ["docu4"] = {
            language_instructions = {
                python = "Use docstings to document the code. This project uses Sphinx. Use the google style python docstrings. Add sphinx directives if needed."
            },
            system_message_template = "You are a technical documentation assistant to a software developer. Help the user write clean detailed and easy to read project documentation.",
            user_message_template = "Create or improve the documentation for: ```{{text_selection}}```\n. Use a professional tone. {{language_instructions}} {{command_args}}",
            model = "gpt-4"
        },
    }
end

return M
