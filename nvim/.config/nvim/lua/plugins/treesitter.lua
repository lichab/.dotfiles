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
        }

        -- Start treesitter highlighting and indentation for any filetype with a parser,
        -- installing missing parsers on demand (like the old `auto_install`).
        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
            callback = function(args)
                local lang = vim.treesitter.language.get_lang(args.match)
                if not lang then
                    return
                end
                if not pcall(vim.treesitter.start, args.buf, lang) then
                    if vim.tbl_contains(ts.get_available(), lang) then
                        ts.install(lang)
                    end
                    return
                end
                vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
