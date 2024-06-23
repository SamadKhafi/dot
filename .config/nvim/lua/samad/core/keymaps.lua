local utils = require 'samad.utils'

-- set <Space> as leader key
vim.g.mapleader = ' '
vim.g.localleader = ' '

local map = vim.keymap.set

map('n', '<leader>q', '<cmd>q<cr>', { desc = 'Quit' })
map('n', '<leader>Q', '<cmd>q!<cr>', { desc = 'Force Quit' })
map('n', '<leader>w', function()
    vim.cmd [[silent w]]
end, { desc = 'Save', silent = true })

map('n', 'L', '<cmd>bn<CR>', { desc = 'Next Buffer', silent = true })
map('n', 'H', '<cmd>bN<CR>', { desc = 'Prev Buffer', silent = true })
-- map('n', '<leader>c', '<cmd>bd<CR>', { desc = 'Close buffer', silent = true })
-- map('n', '<leader>C', '<cmd>bd!<CR>', { desc = 'Force close buffer', silent = true })

-- vim-tmux-navigator
map('n', '<C-h>', '<cmd> TmuxNavigateLeft<cr>', { desc = 'Window Left' })
map('n', '<C-l>', '<cmd> TmuxNavigateRight<cr>', { desc = 'Window Right' })
map('n', '<C-j>', '<cmd> TmuxNavigateDown<cr>', { desc = 'Window Down' })
map('n', '<C-k>', '<cmd> TmuxNavigateUp<cr>', { desc = 'Window Up' })

-- window resize
-- map('n', '<C-Left>', '<cmd>vertical resize +2<CR>')
-- map('n', '<C-Right>', '<cmd>vertical resize -2<CR>')
-- map('n', '<C-Up>', '<cmd>horizontal resize +2<CR>')
-- map('n', '<C-Down>', '<cmd>horizontal resize -2<CR>')

-- increment/decrement numbers
map('n', '+', '<C-a>', { desc = 'Increment number' }) -- increment
map('n', '-', '<C-x>', { desc = 'Decrement number' }) -- decrement

-- this is useful for naming menus
map('n', '<leader>b', '', { desc = 'Buffers' })

-- Search and replace the word under the cursor using F4
map('n', '<F4>', ':%s/<C-r><C-w>/<C-r><C-w>/gc<C-f>$F/i', { desc = 'Search and replace word under cursor' })
map('n', '<leader>rw', ':%s/<C-r><C-w>/<C-r><C-w>/gc<C-f>$F/i', { desc = 'Search and replace word under cursor' })
map('n', '<leader>r', '', { desc = 'Rename' })

-- spotify control
map('n', '<leader>sc', ':!sp current<cr>', { desc = 'Spotify Current Song' })
map('n', '<leader>sp', ':!sp play >/dev/null 2>&1<cr><cr>', { desc = 'Spotify Play/Pause' })
map('n', '<leader>sn', ':!sp next >/dev/null 2>&1<cr><cr>', { desc = 'Spotify Next' })
map('n', '<leader>sN', ':!sp prev >/dev/null 2>&1<cr><cr>', { desc = 'Spotify Previous' })
map('n', '<leader>ss', ':!sp search ', { desc = 'Spotify Previous' })

-- line movement
map('n', '<A-j>', ':m .+1<cr>==', { desc = 'Move line down' })
map('n', '<A-k>', ':m .-2<cr>==', { desc = 'Move line up' })
map('n', '<A-Down>', ':m .+1<cr>==', { desc = 'Move line down' })
map('n', '<A-Up>', ':m .-2<cr>==', { desc = 'Move line up' })

-- telescope plugin mappings
map('n', '<leader>fT', '<cmd>TodoTelescope<cr>', { desc = '[Find] TODOs' })

-- trouble plugin mappings
-- map('n', '<leader>y', '', { desc = 'Trouble' })

-- C/C++ switch between header and source files
map('n', 'gh', '<cmd>ClangdSwitchSourceHeader<cr>', { desc = 'Switch to header or source' })

-- line movement
map('i', '<A-j>', '<Esc>:m .+1<cr>==gi', { desc = 'Move line down' })
map('i', '<A-k>', '<Esc>:m .-2<cr>==gi', { desc = 'Move line up' })
map('i', '<A-Down>', '<Esc>:m .+1<cr>==gi', { desc = 'Move line down' })
map('i', '<A-Up>', '<Esc>:m .-2<cr>==gi', { desc = 'Move line up' })

-- date/time input
map('i', '<C-t>', '', { desc = '󰃰 Date/Time' })
map('i', '<C-t>n', "<C-r>=strftime('%Y-%m-%d')<cr>", { desc = 'Y-m-d' })
map('i', '<C-t>x', "<C-r>=strftime('%m/%d/%y')<cr>", { desc = 'm/d/y' })
map('i', '<C-t>f', "<C-r>=strftime('%B %d, {%Y')<cr>", { desc = 'B d, Y' })
map('i', '<C-t>X', "<C-r>=strftime('%H:%M')<cr>", { desc = 'H:M' })
map('i', '<C-t>F', "<C-r>=strftime('%H:%M:%S')<cr>", { desc = 'H:M:S' })
map('i', '<C-t>d', "<C-r>=strftime('%Y/%m/%d %H:%M:%S -')<cr>", { desc = 'Y/m/d H:M:S -' })
map('i', '<C-t>s', function()
    utils.insert_in_place(utils.get_unix_seconds())
end, { desc = 'Unix Seconds' })
map('i', '<C-t>m', function()
    utils.insert_in_place(utils.get_unix_millis())
end, { desc = 'Unix Millis' })
map('i', '<C-t>u', function()
    utils.insert_in_place(utils.get_unix_micros())
end, { desc = 'Unix Micros' })

-- block movement
map('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move block down' })
map('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move block up' })
map('v', '<A-Down>', ":m '>+1<cr>gv=gv", { desc = 'Move block down' })
map('v', '<A-Up>', ":m '<-2<cr>gv=gv", { desc = 'Move block up' })

-- better increment/decrement
map('x', '+', 'g<C-a>', { desc = 'Increment number' })
map('x', '-', 'g<C-x>', { desc = 'Decrement number' })

-- line text-objects
map('x', 'il', 'g_o^', { desc = 'Inside line text object' })
map('x', 'al', '$o^', { desc = 'Around line text object' })

-- line text-objects
map('o', 'il', ':normal vil<cr>', { desc = 'Inside line text object' })
map('o', 'al', ':normal val<cr>', { desc = 'Around line text object' })
