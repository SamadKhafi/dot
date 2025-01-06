return {
    'williamboman/mason-lspconfig.nvim',
    cmd = { 'LspInstall', 'LspUninstall' },
    config = function()
        local mason_lspconfig = require 'mason-lspconfig'

        mason_lspconfig.setup {
            ensure_installed = {
                'astro',
                'cssls',
                'dockerls',
                'docker_compose_language_service',
                'emmet_ls',
                'golangci_lint_ls',
                'gopls',
                'html',
                'intelephense',
                'jsonls',
                'lua_ls',
                'mdx_analyzer',
                'rust_analyzer',
                'svelte',
                'tailwindcss',
                'taplo',
                'templ',
                'tinymist',
                'ts_ls',
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
