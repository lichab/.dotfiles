return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    init = function()
        local harpoon = require 'harpoon'

        -- REQUIRED
        harpoon:setup()
        -- REQUIRED

        vim.keymap.set('n', '<leader>a', function()
            harpoon:list():add()
        end)
        vim.keymap.set('n', '<leader>h', function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)

        vim.keymap.set('n', '<leader>j', function()
            harpoon:list():select(1)
        end)
        vim.keymap.set('n', '<leader>k', function()
            harpoon:list():select(2)
        end)
        vim.keymap.set('n', '<leader>l', function()
            harpoon:list():select(3)
        end)
        vim.keymap.set('n', '<leader>;', function()
            harpoon:list():select(4)
        end)

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set('n', '<leader>p', function()
            harpoon:list():prev()
        end)
        vim.keymap.set('n', '<leader>n', function()
            harpoon:list():next()
        end)
    end,
    dependencies = { 'nvim-lua/plenary.nvim' },
}