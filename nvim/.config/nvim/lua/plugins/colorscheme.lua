return {
    'rose-pine/neovim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
        local rose = require 'rose-pine'

        rose.setup {
            styles = {
                bold = true,
                italic = false,
                transparency = false,
            },
        }
    end,
    init = function()
        vim.cmd.colorscheme 'rose-pine'

        vim.cmd.hi 'Comment gui=none'
    end,
}
