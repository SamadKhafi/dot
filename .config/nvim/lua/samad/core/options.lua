local opt = vim.opt

-- line numbers
opt.relativenumber = true -- show relative numbers
opt.number = true         -- absolute number on current line

-- tabs and indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true -- case-sensitive when mixed case is used in search

-- cursor line
opt.cursorline = true -- highlight current line

-- folds
opt.foldcolumn = '1'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- appearance
opt.termguicolors = true -- 24bit true colors
opt.background = 'dark'  -- prefer dark colorscheme
opt.signcolumn = 'yes'   -- show sign column, so text doesn't shift
opt.laststatus = 3       -- single status line for all windows
opt.cmdheight = 0        -- hide cmdline unless it is needed

-- backspace
opt.backspace = 'indent,eol,start' -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append 'unnamedplus' -- use system clipboard as default register

-- split windows
opt.splitright = true    -- split vertical window to the right
opt.splitbelow = true    -- split horizontal window to the bottom
opt.splitkeep = 'screen' -- don't move content of current window when split window is created

-- turn off swapfile
opt.swapfile = false

-- Yep, with heirline we're driving manual!
vim.o.showtabline = 2
vim.cmd [[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]]

-- session options as recommended by rmagatti/auto-session
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

-- change the diagnostic symbols
vim.diagnostic.config {
    severity_sort = true,
    underline = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
            [vim.diagnostic.severity.HINT] = ' ',
        },
        linehl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticLineError',
            [vim.diagnostic.severity.WARN] = 'DiagnosticLineWarn',
            [vim.diagnostic.severity.INFO] = 'DiagnosticLineInfo',
            [vim.diagnostic.severity.HINT] = 'DiagnosticLineHint',
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
            [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
            [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
        },
    },
}

local function set_up_highlights()
    local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
    local normal_float = vim.api.nvim_get_hl(0, { name = 'NormalFloat' })
    local float_border = vim.api.nvim_get_hl(0, { name = 'FloatBorder' })

    float_border.bg = normal.bg

    vim.api.nvim_set_hl(0, 'StatusLine', normal_float)
    vim.api.nvim_set_hl(0, 'NormalFloat', normal)
    vim.api.nvim_set_hl(0, 'FloatBorder', float_border)

    -- diagnostic line highlights
    local blend = require('samad.utils').blend
    local c_bg = normal.bg
    local c_error = vim.api.nvim_get_hl(0, { name = 'DiagnosticError' }).fg
    local c_warn = vim.api.nvim_get_hl(0, { name = 'DiagnosticWarn' }).fg
    local c_info = vim.api.nvim_get_hl(0, { name = 'DiagnosticInfo' }).fg
    local c_hint = vim.api.nvim_get_hl(0, { name = 'DiagnosticHint' }).fg

    vim.api.nvim_set_hl(0, 'DiagnosticLineError', { bg = blend(c_error, 0.1, c_bg) })
    vim.api.nvim_set_hl(0, 'DiagnosticLineWarn', { bg = blend(c_warn, 0.1, c_bg) })
    vim.api.nvim_set_hl(0, 'DiagnosticLineInfo', { bg = blend(c_info, 0.1, c_bg) })
    vim.api.nvim_set_hl(0, 'DiagnosticLineHint', { bg = blend(c_hint, 0.1, c_bg) })
end

vim.api.nvim_create_autocmd('ColorScheme', {
    desc = 'Re-apply status colors after changing colorschemes',
    group = vim.api.nvim_create_augroup('ThemeColors', { clear = true }),
    callback = set_up_highlights,
})
