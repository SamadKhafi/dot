return {
    'catppuccin/nvim',
    cond = false,
    priority = 1000,
    name = 'catppuccin',
    lazy = false,
    config = function()
        require('catppuccin').setup {
            -- flavour = 'macchiato',
            flavour = 'mocha',
            integrations = {
                aerial = true,
                alpha = true,
                cmp = true,
                dap = true,
                dap_ui = true,
                fidget = true,
                gitsigns = true,
                harpoon = true,
                headlines = true,
                lsp_saga = true,
                lsp_trouble = true,
                markdown = true,
                mason = true,
                native_lsp = {
                    enabled = true,
                    inlay_hints = {
                        background = true,
                    },
                },
                notify = true,
                neotree = true,
                semantic_tokens = true,
                symbols_outline = true,
                telescope = { enabled = true },
                treesitter = true,
                treesitter_context = true,
                ts_rainbow = false,
                ts_rainbow2 = true,
                which_key = true,
                ufo = true,
            },
        }

        vim.cmd.colorscheme 'catppuccin'
    end,
}
