return {
    'loctvl842/monokai-pro.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('monokai-pro').setup {
            styles = {
                comment = { italic = false },
                keyword = { italic = false },
                type = { italic = false },
                storageclass = { italic = false },
                structure = { italic = false },
                parameter = { italic = false },
                annotation = { italic = false },
                tag_attribute = { italic = false },
            },
        }
        -- spectrum: highest syntax contrast of the filters, good for bright rooms.
        -- `monokai-pro` alone always loads the "pro" filter, so name the variant.
        vim.cmd.colorscheme 'monokai-pro-spectrum'
    end,
}
