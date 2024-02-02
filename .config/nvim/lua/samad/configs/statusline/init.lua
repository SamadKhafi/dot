local ViMode = require 'samad.configs.statusline.vimode'
local FileNameBlock = require 'samad.configs.statusline.filename'
local Git = require 'samad.configs.statusline.git'
local Ruler = require 'samad.configs.statusline.ruler'
local Lint = require 'samad.configs.statusline.linters'
local Format = require 'samad.configs.statusline.format'
local Lsp = require 'samad.configs.statusline.lsp'
local Diagnostics = require 'samad.configs.statusline.diagnostics'
local Lazy = require 'samad.configs.statusline.lazy'
local TreeSitter = require 'samad.configs.statusline.treesitter'

local Align = { provider = '%=' }
local Space = { provider = ' ' }

return {
    ViMode,
    Space,
    Space,
    Space,
    FileNameBlock,
    Space,
    Space,
    Space,
    Git,
    Align,
    Lazy,
    Space,
    Diagnostics,
    Space,
    Space,
    Lsp,
    Lint,
    Format,
    TreeSitter,
    Ruler,
    Space,
    Space,
    ViMode,
}
