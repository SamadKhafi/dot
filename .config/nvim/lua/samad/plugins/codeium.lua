-- local utils = require 'samad.utils'

return {
    'Exafunction/codeium.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'hrsh7th/nvim-cmp',
    },
    -- cond = utils.is_unix,
    cond = false,
    event = { 'BufEnter' },
    cmd = 'Codeium',
    build = ':Codeium Auth',
    config = function()
        require('codeium').setup {}
    end,
}
