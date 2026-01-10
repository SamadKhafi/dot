return {
    capabilities = {},
    settings = {
        -- disable yamlls default schema store
        schemaStore = {
            enable = false,
            url = '',
        },
        schemas = require('schemastore').yaml.schemas(),
    },
}
