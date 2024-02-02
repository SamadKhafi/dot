return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'hrsh7th/cmp-nvim-lsp',
        { 'antosha417/nvim-lsp-file-operations', config = true },
        { 'folke/neodev.nvim', cond = false, opts = {} },
    },
    config = function()
        local lspconfig = require 'lspconfig'
        local cmp_nvim_lsp = require 'cmp_nvim_lsp'

        -- enable border around lsp windows
        require('lspconfig.ui.windows').default_options.border = 'rounded'

        local map = vim.keymap.set
        local opts = { noremap = true, silent = true }
        local on_attach = function(client, bufnr) -- client, bufnr
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

            opts.desc = 'Search Diagnostics'
            map('n', '<leader>lD', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)

            opts.desc = 'Hover Diagnostics'
            map('n', '<leader>ld', vim.diagnostic.open_float, opts)

            opts.desc = 'Next Diagnostic'
            map('n', ']d', vim.diagnostic.goto_next, opts)

            opts.desc = 'Previous Diagnostic'
            map('n', '[d', vim.diagnostic.goto_prev, opts)

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

            -- turn on inlay hints
            if vim.lsp.inlay_hint and client.server_capabilities.inlayHintProvider then
                -- use persistent (SHADA) variable for showing inlay hints on startup
                if vim.g.INLAY_HINTS_ENABLED ~= false then
                    vim.g.INLAY_HINTS_ENABLED = true
                    vim.lsp.inlay_hint.enable(0, true)
                else
                    vim.g.INLAY_HINTS_ENABLED = false
                end

                -- toggle inlay hints
                opts.desc = '[UI] Toggle Inlay Hints'
                map('n', '<leader>uh', function()
                    local isEnabled = vim.lsp.inlay_hint.is_enabled(0)
                    vim.lsp.inlay_hint.enable(0, not isEnabled)
                    vim.g.INLAY_HINTS_ENABLED = not isEnabled
                end, opts)
            end
        end

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- add line folding capabilities (not added by default)
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }

        -- configure servers
        local configs = require 'samad.configs.lsp'
        local utils = require 'samad.utils'

        local servers = require('mason-lspconfig').get_installed_servers()
        for _, server in pairs(servers) do
            local config = {
                capabilities = capabilities,
                on_attach = on_attach,
            }

            if type(configs[server] or false) == 'function' then
                configs[server](config)
            else
                if type(configs[server] or false) == 'table' then
                    config = utils.merge_tables(config, configs[server])
                end
            end

            lspconfig[server].setup(config)
        end
    end,
}
