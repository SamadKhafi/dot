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

        local configs = require 'samad.configs.lsp'
        local handlers = require 'samad.configs.lsp.handlers'

        -- enable border around lsp windows
        require('lspconfig.ui.windows').default_options.border = 'rounded'

        ------------------
        -- CAPABILITIES --
        ------------------

        -- used to enable autocompletion (assign to every lsp server config)
        local default_capabilities = cmp_nvim_lsp.default_capabilities()

        local additional_capabilities = {
            -- add line folding capabilities (not added by default)
            textDocument = {
                foldingRange = {
                    dynamicRegistration = false,
                    lineFoldingOnly = true,
                },
            },
            -- send file changed event to language servers
            workspace = {
                didChangeConfiguration = {
                    dynamicRegistration = true,
                },
                didChangeWatchedFiles = {
                    dynamicRegistration = true,
                },
                didChangeWorkspaceFolders = {
                    dynamicRegistration = true,
                },
            },
        }

        local capabilities = vim.tbl_deep_extend('keep', additional_capabilities, default_capabilities)

        ---------------
        -- ON ATTACH --
        ---------------

        local function run_on_attach_handler(name, client, bufnr)
            -- check if handler exists
            if type(handlers[name] or false) == 'table' then
                local handler = handlers[name]

                -- check if handler has on_attach method
                if type(handler['on_attach'] or false) == 'function' then
                    handler.on_attach(client, bufnr)
                end
            end
        end

        -----------------
        -- INTEGRATION --
        -----------------

        -- setup each mason installed server
        local servers = require('mason-lspconfig').get_installed_servers()

        for _, server in pairs(servers) do
            -- skip disabled servers
            if vim.tbl_contains(configs.disable, server) then
                goto continue
            end

            -- default configs
            local config = {
                -- provide lsp client (neovim) capabilities to lsp server
                capabilities = capabilities,
                -- runs when lsp server attaches to a buffer
                on_attach = function(client, bufnr)
                    -- run custom handler
                    run_on_attach_handler(server, client, bufnr)

                    -- default handler
                    run_on_attach_handler('*', client, bufnr)
                end,
                flags = {
                    debounce_text_changes = 150,
                },
            }

            -- extend default configs with custom configs
            if type(configs[server] or false) == 'function' then
                configs[server](config)
            elseif type(configs[server] or false) == 'table' then
                config = vim.tbl_deep_extend('keep', configs[server], config)
            end

            -- integrate lsp server with neovim
            lspconfig[server].setup(config)

            ::continue::
        end
    end,
}
