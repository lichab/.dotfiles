return {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
        local rose = require 'rose-pine'
        rose.setup {
            styles = {
                bold = true,
                italic = false,
                transparency = true,
            },
        }
        vim.cmd 'colorscheme rose-pine'
    end,
}
