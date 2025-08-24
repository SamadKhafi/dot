local conditions = require 'heirline.conditions'
local lsp_names = require 'samad.configs.names.lsp'

local LspActive = {
    condition = conditions.lsp_attached,

    update = { 'LspAttach', 'LspDetach', 'BufEnter' },

    provider = function()
        local names = {}
        for _, server in pairs(vim.lsp.get_clients { bufnr = 0 }) do
            if lsp_names[server.name] ~= nil then
                table.insert(names, lsp_names[server.name])
            else
                table.insert(names, server.name)
            end
        end
        return '  ' .. table.concat(names, ', ') .. '  '
    end,

    hl = { fg = 'lsp', bg = 'bg' },
}

return LspActive
