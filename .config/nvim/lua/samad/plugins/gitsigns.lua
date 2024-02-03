return {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local gitsigns = require 'gitsigns'

        gitsigns.setup {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigate hunks
                map('n', ']h', function()
                    if vim.wo.diff then
                        return ']c'
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return '<Ignore>'
                end, { expr = true, desc = 'Next Git hunk' })

                map('n', '[h', function()
                    if vim.wo.diff then
                        return '[c'
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return '<Ignore>'
                end, { expr = true, desc = 'Previous Git hunk' })

                -- Actions
                map('n', '<leader>gb', function()
                    gs.blame_line { full = true }
                end, { desc = '[Git] Hunk Blame' })

                map('n', '<leader>gd', gs.diffthis, { desc = '[Git] Diff' })
                map('n', '<leader>ub', gs.toggle_current_line_blame, { desc = '[UI] Toggle Git Blame Line' })
                map('n', '<leader>ug', gs.toggle_linehl, { desc = '[UI] Toggle Git Highlight' })
            end,
        }
    end,
}
