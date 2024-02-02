return {
    'rcarriga/nvim-dap-ui',
    dependencies = {
        'mfussenegger/nvim-dap',
        'theHamsta/nvim-dap-virtual-text',
    },
    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'
        local dvt = require 'nvim-dap-virtual-text'

        -- setup
        dapui.setup()
        dvt.setup()

        -- custom icons and colors for breakpoints
        local utils = require 'samad.utils'
        vim.api.nvim_set_hl(0, 'red', { fg = utils.get_hlgroup('DiagnosticError', { fg = '#a1593d' }).fg })
        vim.api.nvim_set_hl(0, 'blue', { fg = utils.get_hlgroup('Function', { fg = '#3d59a1' }).fg })
        vim.api.nvim_set_hl(0, 'green', { fg = utils.get_hlgroup('String', { fg = '#9ece6a' }).fg })
        vim.api.nvim_set_hl(0, 'yellow', { fg = utils.get_hlgroup('DiagnosticInfo', { fg = '#ffff00' }).fg })
        vim.api.nvim_set_hl(0, 'orange', { fg = utils.get_hlgroup('Constant', { fg = '#f09000' }).fg })

        vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'red', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
        vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'blue', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
        vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'orange', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
        vim.fn.sign_define('DapStopped', { text = '', texthl = 'green', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
        vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'yellow', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })

        -- keymaps
        local map = vim.keymap.set

        map('n', '<leader>dk', function()
            require('dap.ui.widgets').hover()
        end, { desc = '[Debugger] Hover', noremap = true, silent = true })

        map('n', '<F5>', dap.continue, { desc = '[Debugger] Continue', noremap = true })
        map('n', '<leader>dc', dap.continue, { desc = '[Debugger] Continue (F5)', noremap = true })

        map('n', '<F9>', dap.toggle_breakpoint, { desc = '[Debugger] Toggle Breakpoint', noremap = true })
        map('n', '<leader>db', dap.toggle_breakpoint, { desc = '[Debugger] Toggle Breakpoint (F9)', noremap = true })

        map('n', '<S-F9>', dap.clear_breakpoints, { desc = '[Debugger] Clear Breakpoints', noremap = true })
        map('n', '<leader>dB', dap.clear_breakpoints, { desc = '[Debugger] Clear Breakpoints (Shift+F9)', noremap = true })

        map('n', '<F10>', dap.step_over, { desc = '[Debugger] Step Over', noremap = true })
        map('n', '<leader>dn', dap.step_over, { desc = '[Debugger] Step Over (F10)', noremap = true })

        map('n', '<F11>', dap.step_into, { desc = '[Debugger] Step Into', noremap = true })
        map('n', '<leader>di', dap.step_into, { desc = '[Debugger] Step Into (F11)', noremap = true })

        map('n', '<S-F11>', dap.step_out, { desc = '[Debugger] Step Out', noremap = true })
        map('n', '<leader>do', dap.step_out, { desc = '[Debugger] Step Out (Shift+F11)', noremap = true })

        map('n', '<leader>dl', dap.run_to_cursor, { desc = '[Debugger] Run To Cursor', noremap = true })
        map('n', '<leader>dp', dap.pause, { desc = '[Debugger] Pause', noremap = true })

        map('n', '<C-F5>', dap.restart, { desc = '[Debugger] Restart', noremap = true })
        map('n', '<leader>dr', dap.restart, { desc = '[Debugger] Restart (Ctrl+F5)', noremap = true })

        map('n', '<S-F5>', dap.terminate, { desc = '[Debugger] Stop', noremap = true })
        map('n', '<leader>ds', dap.terminate, { desc = '[Debugger] Stop (Shift+F5)', noremap = true })

        map('n', '<leader>du', dapui.toggle, { desc = '[Debugger] Toggle UI', noremap = true })

        map('n', '<leader>dd', function()
            dapui.open { reset = true }
        end, { desc = '[Debugger] Reset UI', noremap = true })

        map('n', '<leader>dq', function()
            dap.terminate()
            dapui.close()
        end, { desc = '[Debugger] Quit', noremap = true })

        map('n', '<leader>dv', '<cmd>DapVirtualTextToggle<CR>', { desc = '[Debugger] Toggle Virtual Text', noremap = true })
    end,
}
