return {
    'rebelot/heirline.nvim',
    event = { 'BufEnter' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        -- local conditions = require 'heirline.conditions'
        -- local utils = require 'heirline.utils'

        local colors = require 'samad.configs.heirline.colors'

        require('heirline').setup {
            statusline = require 'samad.configs.statusline',
            tabline = require 'samad.configs.tabline',

            opts = {
                colors = colors,
            },
        }
    end,
}
