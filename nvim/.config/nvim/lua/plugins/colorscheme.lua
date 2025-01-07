return {
    'rebelot/kanagawa.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    opts = {
        theme = 'dragon',
    },
    init = function()
        vim.cmd.colorscheme 'kanagawa'

        vim.cmd.hi 'Comment gui=none'
    end,
}
