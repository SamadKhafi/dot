return {
    init = function(self)
        self.mode = vim.fn.mode(1)
    end,
    static = {
        mode_colors = {
            n = 'blue',
            i = 'green',
            v = 'cyan',
            V = 'cyan',
            ['\22'] = 'cyan',
            c = 'orange',
            s = 'purple',
            S = 'purple',
            ['\19'] = 'purple',
            R = 'orange',
            r = 'orange',
            ['!'] = 'red',
            t = 'red',
        },
    },
    provider = function()
        return ' '
    end,
    hl = function(self)
        local mode = self.mode:sub(1, 1)
        return { bg = self.mode_colors[mode] }
    end,
    update = {
        'ModeChanged',
        pattern = '*:*',
        callback = vim.schedule_wrap(function()
            vim.cmd 'redrawstatus'
        end),
    },
}
