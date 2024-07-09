return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-buffer', -- source for text in buffer
        'hrsh7th/cmp-path', -- source for file system paths
        'L3MON4D3/LuaSnip', -- snippet engine
        'saadparwaiz1/cmp_luasnip', -- for autocompletion
        'rafamadriz/friendly-snippets', -- useful snippets
        'onsails/lspkind.nvim', -- vscode like pictograms
        'https://git.sr.ht/~p00f/clangd_extensions.nvim', -- clangd completion sorting
    },
    config = function()
        local cmp = require 'cmp'
        local luasnip = require 'luasnip'
        local lspkind = require 'lspkind'
        local compare = require 'cmp.config.compare'

        -- loads vscode style snippets from installed plugins. (e.g. friendly-snippets)
        require('luasnip.loaders.from_vscode').lazy_load()

        local lspkind_comparator = function(conf)
            local lsp_types = require('cmp.types').lsp
            local kinds = lsp_types.CompletionItemKind

            return function(entry1, entry2)
                if entry1.source.name ~= 'nvim_lsp' then
                    if entry2.source.name == 'nvim_lsp' then
                        return false
                    else
                        return nil
                    end
                end
                local kind1 = kinds[entry1:get_kind()]
                local kind2 = kinds[entry2:get_kind()]

                local priority1 = conf.kind_priority[kind1] or 0
                local priority2 = conf.kind_priority[kind2] or 0
                if priority1 == priority2 then
                    return nil
                end
                return priority2 < priority1
            end
        end

        local label_comparator = function(entry1, entry2)
            return entry1.completion_item.label < entry2.completion_item.label
        end

        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
        end

        local clangd_score = require 'clangd_extensions.cmp_scores'

        cmp.setup {
            completion = {
                completeopt = 'menu,menuone,preview,noselect',
            },
            snippet = { -- configure how nvim-cmp interacts with snippet engine
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert {
                ['<C-p>'] = cmp.mapping.select_prev_item(), -- previous suggestion
                ['<C-n>'] = cmp.mapping.select_next_item(), -- next suggestion
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(), -- show suggestions
                ['<C-e>'] = cmp.mapping.abort(), -- close completion window
                ['<CR>'] = cmp.mapping.confirm { select = false }, -- select -> false = explicitly selected completion only

                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),

                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            },
            sorting = {
                comparators = {
                    compare.offset,
                    compare.exact,
                    clangd_score,
                    compare.score,
                    lspkind_comparator {
                        kind_priority = {
                            Field = 11,
                            Property = 11,
                            Constant = 10,
                            Enum = 10,
                            EnumMember = 10,
                            Event = 10,
                            Function = 10,
                            Method = 10,
                            Operator = 10,
                            Reference = 10,
                            Struct = 10,
                            Variable = 9,
                            File = 8,
                            Folder = 8,
                            Class = 5,
                            Color = 5,
                            Module = 5,
                            Keyword = 2,
                            Constructor = 1,
                            Interface = 1,
                            Snippet = 0,
                            Text = 1,
                            TypeParameter = 1,
                            Unit = 1,
                            Value = 1,
                        },
                    },
                    compare.scope,
                    label_comparator,
                },
            },
            -- sources for autocompletion
            sources = cmp.config.sources {
                { name = 'codeium' },
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- snippets
                { name = 'path' }, -- file system paths
            },
            {
                { name = 'buffer' }, -- text within current buffer
            },
            -- configure lspkind for vscode like pictograms in completion menu
            formatting = {
                expandable_indicator = true,
                fields = { 'abbr', 'kind', 'menu' },
                format = lspkind.cmp_format {
                    mode = 'symbol_text',
                    maxwidth = 50,
                    ellipsis_char = '...',
                    symbol_map = {
                        Array = '',
                        Boolean = '',
                        Codeium = '',
                        Key = '',
                        Namespace = '',
                        Null = '',
                        Number = '',
                        Object = '',
                        Package = '',
                        String = '',
                    },
                    before = function(entry, vim_item)
                        local menu_items = {
                            buffer = '[Buffer]',
                            codeium = '[AI]',
                            luasnip = '[LuaSnip]',
                            nvim_lsp = '[LSP]',
                            path = '[Path]',
                        }

                        if entry.source.name == 'nvim_lsp' then
                            local lsp_server = ''

                            pcall(function()
                                lsp_server = entry.source.source.client.name or 'nvim_lsp'
                            end)

                            vim_item.menu = '[' .. lsp_server .. ']'
                        else
                            vim_item.menu = menu_items[entry.source.name]
                        end

                        return vim_item
                    end,
                },
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
        }

        -- correct markdown highlighting using treesitter
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'cmp_docs',
            callback = function()
                vim.treesitter.start(0, 'markdown')
            end,
        })
    end,
}
