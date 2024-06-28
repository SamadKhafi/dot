return {
    'williamboman/mason-lspconfig.nvim',
    cmd = { 'LspInstall', 'LspUninstall' },
    config = function()
        local mason_lspconfig = require 'mason-lspconfig'

        mason_lspconfig.setup {
            ensure_installed = {
                'astro',
                'clangd',
                'cmake',
                'cssls',
                'dockerls',
                'emmet_ls',
                'gopls',
                'html',
                'jsonls',
                'lemminx',
                'lua_ls',
                'marksman',
                'rust_analyzer',
                'somesass_ls',
                'svelte',
                'tailwindcss',
                'taplo',
                'templ',
                'tsserver',
                'typos_lsp',
                'typst_lsp',
                'vimls',
                'yamlls',
                'zls',
            },
            -- auto-install configured servers (with lspconfig)
            automatic_install = true, -- not the same as ensure_installed
        }
    end,
}
