-- fix deprecation warning in typescript-tools
-- TODO: remove when typescript-tools gets update
vim.tbl_add_reverse_lookup = function(tbl)
    for k, v in pairs(tbl) do
        tbl[v] = k
    end
end

require 'samad.core'
require 'samad.lazy'
