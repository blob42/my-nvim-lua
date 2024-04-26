
local ok, codegpt = pcall(require, "codegpt")
if not ok then
    vim.notify("missing module codegpt", vim.log.levels.WARN)
    return
end

local M = {}

M.setup = function()
    -- vim.g["codegpt_write_response_to_err_log"] = true

    require("spike.utils.openai").load_api_key("localai")
    vim.g["codegpt_openai_api_key"] = vim.fn.getenv("OPENAI_API_KEY")

    vim.g["codegpt_chat_completions_url"] = "http://localai.srvlan:8080/v1/chat/completions"


    vim.g["codegpt_global_commands_defaults"] = { 
        -- model = "dolphin-mixtral",
        model = "llama3-8b-inst",
        max_tokens = 8192,
        temperature = 0.4,
        -- extra_params = {
        --     presence_penalty = 0,
        --     frequency_penalty= 0
        -- }
    }


    vim.g["codegpt_commands"] = {
        ["question"] = {
            callback_type = "text_popup",
            system_message_template = "You are a helpful {{filetype}} programming assistant. Analyze the question and any provided sample code and give thourough detailed explanations.",
            user_message_template = "I have a question about the following {{language}} code: ```{{filetype}}\n{{text_selection}}```\n {{command_args}}",
        },
        ["explain"] = {
            system_message_template = "You are a helpful {{filetype}} pair programming assistant. Help the user understand source code. Explain as if you were explaining to an other developer.",
            user_message_template = "Explain the following {{language}} code: ```{{filetype}}\n{{text_selection}}```\n {{command_args}}",
            callback_type = "text_popup",
            temperature = 0.6
        },
        ["implement"] = {
            callback_type = "code_popup",
            system_message_template = "You are a {{filetype}} programming assistant. Complete or implement the feature from the provided description. Think step by step before answering. Use {{filetype}} best practicies. Only output code snippets.",
            user_message_template = "I have the following specification for a {{language}} project: ```{{filetype}} {{text_selection}}```  {{command_args}}"

        },
        ["tests"] = {
            language_instructions = {
                python = "Use pytest framework."
            }
        },
        doc = {
            system_message_template = "You are a {{language}} programming assistant specialized in documenting source code.",
            user_message_template = "I have the following {{language}} code:\n```{{filetype}}\n{{text_selection}}\n```\nWrite good idiomatic documentation using the target language docstring. {{language_instructions}} {{command_args}}",
        },
        ["completion"] = {
            system_message_template = "You are a Programming pair Assistant AI. You are helpful with improving and optimizing source code using the idiomatic practicies.",
            user_message_template = "I have the following {{language}} code: ```{{filetype}}\n{{text_selection}}```\n{{command_args}}. {{language_instructions}} Think step by step then only return the code snippet and nothing else."
        },
        ["pydoc"] = {
            language_instructions = {
                python = "Use docstings to document the code. This project uses Sphinx. Use the google style python docstrings. Add sphinx directives if needed."
            },
            system_message_template = "You are a technical documentation assistant to a software developer. Help the user write clean detailed and easy to read project documentation.",
            user_message_template = "Create or improve the documentation for: ```{{text_selection}}```\n. Use a professional tone. {{language_instructions}} {{command_args}}",
        }
    }
end

return M
