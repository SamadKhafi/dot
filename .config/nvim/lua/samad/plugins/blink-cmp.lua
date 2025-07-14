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
        },
        completion = {
            accept = {
                auto_brackets = { enabled = true },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 300,
                window = { border = 'rounded' },
            },
            ghost_text = { enabled = true },
            list = {
                selection = {
                    auto_insert = false,
                    preselect = false,
                },
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
        fuzzy = {
            sorts = {
                'score', -- sort by fuzzy matching score.
                function(a, b) -- custom sort using clangd `.lsp_score` property.
                    if not a.lsp_score or not b.lsp_score then
                        return
                    end

                    if a.lsp_score > b.lsp_score then
                        return true
                    elseif a.lsp_score < b.lsp_score then
                        return false
                    end
                end,
                'sort_text',
                'label', -- deprioritize entries with leading _ (underscore).
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
                if success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
                    return { 'buffer' }
                elseif vim.bo.filetype == 'lua' then
                    return { 'lsp', 'path' }
                else
                    return { 'lsp', 'path', 'snippets', 'buffer' }
                end
            end,
        },
    },
    opts_extend = { 'sources.default' },
}
