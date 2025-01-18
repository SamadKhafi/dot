return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    init = function()
        vim.g.neo_tree_remove_legacy_commands = true
    end,

    config = function()
        local utils = require 'samad.utils'

        local signs = utils.get_diagnostic_signs()

        require('neo-tree').setup {
            auto_clean_after_session_restore = true,
            close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
            commands = {
                system_open = function(state)
                    vim.ui.open(state.tree:get_node():get_id())
                end,
                parent_or_close = function(state)
                    local node = state.tree:get_node()
                    if (node.type == 'directory' or node:has_children()) and node:is_expanded() then
                        state.commands.toggle_node(state)
                    else
                        require('neo-tree.ui.renderer').focus_node(state, node:get_parent_id())
                    end
                end,
                child_or_open = function(state)
                    local node = state.tree:get_node()
                    if node.type == 'directory' or node:has_children() then
                        if not node:is_expanded() then -- if unexpanded, expand
                            state.commands.toggle_node(state)
                        else -- if expanded and has children, seleect the next child
                            require('neo-tree.ui.renderer').focus_node(state, node:get_child_ids()[1])
                        end
                    else -- if not a directory just open it
                        state.commands.open(state)
                    end
                end,
                copy_selector = function(state)
                    local node = state.tree:get_node()
                    local filepath = node:get_id()
                    local filename = node.name
                    local modify = vim.fn.fnamemodify

                    local vals = {
                        ['BASENAME'] = modify(filename, ':r'),
                        ['EXTENSION'] = modify(filename, ':e'),
                        ['FILENAME'] = filename,
                        ['PATH (CWD)'] = modify(filepath, ':.'),
                        ['PATH (HOME)'] = modify(filepath, ':~'),
                        ['PATH'] = filepath,
                        ['URI'] = vim.uri_from_fname(filepath),
                    }

                    local options = vim.tbl_filter(function(val)
                        return vals[val] ~= ''
                    end, vim.tbl_keys(vals))
                    if vim.tbl_isempty(options) then
                        print 'No values to copy'
                        -- utils.notify('No values to copy', vim.log.levels.WARN)
                        return
                    end
                    table.sort(options)
                    vim.ui.select(options, {
                        prompt = 'Choose to copy to clipboard:',
                        format_item = function(item)
                            return ('%s: %s'):format(item, vals[item])
                        end,
                    }, function(choice)
                        local result = vals[choice]
                        if result then
                            print('Copied: ' .. result)
                            -- utils.notify(('Copied: `%s`'):format(result))
                            vim.fn.setreg('+', result)
                        end
                    end)
                end,
                find_in_dir = function(state)
                    local node = state.tree:get_node()
                    local path = node:get_id()
                    require('telescope.builtin').find_files {
                        cwd = node.type == 'directory' and path or vim.fn.fnamemodify(path, ':h'),
                    }
                end,
            },
            window = {
                width = 40,
                mappings = {
                    ['<space>'] = false,
                    F = 'find_in_dir',
                    O = 'system_open',
                    Y = 'copy_selector',
                    h = 'parent_or_close',
                    l = 'child_or_open',
                    o = 'open',
                },
            },
            filesystem = {
                filtered_items = {
                    hide_by_name = {
                        'node_modules',
                    },
                    never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                        '.git',
                        '.DS_Store',
                        'thumbs.db',
                    },
                },
                follow_current_file = { enabled = true },
                hijack_netrw_behavior = 'open_default',
                use_libuv_file_watcher = true,
            },
            event_handlers = {
                {
                    event = 'neo_tree_buffer_enter',
                    handler = function(_)
                        vim.opt_local.signcolumn = 'auto'
                    end,
                },
            },
            default_component_configs = {
                diagnostics = {
                    symbols = {
                        error = signs[vim.diagnostic.severity.ERROR],
                        warn = signs[vim.diagnostic.severity.WARN],
                        info = signs[vim.diagnostic.severity.INFO],
                        hint = signs[vim.diagnostic.severity.HINT],
                    },
                    highlights = {
                        error = 'DiagnosticSignError',
                        warn = 'DiagnosticSignWarn',
                        info = 'DiagnosticSignInfo',
                        hint = 'DiagnosticSignHint',
                    },
                },
                git_status = {
                    symbols = {
                        -- Change type
                        added = '',
                        modified = '',
                        deleted = '',
                        renamed = '',
                        -- Status type
                        untracked = '',
                        ignored = '',
                        unstaged = '',
                        staged = '',
                        conflict = '',
                    },
                },
            },
        }

        -- set keymaps
        local map = vim.keymap.set -- for conciseness

        map('n', '<leader>e', '<cmd>Neotree toggle<CR>', { desc = 'Toggle Explorer' }) -- toggle file explorer
        map('n', '<C-o>', '<cmd>Neotree toggle<CR>', { desc = 'Toggle Explorer' }) -- toggle file explorer

        map('n', '<leader>o', function()
            if vim.bo.filetype:lower() == 'neo-tree' then
                vim.cmd.wincmd 'p'
            else
                vim.cmd.Neotree 'focus'
            end
        end, { desc = 'Focus Explorer' }) -- toggle file explorer
    end,
}
