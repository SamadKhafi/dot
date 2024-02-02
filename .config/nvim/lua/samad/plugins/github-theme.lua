return {
    'projekt0n/github-nvim-theme',
    cond = false,
    priority = 1000,
    name = 'github-theme',
    lazy = false,
    config = function()
        require('github-theme').setup {
            dim_inactive = { enabled = true, percentage = 0.25 },
            integrations = {
                aerial = true,
                alpha = true,
                cmp = true,
                dap = { enabled = true, enable_ui = true },
                fidget = true,
                gitsigns = true,
                harpoon = true,
                headlines = true,
                lsp_trouble = true,
                markdown = true,
                mason = true,
                native_lsp = {
                    enabled = true,
                },
                notify = true,
                neotree = true,
                octo = true,
                sandwich = true,
                semantic_tokens = true,
                symbols_outline = true,
                telescope = true,
                treesitter = true,
                treesitter_context = true,
                ts_rainbow = false,
                ts_rainbow2 = true,
                which_key = true,
            },
        }

        vim.cmd.colorscheme 'github_dark_dimmed'
    end,
}
