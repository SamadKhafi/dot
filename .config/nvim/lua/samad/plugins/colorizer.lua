return {
    'catgoose/nvim-colorizer.lua',
    event = { 'BufReadPre' },
    opts = {
        lazy_load = true,
        options = {
            parsers = {
                css = true, -- preset: enables names, hex, rgb, hsl, oklch.
                css_fn = true, -- preset: enables rgb, hsl, oklch
                tailwind = {
                    enable = true,
                    lsp = true,
                },
                sass = { enable = true },
            },
            display = {
                mode = 'background', -- 'background' | 'foreground' | 'virtualtext'
                virtualtext = {
                    position = 'before',
                },
            },
        },
    },
}
