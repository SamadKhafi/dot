local Venv = {
    condition = function()
        local venv = os.getenv 'VIRTUAL_ENV'
        return venv
    end,

    provider = function()
        local venv = os.getenv 'VIRTUAL_ENV'
        if venv then
            return '(' .. vim.fn.fnamemodify(venv, ':h:t') .. ')'
        end

        return ''
    end,

    hl = { fg = 'venv', bg = 'bg' },
}

return Venv
