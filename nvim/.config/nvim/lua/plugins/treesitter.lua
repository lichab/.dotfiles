return { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        local ts = require 'nvim-treesitter'
        ts.install {
            'bash',
            'c',
            'html',
            'lua',
            'luadoc',
            'markdown',
            'markdown_inline',
            'vim',
            'vimdoc',
            'javascript',
            'typescript',
            'tsx',
            'json',
            'yaml',
            'css',
            'php',
            'go',
            'vue',
            'scss',
            'jsdoc',
            'regex',
            'sql',
            'dockerfile',
            'gitcommit',
            'diff',
        }

        -- Start treesitter highlighting and indentation for any filetype with a parser,
        -- installing missing parsers on demand (like the old `auto_install`).
        local function start(buf, lang)
            if not vim.api.nvim_buf_is_valid(buf) or not pcall(vim.treesitter.start, buf, lang) then
                return false
            end
            vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            return true
        end

        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
            callback = function(args)
                local lang = vim.treesitter.language.get_lang(args.match)
                if not lang or start(args.buf, lang) or not vim.tbl_contains(ts.get_available(), lang) then
                    return
                end
                -- Parser missing: install it and start highlighting once it's ready
                ts.install(lang):await(function(err)
                    if not err then
                        vim.schedule(function()
                            start(args.buf, lang)
                        end)
                    end
                end)
            end,
        })
    end,
}
