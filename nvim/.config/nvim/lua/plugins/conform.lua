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
        notify_on_error = true,
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
            typescript = { 'prettierd', 'prettier', stop_after_first = true },
            typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
            javascript = { 'prettierd', 'prettier', stop_after_first = true },
            javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
            html = { 'prettierd', 'prettier', stop_after_first = true },
            css = { 'prettierd', 'prettier', stop_after_first = true },
            scss = { 'prettierd', 'prettier', stop_after_first = true },
            markdown = { 'prettierd', 'prettier', stop_after_first = true },
            yaml = { 'prettierd', 'prettier', stop_after_first = true },
            graphql = { 'prettierd', 'prettier', stop_after_first = true },
            vue = { 'prettierd', 'prettier', stop_after_first = true },
            angular = { 'prettierd', 'prettier', stop_after_first = true },
            less = { 'prettierd', 'prettier', stop_after_first = true },
            flow = { 'prettierd', 'prettier', stop_after_first = true },
            json = { 'prettierd', 'prettier', stop_after_first = true },
            bash = { 'beautysh' },
            zsh = { 'beautysh' },
        },
    },
}
