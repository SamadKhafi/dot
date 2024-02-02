return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
        {
            '<leader>lf',
            function()
                require('conform').format {
                    bufnr = 0,
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 500,
                }
            end,
            mode = { 'n', 'v' },
            desc = 'Format',
            silent = true,
            noremap = true,
        },
        {
            '<leader>lc',
            '<cmd>ConformInfo<CR>',
            mode = 'n',
            desc = '[LSP] Conform Information',
            silent = true,
            noremap = true,
        },
    },
    config = function()
        local conform = require 'conform'

        conform.setup {
            formatters_by_ft = {
                bash = { 'beautysh' },
                css = { { 'prettierd', 'prettier' } },
                go = { 'goimports', 'gofumpt' },
                gohtml = { 'djlint' },
                html = { { 'prettierd', 'prettier' } },
                javascript = { { 'prettierd', 'prettier' } }, -- run first available
                javascriptreact = { { 'prettierd', 'prettier' } },
                json = { { 'prettierd', 'prettier' } },
                less = { { 'prettierd', 'prettier' } },
                markdown = { { 'prettierd', 'prettier' } },
                lua = { 'stylua' },
                python = { 'isort', 'black' },
                sass = { { 'prettierd', 'prettier' } },
                scss = { { 'prettierd', 'prettier' } },
                sh = { 'beautysh' },
                svelte = { { 'prettierd', 'prettier' } },
                templ = { 'templ' },
                typescript = { { 'prettierd', 'prettier' } },
                typescriptreact = { { 'prettierd', 'prettier' } },
                vue = { { 'prettierd', 'prettier' } },
                yaml = { 'yamlfmt', { 'prettierd', 'prettier' } },
                zsh = { 'beautysh' },
                -- ['*'] = { 'codespell' }, -- run on all files
                -- ['_'] = { 'trim_whitespace' }, -- on files that doesn't have formatters
            },
            format_on_save = function(bufnr)
                local ignore_filetypes = {
                    'cmake',
                    'markdown',
                }

                if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
                    return
                end

                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end

                local bufname = vim.api.nvim_buf_get_name(bufnr)
                if bufname:match '/node_modules/' then
                    return
                end

                return {
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 500,
                }
            end,
        }

        -- vim.keymap.set({ 'n', 'v' }, '<leader>lf', function()
        --   conform.format {
        --     bufnr = 0,
        --     lsp_fallback = true,
        --     async = false,
        --     timeout_ms = 500,
        --   }
        -- end, { desc = 'Format' })
    end,
}
