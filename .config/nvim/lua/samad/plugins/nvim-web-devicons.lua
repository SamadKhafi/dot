return {
    'nvim-tree/nvim-web-devicons',
    opts = {
        strict = true,
        override_by_extension = {
            astro = {
                icon = '',
                color = '#E5560C',
                name = 'Astro',
            },
            typ = {
                icon = '',
                color = '#01A1AD',
                name = 'Typst',
            },
        },
    },
}
