local utils = require 'samad.utils'

return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = utils.is_unix,
        },
    },
    config = function()
        local telescope = require 'telescope'
        local actions = require 'telescope.actions'

        telescope.setup {
            defaults = {
                mappings = {
                    i = {
                        ['<C-k>'] = actions.move_selection_previous, -- move to prev result
                        ['<C-j>'] = actions.move_selection_next, -- move to next result
                        ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
                    },
                },
                -- layout_config = {
                --   prompt_position = 'top',
                -- },
            },
        }

        -- set NvChad theme for telescope
        local get_hlgroup = require('samad.utils').get_hlgroup
        local function set_hl(name, val)
            vim.api.nvim_set_hl(0, name, val)
        end
        --
        -- get highlights from highlight groups
        local normal = get_hlgroup 'Normal'
        local fg, bg = normal.fg, normal.bg
        local bg_alt = get_hlgroup('Visual').bg
        local green = get_hlgroup('String').fg
        local red = get_hlgroup('Error').fg

        set_hl('TelescopeBorder', { fg = bg_alt, bg = bg })
        set_hl('TelescopeNormal', { bg = bg })
        set_hl('TelescopePreviewBorder', { fg = bg_alt, bg = bg })
        set_hl('TelescopePreviewNormal', { bg = bg })
        set_hl('TelescopePreviewTitle', { fg = bg, bg = green })
        set_hl('TelescopePromptBorder', { fg = bg_alt, bg = bg })
        set_hl('TelescopePromptNormal', { fg = fg, bg = bg })
        set_hl('TelescopePromptPrefix', { fg = red, bg = bg })
        set_hl('TelescopePromptTitle', { fg = bg, bg = red })
        set_hl('TelescopeResultsBorder', { fg = bg_alt, bg = bg })
        set_hl('TelescopeResultsNormal', { bg = bg })
        set_hl('TelescopeResultsTitle', { fg = bg, bg = bg_alt })

        if utils.is_unix() then
            telescope.load_extension 'fzf'
        end

        -- set keymaps
        local map = vim.keymap.set -- for conciseness
        map('n', '<leader>f', '', { desc = 'Find' })

        map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = '[Find] files' })
        map('n', '<leader>fo', '<cmd>Telescope oldfiles<cr>', { desc = '[Find] history' })
        map('n', '<leader>fw', '<cmd>Telescope live_grep<cr>', { desc = '[Find] words' })
        map('n', '<leader>fc', '<cmd>Telescope grep_string<cr>', { desc = '[Find] word under cursor' })
        map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = '[Find] buffers' })
        map('n', '<leader>ft', '<cmd>Telescope colorscheme<cr>', { desc = '[Find] themes' })
        map('n', "<leader>f'", '<cmd>Telescope marks<cr>', { desc = '[Find] marks' })

        map('n', '<leader>fF', function()
            require('telescope.builtin').find_files { hidden = true, no_ignore = true }
        end, { desc = '[Find] hidden files' })

        map('n', '<leader>fW', function()
            require('telescope.builtin').live_grep {
                additional_args = function(args)
                    return vim.list_extend(args, { '--hidden', '--no-ignore' })
                end,
            }
        end, { desc = '[Find] hidden words' })
    end,
}
