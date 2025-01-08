return {
    'rebelot/kanagawa.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    opts = {
        theme = 'dragon',
        keywordStyle = { bold = true, italic = false },
    },
    init = function()
        vim.cmd.colorscheme 'kanagawa'

        vim.o.background = ''
        vim.cmd.hi 'Comment gui=none'
    end,
}
