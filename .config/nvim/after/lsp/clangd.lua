return {
    cmd = { 'clangd', '--query-driver=**/bin/gcc,**/bin/gcc-*,**/bin/*-gcc' },
    capabilities = {
        offsetEncoding = 'utf-8',
    },
    init_options = {
        clangdFileStatus = true,
        completeUnimported = true,
        usePlaceholders = false,
    },
}
