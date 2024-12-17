return { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
        {
            '<leader>f',
            function()
                require('conform').format { async = true, lsp_fallback = true }
            end,
            mode = '',
            desc = '[F]ormat buffer',
        },
    },
    opts = {
        notify_on_error = false,
        format_on_save = function(bufnr)
            --disable node_modules formatting
            local buf_name = vim.api.nvim_buf_get_name(bufnr)
            if buf_name:match '/node_modules' then
                return
            end

            -- Disable "format_on_save lsp_fallback" for languages that don't
            -- have a well standardized coding style. You can add additional
            -- languages here or re-enable it for the disabled ones.
            local disable_filetypes = { c = true, cpp = true, vue = true }
            return {
                timeout_ms = 500,
                lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
            }
        end,
        formatters_by_ft = {
            lua = { 'stylua' },
            typescript = { 'prettierd' },
            typescriptreact = { 'prettierd' },
            javascript = { 'prettierd' },
            javascriptreact = { 'prettierd' },
            html = { 'prettierd' },
            css = { 'prettierd' },
            scss = { 'prettierd' },
            markdown = { 'prettierd' },
            yaml = { 'prettierd' },
            graphql = { 'prettierd' },
            vue = { 'prettierd' },
            angular = { 'prettierd' },
            less = { 'prettierd' },
            flow = { 'prettierd' },
            json = { 'prettierd' },
            sh = { 'beautysh' },
            bash = { 'beautysh' },
            zsh = { 'beautysh' },
            http = { 'kulala-fmt' },
        },
    },
    config = function(_, opts)
        local conform = require 'conform'
        conform.setup(opts)

        -- Customize prettier args
        require('conform.formatters.prettierd').args = function(_, ctx)
            local prettier_roots = { '.prettierrc', '.prettierrc.json', 'prettier.config.js' }
            local args = { '--stdin-filepath', '$FILENAME' }
            local config_path = vim.fn.stdpath 'config'

            local localPrettierConfig = vim.fs.find(prettier_roots, {
                upward = true,
                path = ctx.dirname,
                type = 'file',
            })[1]
            local globalPrettierConfig = vim.fs.find(prettier_roots, {
                path = type(config_path) == 'string' and config_path or config_path[1],
                type = 'file',
            })[1]
            local disableGlobalPrettierConfig = os.getenv 'DISABLE_GLOBAL_PRETTIER_CONFIG'

            -- Project config takes precedence over global config
            if localPrettierConfig then
                vim.list_extend(args, { '--config', localPrettierConfig })
            elseif globalPrettierConfig and not disableGlobalPrettierConfig then
                vim.list_extend(args, { '--config', globalPrettierConfig })
            end

            local hasTailwindPrettierPlugin = vim.fs.find('node_modules/prettier-plugin-tailwindcss', {
                upward = true,
                path = ctx.dirname,
                type = 'directory',
            })[1]

            if hasTailwindPrettierPlugin then
                vim.list_extend(args, { '--plugin', 'prettier-plugin-tailwindcss' })
            end

            return args
        end

        require('conform.formatters.eslint_d').args = function(_, ctx)
            local eslint_roots = { '.eslintrc', '.eslintrc.json', '.eslintrc.js' }
            local args = { '--stdin-filepath', '$FILENAME' }
            local config_path = vim.fn.stdpath 'config'

            local localEslintConfig = vim.fs.find(eslint_roots, {
                upward = true,
                path = ctx.dirname,
                type = 'file',
            })[1]

            local globalEslintConfig = vim.fs.find(eslint_roots, {
                path = type(config_path) == 'string' and config_path or config_path[1],
                type = 'file',
            })[1]
            local disableGlobalEslintConfit = os.getenv 'DISABLE_GLOBAL_PRETTIER_CONFIG'

            -- Project config takes precedence over global config
            if localEslintConfig then
                vim.list_extend(args, { '--config', localEslintConfig })
            elseif globalEslintConfig and not disableGlobalEslintConfit then
                vim.list_extend(args, { '--config', globalEslintConfig })
            end

            return args
        end

        conform.formatters.beautysh = {
            prepend_args = function()
                return { '--indent-size', '2', '--force-function-style', 'fnpar' }
            end,
        }
    end,
}
