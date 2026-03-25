local efm = {
  linters = {
    luacheck = require("efmls-configs.linters.luacheck"),
    eslint   = require("efmls-configs.linters.eslint_d"),
    cpplint  = require("efmls-configs.linters.cpplint"),
    shellcheck = require("efmls-configs.linters.shellcheck"),
    go_revive = require("efmls-configs.linters.go_revive"),
  },
  formatters = {
    stylua   = require("efmls-configs.formatters.stylua"),
    black    = require("efmls-configs.formatters.black"),
    prettier = require("efmls-configs.formatters.prettier_d"),
    fixjson  = require("efmls-configs.formatters.fixjson"),
    clangfmt = require("efmls-configs.formatters.clang_format"),
    gofumpt  = require("efmls-configs.formatters.gofumpt"),
    shfmt    = require("efmls-configs.formatters.shfmt"),
  },
}

vim.lsp.config("efm", {
  init_options = { documentFormatting = true },
  filetypes = { "c", "cpp", "css", "go", "html", "javascript", "json", "lua", "markdown", "python", "sh", "typescript", "vue", "svelte" },
  settings = { languages = efm },
})
