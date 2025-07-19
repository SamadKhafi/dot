return {
    'kevinhwang91/nvim-ufo',
    dependencies = {
        'kevinhwang91/promise-async',
        {
            'luukvbaal/statuscol.nvim',
            config = function()
                local builtin = require 'statuscol.builtin'
                require('statuscol').setup {
                    relculright = true,
                    segments = {
                        { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
                        { text = { '%s' }, click = 'v:lua.ScSa' },
                        { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
                    },
                }
            end,
        },
    },
    event = 'BufReadPost',
    config = function()
        local ufo = require 'ufo'
        local promise = require 'promise'

        ufo.setup {
            preview = {
                mappings = {
                    scrollB = '<C-b>',
                    scrollF = '<C-f>',
                    scrollU = '<C-u>',
                    scrollD = '<C-d>',
                },
            },
            provider_selector = function(bufnr, filetype, buftype)
                local function handleFallbackException(err, providerName)
                    if type(err) == 'string' and err:match 'UfoFallbackException' then
                        return ufo.getFolds(bufnr, providerName)
                    else
                        return promise.reject(err)
                    end
                end

                return (filetype == '' or buftype == 'nofile') and 'indent' -- only use indent until a file is opened
                    or function()
                        return ufo.getFolds(bufnr, 'lsp')
                            :catch(function(err)
                                return handleFallbackException(err, 'treesitter')
                            end)
                            :catch(function(err)
                                return handleFallbackException(err, 'indent')
                            end)
                    end
            end,
        }

        vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
        vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
        vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
        vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
    end,
}
