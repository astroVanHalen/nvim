local aug = vim.api.nvim_create_augroup("FloatingTerm", {})

vim.api.nvim_create_autocmd("TermOpen", {
  group = aug,
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd("TermClose", {
  group = aug,
  pattern = "*",
  callback = function()
    if vim.v.event.status == 0 then
      vim.api.nvim_buf_delete(0, {})
    end
  end,
})

local term_state = { is_open = false, buf = nil, win = nil }

function _G.toggle_floating_term()
  if term_state.is_open and term_state.win and vim.api.nvim_win_is_valid(term_state.win) then
    vim.api.nvim_win_close(term_state.win, false)
    term_state.is_open = false
    return
  end

  term_state.buf = vim.api.nvim_buf_is_valid(term_state.buf) and term_state.buf or vim.api.nvim_create_buf(false, true)
  vim.bo[term_state.buf].bufhidden = "hide"

  local h = math.floor(vim.o.lines * 0.8)
  local w = math.floor(vim.o.columns * 0.8)
  local r = math.floor((vim.o.lines - h) / 2)
  local c = math.floor((vim.o.columns - w) / 2)

  term_state.win = vim.api.nvim_open_win(term_state.buf, true, {
    relative = "editor", width = w, height = h, row = r, col = c,
    style = "minimal", border = "rounded",
  })

  vim.cmd("startinsert")
  term_state.is_open = true
end

vim.keymap.set("n", "<leader>t", _G.toggle_floating_term, { desc = "Toggle floating terminal" })
vim.keymap.set("t", "<Esc>", function()
  if term_state.is_open and vim.api.nvim_win_is_valid(term_state.win) then
    vim.api.nvim_win_close(term_state.win, false)
    term_state.is_open = false
  end
end, { desc = "Close floating terminal" })
