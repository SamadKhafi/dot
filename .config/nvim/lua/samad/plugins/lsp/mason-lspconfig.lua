return {
    'williamboman/mason-lspconfig.nvim',
    cmd = { 'LspInstall', 'LspUninstall' },
    config = function()
        local mason_lspconfig = require 'mason-lspconfig'

        mason_lspconfig.setup {
            ensure_installed = {
                'clangd',
                'cmake',
                'cssls',
                'dockerls',
                'emmet_ls',
                'gopls',
                'html',
                'jsonls',
                'lua_ls',
                'marksman',
                'rust_analyzer',
                'svelte',
                'tailwindcss',
                'taplo',
                'tsserver',
                'typos_lsp',
                'vimls',
                'yamlls',
                'zls',
            },
            -- auto-install configured servers (with lspconfig)
            automatic_install = true, -- not the same as ensure_installed
        }
    end,
}
