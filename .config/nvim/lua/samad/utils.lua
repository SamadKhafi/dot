local M = {}

function M.merge_tables(t1, t2)
    for k, v in pairs(t2) do
        if type(v) == 'table' then
            if type(t1[k] or false) == 'table' then
                M.merge_tables(t1[k] or {}, t2[k] or {})
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end

    return t1
end

--- Get highlight properties for a given highlight name
---@param name string The highlight group name
---@param fallback? table The fallback highlight properties
---@return table properties # the highlight group properties
function M.get_hlgroup(name, fallback)
    if vim.fn.hlexists(name) == 1 then
        local hl
        if vim.api.nvim_get_hl then -- check for new neovim 0.9 API
            hl = vim.api.nvim_get_hl(0, { name = name, link = false })
            if not hl.fg then
                hl.fg = 'NONE'
            end
            if not hl.bg then
                hl.bg = 'NONE'
            end
        else
            hl = vim.api.nvim_get_hl_by_name(name, vim.o.termguicolors)
            if not hl.foreground then
                hl.foreground = 'NONE'
            end
            if not hl.background then
                hl.background = 'NONE'
            end
            hl.fg, hl.bg = hl.foreground, hl.background
            hl.ctermfg, hl.ctermbg = hl.fg, hl.bg
            hl.sp = hl.special
        end
        return hl
    end
    return fallback or {}
end

function M.dump_table(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. '[' .. k .. '] = ' .. M.dump_table(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

function M.is_unix()
    local sysname = vim.loop.os_uname().sysname
    return sysname == 'Linux' or sysname == 'Darwin'
end

function M.insert_in_place(text)
    local pos = vim.api.nvim_win_get_cursor(0)[2]
    local line = vim.api.nvim_get_current_line()
    local nline = line:sub(0, pos) .. text .. line:sub(pos + 1)
    vim.api.nvim_set_current_line(nline)
end

function M.get_unix_micros()
    local seconds, micros = vim.uv.gettimeofday()
    return string.format('%d%06d', seconds, micros)
end

function M.get_unix_millis()
    local seconds, micros = vim.uv.gettimeofday()
    local millis = math.floor(micros / 1000)
    return string.format('%d%03d', seconds, millis)
end

function M.get_unix_seconds()
    local seconds = vim.uv.gettimeofday()
    return seconds
end

return M
