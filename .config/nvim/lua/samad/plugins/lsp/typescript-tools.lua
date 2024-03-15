return {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    config = function()
        local tools = require 'typescript-tools'

        tools.setup {
            settings = {
                expose_as_code_action = 'all',
                tsserver_max_memory = 1024,
                complete_function_calls = true,
            },
        }
    end,
}
