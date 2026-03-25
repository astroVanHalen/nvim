local aug = vim.api.nvim_create_augroup("LSPGroup", {})

vim.api.nvim_create_autocmd("LspAttach", {
  group = aug,
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then return end
    local bufnr, map = ev.buf, vim.keymap.set
    local opts = { noremap = true, silent = true, buffer = bufnr }

    map("n", "<leader>gd", function()
      require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
    end, opts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
    map("n", "]d", function() vim.diagnostic.goto_next() end, opts)
    -- Add more mappings...
  end,
})

vim.lsp.config["*"] = {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
}

-- Language servers
vim.lsp.config("lua_ls", { settings = { Lua = { diagnostics = { globals = { "vim" } }, telemetry = { enable = false } } } })
vim.lsp.config("pyright", {})
vim.lsp.config("bashls", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("gopls", {})
vim.lsp.config("clangd", {})

vim.lsp.enable({ "lua_ls", "pyright", "bashls", "ts_ls", "gopls", "clangd", "efm" })
