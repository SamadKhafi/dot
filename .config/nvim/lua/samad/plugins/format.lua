return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
        {
            '<leader>lf',
            function()
                -- skip if current buffer is readonly buffer
                if not vim.bo.modifiable or vim.bo.readonly then
                    return
                end

                require('conform').format {
                    bufnr = 0,
                    lsp_fallback = true,
                    async = true,
                    timeout_ms = 1000,
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

        local ignore_filetypes = {
            'cmake',
            'markdown',
        }

        local slow_format_filetypes = {}

        conform.setup {
            formatters_by_ft = {
                astro = { 'rustywind', { 'prettierd', 'prettier' } },
                bash = { 'beautysh' },
                blade = { { 'prettierd', 'prettier', 'blade-formatter', 'tlint' } },
                css = { { 'prettierd', 'prettier' } },
                go = { 'goimports', 'gofumpt' },
                gohtml = { 'rustywind', 'djlint' },
                html = { 'rustywind', { 'prettierd', 'prettier' } },
                javascript = { { 'prettierd', 'prettier' } }, -- run first available
                javascriptreact = { { 'prettierd', 'prettier' } },
                json = { 'fixjson', { 'prettierd', 'prettier' } },
                less = { { 'prettierd', 'prettier' } },
                markdown = { { 'prettierd', 'prettier' } },
                lua = { 'stylua' },
                mdx = { { 'prettierd', 'prettier' } },
                php = { 'pint', 'tlint' },
                postcss = { { 'prettierd', 'prettierd' } },
                python = { 'isort', 'black' },
                sass = { { 'prettierd', 'prettier' } },
                scss = { { 'prettierd', 'prettier' } },
                sh = { 'beautysh' },
                svelte = { 'rustywind', { 'prettierd', 'prettier' } },
                templ = { 'rustywind', 'templ' },
                typescript = { { 'prettierd', 'prettier' } },
                typescriptreact = { { 'prettierd', 'prettier' } },
                typst = { 'typstfmt' },
                vue = { 'rustywind', { 'prettierd', 'prettier' } },
                yaml = { 'yamlfmt', { 'prettierd', 'prettier' } },
                zsh = { 'beautysh' },
                -- ['*'] = { 'codespell' }, -- run on all files
                ['_'] = { 'trim_newlines', 'trim_whitespace' }, -- on files that doesn't have formatters
            },
            format_on_save = function(bufnr)
                if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
                    return
                end

                if slow_format_filetypes[vim.bo[bufnr].filetype] then
                    return
                end

                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end

                local bufname = vim.api.nvim_buf_get_name(bufnr)
                if bufname:match '/node_modules/' then
                    return
                end

                local function on_format(err)
                    if err and err:match 'timeout$' then
                        slow_format_filetypes[vim.bo[bufnr].filetype] = true
                    end
                end

                return {
                    timeout_ms = 300,
                    lsp_fallback = true,
                }, on_format
            end,
            format_after_save = function(bufnr)
                if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
                    return
                end

                if not slow_format_filetypes[vim.bo[bufnr].filetype] then
                    return
                end

                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end

                local bufname = vim.api.nvim_buf_get_name(bufnr)
                if bufname:match '/node_modules/' then
                    return
                end

                return { lsp_fallback = true }
            end,
        }
    end,
}
