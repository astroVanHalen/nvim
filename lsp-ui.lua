local diagnostic_signs = {
  Error = " ",
  Warn  = " ",
  Hint  = "",
  Info  = "",
}

vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 4 },
  signs        = { severity = diagnostic_signs },
  underline    = true,
  update_in_insert = false,
  severity_sort    = true,
  float = {
    border    = "rounded",
    source    = "always",
    header    = "",
    prefix    = "",
    focusable = false,
    style     = "minimal",
  },
})

do
  local fn = vim.lsp.util.open_floating_preview
  vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "rounded"
    return fn(contents, syntax, opts, ...)
  end
end
