local conditions = require 'heirline.conditions'

local Git = {
    condition = conditions.is_git_repo,

    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,

    hl = { fg = 'git_branch', bg = 'bg' },

    { -- git branch name
        provider = function(self)
            return '󰘬 ' .. self.status_dict.head
        end,
        hl = { fg = 'git_branch', bg = 'bg', bold = true },
    },

    {
        condition = function(self)
            return self.has_changes
        end,
        provider = ' [',
    },
    {
        provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and ('+' .. count)
        end,
        hl = { fg = 'git_add', bg = 'bg' },
    },
    {
        provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and ('-' .. count)
        end,
        hl = { fg = 'git_del', bg = 'bg' },
    },
    {
        provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and ('~' .. count)
        end,
        hl = { fg = 'git_change', bg = 'bg' },
    },
    {
        condition = function(self)
            return self.has_changes
        end,
        provider = ']',
    },
}

return Git
