
local ok, codegpt = pcall(require, "codegpt")
if not ok then
    vim.notify("missing module codegpt", vim.log.levels.WARN)
    return
end

local M = {}

local default_talking_model = "llama3"

M.setup = function()
    -- vim.g["codegpt_write_response_to_err_log"] = true

    require("spike.utils.openai").load_api_key("localai")
    vim.g["codegpt_openai_api_key"] = vim.fn.getenv("OPENAI_API_KEY")

    vim.g["codegpt_chat_completions_url"] = "http://ollama.srvlan:11434/api/chat"

    vim.g["codegpt_api_provider"] = "ollama"


    vim.g["codegpt_global_commands_defaults"] = { 
        -- model = "dolphin-mixtral",
        model = "deepseek-coder-v2",
        max_tokens = 8192,
        temperature = 0.4,
        -- extra_params = { -- to use with openai type providers
        --     presence_penalty = 0,
        --     frequency_penalty= 0
        -- }
    }

    vim.g["codegpt_popup_options"] = {
        relative = "editor",
        position = "50%",
        size = {
            width = "80%",
            height = "80%"
        }
    }

    vim.g["codegpt_commands"] = {
        ["implement"] = {
            callback_type = "code_popup",
            system_message_template = "You are a {{filetype}} programming assistant. Complete or implement the feature from the provided description. Think step by step before answering. Use {{filetype}} best practicies. Only output code snippets.",
            user_message_template = "I have the following specification for a {{language}} project: ```{{filetype}} {{text_selection}}```  {{command_args}}"

        },
        code_edit = {
            user_message_template = "I have the following {{language}} code snippet: ```{{filetype}}\n{{text_selection}}```\n{{command_args}}. {{language_instructions}} Only return the code snippet and nothing else.",
        },
        question = {
            callback_type = "text_popup",
            system_message_template = "You are a helpful {{filetype}} programming assistant. Analyze the question and any provided sample code and give thourough detailed explanations.",
            user_message_template = "I have a question about the following {{language}} code: ```{{filetype}}\n{{text_selection}}```\n {{command_args}}",
            model = default_talking_model,
            temperature = 0.6
        },
        ["explain"] = {
            system_message_template = "You are a helpful {{filetype}} pair programming assistant. Help the user understand source code. Explain as if you were explaining to an other developer.",
            user_message_template = "Explain the following {{language}} code: ```{{filetype}}\n{{text_selection}}```\n {{command_args}}",
            callback_type = "text_popup",
            temperature = 0.6,
            model = default_talking_model,
        },
        
        tests = {
            system_message_template = "You are a {{language}} programming assistant specialized in writing unit tests. Given the code snippet, create idiomatic {{language}} tests. Only output the code snippet in markdown and nothing else.",
            user_message_template =
            "I have the following {{language}} code: ```{{filetype}}\n{{text_selection}}```\nWrite really good unit tests using best practices for the given language. {{language_instructions}} Only return the unit tests. Only return the code snippet and nothing else. ",
            callback_type = "code_popup",
            language_instructions = {
                cpp = "Use modern C++ syntax. Generate unit tests using the gtest framework.",
                java = "Generate unit tests using the junit framework.",
                python = "Use pytest framework.",
                rust = "write the tests using the standard library."
            },
            model = "codestral"
        },
        doc = {
            system_message_template = "You are a {{language}} code documentation assistant. You will be given a code snippet. Think step by step and output the most accrutae documentation for the requested code object. Use the idiomatic docstring format for {{language}}. Only output the docstring and nothing else. {{language_instructions}}",
            user_message_template = "{{command_args}}. Code snippet:\n```{{filetype}}\n{{text_selection}}\n```.",
        },
        completion = {
            system_message_template = "You are a Programming pair Assistant AI. You are helpful with improving and optimizing source code using the idiomatic practicies.",
            user_message_template = "I have the following {{language}} code: ```{{filetype}}\n{{text_selection}}```\n{{command_args}}. {{language_instructions}} Think step by step then only return the code snippet and nothing else."
        },
        pydoc = {
            language_instructions = {
                python = "Use docstings to document the code. This project uses Sphinx. Use the google style python docstrings. Add sphinx directives if needed."
            },
            system_message_template = "You are a technical documentation assistant to a software developer. Help the user write clean detailed and easy to read project documentation.",
            user_message_template = "Create or improve the documentation for: ```{{text_selection}}```\n. Use a professional tone. {{language_instructions}} {{command_args}}",
            model = default_talking_model,
            temperature = 0.4,
        }
    }
end

return M
