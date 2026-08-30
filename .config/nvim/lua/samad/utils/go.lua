local M = {}

local cache = {}

function M.module_name(filename)
    local go_mod = vim.fs.find('go.mod', {
        path = filename,
        upward = true,
    })[1]

    if not go_mod then
        return nil
    end

    local cached = cache[go_mod]

    if cached ~= nil then
        return cached or nil
    end

    local ok, lines = pcall(vim.fn.readfile, go_mod)

    if not ok then
        cache[go_mod] = false
        return nil
    end

    for _, line in ipairs(lines) do
        local module = line:match '^%s*module%s+([^%s]+)'

        if module then
            cache[go_mod] = module
            return module
        end
    end

    cache[go_mod] = false

    return nil
end

return M
