-- bootstrap Lazy
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end

vim.opt.rtp:prepend(lazypath)

-- initialize Lazy
require('lazy').setup({
    { import = 'samad.plugins' },
    { import = 'samad.plugins.lsp' },
    { import = 'samad.plugins.dap' },
}, {
    install = {
        colorscheme = { 'tokyonight-night', 'github_dark_dimmed', 'catppuccin-mocha', 'habamax' },
    },
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        enabled = true,
        notify = false,
    },
    performance = {
        rtp = {
            disabled_plugins = { 'tohtml', 'gzip', 'zipPlugin', 'netrwPlugin', 'tarPlugin' },
        },
    },
    ui = {
        border = 'rounded',
    },
})

vim.keymap.set('n', '<leader>pl', '<cmd>Lazy<CR>', { desc = '[Packages] Lazy' })
