return {
    { -- Lua LSP support for the Neovim config, runtime and plugins
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {},
    },
    { -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for Neovim
            { 'mason-org/mason.nvim', opts = {} },
            'mason-org/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',

            -- Useful status updates for LSP.
            { 'j-hui/fidget.nvim', opts = {} },

            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            --  This function gets run when an LSP attaches to a particular buffer. (when we open a file)
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                    end
                    local builtin = require 'telescope.builtin'

                    --  To jump back, press <C-t>.
                    map('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
                    map('gr', builtin.lsp_references, '[G]oto [R]eferences')
                    map('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
                    map('<leader>D', builtin.lsp_type_definitions, 'Type [D]efinition')
                    map('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
                    map('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
                    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
                    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
                    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                    -- Highlights words that are the same that the one under the cursor
                    -- When you move your cursor, the highlights will be cleared (the second autocommand).
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
                        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.document_highlight,
                        })
                        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.clear_references,
                        })
                    end
                end,
            })

            -- Broadcast nvim-cmp's extra completion capabilities to every server
            vim.lsp.config('*', {
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
            })

            -- Servers to install and enable; the table holds per-server overrides.
            -- See `:help lspconfig-all` for the available servers.
            local servers = {
                gopls = {},
                ts_ls = {},
                intelephense = {},
                vue_ls = {},
                eslint = {},
                tailwindcss = {},
                jsonls = {},
                yamlls = {},
                bashls = {},
                dockerls = {},
                docker_compose_language_service = {},
                -- MySQL-aware completion when a connection is configured (e.g. `.sqls/config.yml`),
                -- generic SQL support otherwise
                sqls = {},
                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = 'Replace',
                            },
                        },
                    },
                },
            }

            for name, config in pairs(servers) do
                vim.lsp.config(name, config)
            end

            -- Mason installs the servers and tools; mason-lspconfig enables the installed servers.
            local ensure_installed = vim.tbl_keys(servers)
            vim.list_extend(ensure_installed, {
                'stylua', -- Used to format Lua code
                'beautysh', -- Used to format bash/zsh (see conform.lua)
                'sql-formatter', -- Used to format SQL (see conform.lua)
                'prettierd', -- Used to format web files (see conform.lua)
            })
            require('mason-tool-installer').setup { ensure_installed = ensure_installed }
            require('mason-lspconfig').setup {
                ensure_installed = {},
                automatic_enable = vim.tbl_keys(servers),
            }
        end,
    },
}
