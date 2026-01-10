return {
    settings = {
        gopls = {
            analyses = {
                shadow = true,
                unusedvariable = true,
                useany = true,
            },
            codelenses = {
                run_govulncheck = true,
                test = true,
            },
            completeFunctionCalls = true,
            completeUnimported = true,
            directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-**/node_modules' },
            experimentalPostfixCompletions = true,
            gofumpt = true,
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
            semanticTokens = true,
            staticcheck = true,
            templateExtensions = { 'gohtml' },
            vulncheck = 'Imports',
            usePlaceholders = true,
        },
    },
}
