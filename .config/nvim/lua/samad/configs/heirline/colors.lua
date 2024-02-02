local utils = require 'heirline.utils'

vim.api.nvim_set_hl(0, 'TabLineFill', { link = 'StatusLine' })

return {
    bg = utils.get_highlight('StatusLine').bg,
    normal_bg = utils.get_highlight('Normal').bg,
    bright_bg = utils.get_highlight('Folded').bg,
    bright_fg = utils.get_highlight('Folded').fg,
    divider = utils.get_highlight('NeoTreeWinSeparator').fg,

    cyan = utils.get_highlight('Special').fg,
    green = utils.get_highlight('DiffAdded').fg,
    orange = utils.get_highlight('Constant').fg,
    red = utils.get_highlight('DiagnosticError').fg,
    dark_red = utils.get_highlight('DiffDelete').bg,
    blue = utils.get_highlight('Function').fg,
    gray = utils.get_highlight('NonText').fg,
    purple = utils.get_highlight('Statement').fg,

    diag_error = utils.get_highlight('DiagnosticError').fg,
    diag_warn = utils.get_highlight('DiagnosticWarn').fg,
    diag_info = utils.get_highlight('DiagnosticInfo').fg,
    diag_hint = utils.get_highlight('DiagnosticHint').fg,

    git_branch = utils.get_highlight('diffFile').fg,
    git_add = utils.get_highlight('diffAdded').fg,
    git_del = utils.get_highlight('diffRemoved').fg,
    git_change = utils.get_highlight('diffChanged').fg,

    lazy = utils.get_highlight('LspInfoFiletype').fg,
    lsp = utils.get_highlight('LspInfoTitle').fg,
    lint = utils.get_highlight('LspInfoBorder').fg,
    format = utils.get_highlight('DiagnosticHint').fg,
    treesitter = utils.get_highlight('DiagnosticOk').fg,
}
