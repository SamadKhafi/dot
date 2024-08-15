local utils = require 'samad.utils'
local conditions = require 'heirline.conditions'

local signs = utils.get_diagnostic_signs()

local Diagnostics = {

    condition = conditions.has_diagnostics,

    static = {
        error_icon = signs[vim.diagnostic.severity.ERROR],
        warn_icon = signs[vim.diagnostic.severity.WARN],
        info_icon = signs[vim.diagnostic.severity.INFO],
        hint_icon = signs[vim.diagnostic.severity.HINT],
    },

    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    end,

    update = { 'DiagnosticChanged', 'BufEnter' },

    on_click = {
        callback = function(_, _, _, _, _)
            vim.cmd.Telescope 'diagnostics'
        end,
        name = 'OpenTelescopeDiagnostics',
        update = true,
        winwid = 0,
    },

    {
        provider = function(self)
            -- 0 is just another output, we can decide to print it or not!
            return self.errors > 0 and (self.error_icon .. self.errors .. ' ')
        end,
        hl = { fg = 'diag_error', bg = 'bg' },
    },
    {
        provider = function(self)
            return self.warnings > 0 and (self.warn_icon .. self.warnings .. ' ')
        end,
        hl = { fg = 'diag_warn', bg = 'bg' },
    },
    {
        provider = function(self)
            return self.info > 0 and (self.info_icon .. self.info .. ' ')
        end,
        hl = { fg = 'diag_info', bg = 'bg' },
    },
    {
        provider = function(self)
            return self.hints > 0 and (self.hint_icon .. self.hints)
        end,
        hl = { fg = 'diag_hint', bg = 'bg' },
    },
}

return Diagnostics
