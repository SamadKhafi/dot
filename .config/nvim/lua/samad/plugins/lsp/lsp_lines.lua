return {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    event = 'LspAttach',
    keys = {
        {
            '<Leader>ud',
            function()
                local show_virtual_text = not require('lsp_lines').toggle()

                vim.diagnostic.config {
                    virtual_text = show_virtual_text,
                }

                vim.g.LSP_LINES_ENABLED = not show_virtual_text
            end,
            desc = '[UI] Toggle virtual diagnostic lines',
        },
    },
    config = function()
        -- use persistent (SHADA) variable for showing lsp lines on startup
        if vim.g.LSP_LINES_ENABLED ~= false then
            vim.g.LSP_LINES_ENABLED = true
        else
            vim.g.LSP_LINES_ENABLED = false
        end

        -- disable vim's diagnostic virtual text
        vim.diagnostic.config {
            virtual_text = not vim.g.LSP_LINES_ENABLED,
            severity_sort = true,
            underline = { severity = vim.diagnostic.severity.ERROR },
            float = {
                focusable = false,
                severity_sort = true,
                border = 'rounded',
                source = true,
                header = '',
                prefix = '',
            },
        }

        require('lsp_lines').setup()

        if vim.g.LSP_LINES_ENABLED then
            require('lsp_lines').toggle()
        end
    end,
}
