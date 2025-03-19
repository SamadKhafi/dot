---@param bufnr integer
---@param ... string
---@return string
local function first(bufnr, ...)
    local conform = require 'conform'
    for i = 1, select('#', ...) do
        local formatter = select(i, ...)
        if conform.get_formatter_info(formatter, bufnr).available then
            return formatter
        end
    end
    return select(1, ...)
end

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
                    async = true,
                    lsp_format = 'fallback',
                    timeout_ms = 1000,
                }
            end,
            mode = { 'n', 'v' },
            desc = '[Formatter] Format',
            silent = true,
            noremap = true,
        },
        {
            '<leader>lc',
            '<cmd>ConformInfo<CR>',
            mode = 'n',
            desc = '[Formatter] Information',
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
            formatters = {
                injected = {
                    options = {
                        ignore_errors = false,
                        lang_to_ext = {
                            bash = 'sh',
                            c_sharp = 'cs',
                            elixir = 'exs',
                            javascript = 'js',
                            julia = 'jl',
                            latex = 'tex',
                            markdown = 'md',
                            python = 'py',
                            ruby = 'rb',
                            rust = 'rs',
                            teal = 'tl',
                            typescript = 'ts',
                        },
                        lang_to_formatters = {
                            json = 'jq',
                        },
                    },
                },
                rustfmt = {
                    options = {
                        default_edition = '2021',
                    },
                },
            },
            formatters_by_ft = {
                astro = function(bufnr)
                    return { 'biome-check', first(bufnr, 'prettierd', 'prettier') }
                end,
                bash = { 'beautysh' },
                blade = { 'prettierd', 'prettier', 'blade-formatter', 'tlint', stop_after_first = true },
                css = { 'biome-check', 'prettierd', 'prettier', stop_after_first = true },
                go = { 'golines', 'goimports', 'gofumpt' },
                gohtml = { 'djlint' },
                html = { 'prettierd', 'prettier', stop_after_first = true },
                javascript = { 'biome-check', 'prettierd', 'prettier', stop_after_first = true },
                javascriptreact = { 'biome-check', 'prettierd', 'prettier', stop_after_first = true },
                json = function(bufnr)
                    return { 'fixjson', first(bufnr, 'biome-check', 'prettierd', 'prettier') }
                end,
                less = { 'prettierd', 'prettier', stop_after_first = true },
                markdown = function(bufnr)
                    return { first(bufnr, 'prettierd', 'prettier'), 'injected' }
                end,
                lua = { 'stylua' },
                mdx = function(bufnr)
                    return { first(bufnr, 'prettierd', 'prettier'), 'injected' }
                end,
                postcss = { 'prettierd', 'prettier', stop_after_first = true },
                proto = { 'clang-format', stop_after_first = true },
                python = {},
                rust = { 'rustfmt' },
                sass = { 'prettierd', 'prettier', stop_after_first = true },
                scss = { 'prettierd', 'prettier', stop_after_first = true },
                sh = { 'beautysh' },
                svelte = function(bufnr)
                    return { 'biome-check', first(bufnr, 'prettierd', 'prettier') }
                end,
                templ = { 'templ' },
                typescript = { 'biome-check', 'prettierd', 'prettier', stop_after_first = true },
                typescriptreact = { 'biome-check', 'prettierd', 'prettier', stop_after_first = true },
                typst = { 'typstfmt' },
                vue = { 'prettierd', 'prettier', stop_after_first = true },
                yaml = function(bufnr)
                    return { 'yamlfmt', first(bufnr, 'prettierd', 'prettier') }
                end,
                zsh = { 'beautysh' },
                ['_'] = { 'trim_newlines', 'trim_whitespace' }, -- on files that doesn't have formatters
            },
            default_format_opts = {
                lsp_format = 'fallback',
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
                    bufnr = bufnr,
                    timeout_ms = 300,
                    lsp_format = 'fallback',
                },
                    on_format
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

                return { bufnr = bufnr, lsp_format = 'fallback' }
            end,
        }
    end,
}
