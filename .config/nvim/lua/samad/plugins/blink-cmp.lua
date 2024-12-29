return {
    'saghen/blink.cmp',
    dependencies = {
        'rafamadriz/friendly-snippets', -- useful snippets
        'https://git.sr.ht/~p00f/clangd_extensions.nvim', -- clangd completion sorting
    },
    version = '*',
    opts = {
        appearance = {
            nerd_font_variant = 'normal',
            use_nvim_cmp_as_default = true,
        },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 300,
                window = { border = 'rounded' },
            },
            list = {
                selection = function(ctx)
                    return ctx.mode == 'cmdline' and 'auto_insert' or 'preselect'
                end,
            },
            menu = {
                border = 'rounded',
                draw = {
                    columns = {
                        { 'label', 'label_description', gap = 1 },
                        { 'kind_icon', 'kind' },
                        { 'source_name' },
                    },
                    components = {
                        source_name = {
                            width = { max = 30 },
                            text = function(ctx)
                                local name = ctx.source_name

                                if name == 'LSP' and ctx.item.client_id then
                                    pcall(function()
                                        name = vim.lsp.get_client_by_id(ctx.item.client_id).name or name
                                    end)
                                end

                                return '[' .. name .. ']'
                            end,
                            highlight = 'BlinkCmpSource',
                        },
                    },
                },
            },
        },
        keymap = { preset = 'enter' },
        signature = {
            enabled = true,
            window = { border = 'rounded' },
        },
        sources = {
            default = function()
                local success, node = pcall(vim.treesitter.get_node)
                if success and node and vim.tbl_contains({}, node:type()) then
                    return { 'buffer' }
                else
                    return { 'lsp', 'path', 'snippets', 'buffer' }
                end
            end,
        },
    },
    opts_extend = { 'sources.default' },
}
