return {
    'nvimdev/lspsaga.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },
    event = { 'LspAttach' },
    config = function()
        require('lspsaga').setup {
            code_action = { show_server_name = true, extend_gitsigns = true },
            diagnostic = { extend_relatedInformation = true },
            implement = { enable = true, sign = true, virtual_text = true, priority = 200 },
            lightbulb = { sign = false, virtual_text = true, debounce = 100 },
            symbol_in_winbar = { enable = true, hide_keyword = true },
            ui = {
                border = 'rounded',
                devicon = true,
            },
        }

        local map = vim.keymap.set

        map('n', 'K', function()
            -- try to peek folded lines,
            local winid = require('ufo').peekFoldedLinesUnderCursor()
            if not winid then
                -- otherwise show hover doc.
                require('lspsaga.hover'):render_hover_doc()
            end
        end, { desc = '[LSP] Hover documentation', silent = true })

        map({ 'n', 'v' }, '<leader>la', '<cmd>Lspsaga code_action<CR>', { desc = '[LSP] Code Actions', silent = true })
        map('n', '<leader>lr', '<cmd>Lspsaga rename<CR>', { desc = '[LSP] Rename', silent = true })
        map('n', '<leader>lS', '<cmd>Lspsaga outline<CR>', { desc = '[LSP] Symbols Outline', silent = true })
        map('n', '<leader>li', '<cmd>Lspsaga finder imp<CR>', { desc = '[LSP] Show Implementations', silent = true })
        map({ 'n', 't' }, '<F7>', '<cmd>Lspsaga term_toggle<CR>', { desc = 'Toggle Terminal', silent = true })
        map('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', { desc = 'Next Diagnostic', silent = true })
        map('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', { desc = 'Previous Diagnostic', silent = true })
    end,
}
