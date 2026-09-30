return { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
        signs = {
            add = { text = '+' },
            change = { text = '~' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
        },
    },
    {
        'f-person/git-blame.nvim',
        -- load the plugin at startup
        -- Because of the keys part, you will be lazy loading this plugin.
        lazy = true,
        -- The plugin wil only load once one of the keys is used.
        -- If you want to load the plugin at startup, add something like event = "VeryLazy",
        -- or lazy = false. One of both options will work.
        opts = {
            -- your configuration comes here
            -- for example
            enabled = true, -- if you want to enable the plugin
            message_template = ' <summary> • <date> • <author> • <<sha>>', -- template for the blame message, check the Message template section for more options
            date_format = '%m-%d-%Y %H:%M:%S', -- template for the date, check Date format section for more options
            virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
        },
        keys = {
            { '<leader>gb', '<cmd>GitBlameToggle<cr>', desc = 'GitBlame' },
        },
    },
    {
        'kdheepak/lazygit.nvim',
        lazy = true,
        cmd = {
            'LazyGit',
            'LazyGitConfig',
            'LazyGitCurrentFile',
            'LazyGitFilter',
            'LazyGitFilterCurrentFile',
        },
        -- optional for floating window border decoration
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            {
                '<leader>lg',
                -- Open the repo of the current file (or Oil dir), not Neovim's cwd,
                -- so it works when Neovim was started in a folder that holds several repos
                function()
                    local dir = vim.fn.expand '%:p:h'
                    if vim.bo.filetype == 'oil' then
                        dir = require('oil').get_current_dir() or dir
                    end
                    require('lazygit').lazygit(vim.fs.root(dir, '.git'))
                end,
                desc = 'LazyGit (repo of current file)',
            },
        },
    },
}
