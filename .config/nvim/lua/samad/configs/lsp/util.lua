local util = require 'lspconfig/util'

function util.migrate_to_svelte_5()
    local params = {
        command = 'migrate_to_svelte_5',
        arguments = { vim.uri_from_bufnr(0) },
    }

    local clients = util.get_lsp_clients {
        bufnr = vim.api.nvim_get_current_buf(),
        name = 'svelte',
    }

    for _, client in ipairs(clients) do
        client.request('workspace/executeCommand', params, nil, 0)
    end
end

return util
