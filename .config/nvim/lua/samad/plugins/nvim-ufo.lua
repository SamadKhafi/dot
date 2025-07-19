local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' 󰁂 %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, 'MoreMsg' })
    return newVirtText
end

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
            fold_virt_text_handler = handler,
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
