local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- inlay hints handler
local function set_inlay_hints(client)
    -- skip if not supported by client/server
    if not vim.lsp.inlay_hint or not client.server_capabilities.inlayHintProvider then
        return
    end

    -- turn on inlay hints
    -- use persistent (SHADA) variable for showing inlay hints on startup
    if vim.g.INLAY_HINTS_ENABLED ~= false then
        vim.g.INLAY_HINTS_ENABLED = true
        vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
    else
        vim.g.INLAY_HINTS_ENABLED = false
    end

    -- keymap to toggle inlay hints
    opts.desc = '[UI] Toggle Inlay Hints'
    map('n', '<leader>uh', function()
        local is_enabled = vim.lsp.inlay_hint.is_enabled { bufnr = 0 }

        vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = 0 })
        vim.g.INLAY_HINTS_ENABLED = not is_enabled
    end, opts)
end

-- default on_attach handler
local function default_on_attach(client, bufnr) -- client, bufnr
    opts.buffer = bufnr

    opts.desc = 'Show references'
    -- set keybinds
    map('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)

    opts.desc = 'Goto Declarations'
    map('n', 'gD', vim.lsp.buf.definition, opts)

    opts.desc = 'Show definitions'
    map('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)

    opts.desc = 'Show implementations'
    map('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)

    opts.desc = 'Show type definitions'
    map('n', 'gi', '<cmd>Telescope lsp_type_definitions<CR>', opts)

    -- opts.desc = 'Show code actions'
    -- map({ 'n', 'v' }, '<leader>la', vim.lsp.buf.code_action, opts)

    -- opts.desc = 'LSP Rename Symbol'
    -- map('n', '<leader>lr', vim.lsp.buf.rename, opts)

    opts.desc = '[LSP] Search Diagnostics'
    map('n', '<leader>lD', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)

    opts.desc = '[LSP] Hover Diagnostics'
    map('n', '<leader>ld', vim.diagnostic.open_float, opts)

    -- opts.desc = 'Next Diagnostic'
    -- map('n', ']d', vim.diagnostic.goto_next, opts)

    -- opts.desc = 'Previous Diagnostic'
    -- map('n', '[d', vim.diagnostic.goto_prev, opts)

    -- opts.desc = '[LSP] Hover documentation'
    -- map('n', 'K', vim.lsp.buf.hover, opts)

    opts.desc = '[LSP] Signature help'
    map('n', '<leader>lh', vim.lsp.buf.signature_help, opts)

    opts.desc = '[LSP] Symbols'
    map('n', '<leader>ls', '<cmd>Telescope lsp_document_symbols<CR>', opts)

    opts.desc = '[LSP] Workspace Symbols'
    map('n', '<leader>lG', '<cmd>Telescope lsp_workspace_symbols<CR>', opts)

    opts.desc = '[LSP] Information'
    map('n', '<leader>lI', '<cmd>LspInfo<CR>', opts)

    set_inlay_hints(client)
end

return {
    astro = {
        on_attach = function(client, _)
            local astro_notify = vim.api.nvim_create_augroup('AstroNotifyTSChange', { clear = true })

            -- notify astro-ls when js, ts, json etc file changes
            vim.api.nvim_create_autocmd('BufWritePost', {
                group = astro_notify,
                pattern = { '*.js', '*.ts', '*.mts', '*.mjs', '*.cjs', '*.cts', '*.json' },
                callback = function(ctx)
                    client.notify('workspace/didChangeWatchedFiles', {
                        changes = {
                            {
                                uri = ctx.match,
                                type = 2, -- 1 = file created, 2 = file changed, 3 = file deleted
                            },
                        },
                    })
                end,
            })
        end,
    },
    svelte = {
        on_attach = function(client, _)
            local svelte_notify = vim.api.nvim_create_augroup('SvelteNotifyTSChange', { clear = true })

            -- notify svelte-language-server when js, ts, json etc file changes
            vim.api.nvim_create_autocmd('BufWritePost', {
                group = svelte_notify,
                pattern = { '*.js', '*.ts', '*.mts', '*.mjs', '*.cjs', '*.cts', '*.json' },
                callback = function(ctx)
                    client.notify('$/onDidChangeTsOrJsFile', { uri = ctx.match })
                end,
            })
        end,
    },
    -- runs for all
    ['*'] = {
        on_attach = default_on_attach,
    },
}
