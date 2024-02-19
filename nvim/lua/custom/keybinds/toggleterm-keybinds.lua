local function map(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, { silent = true })
end

return {
  setup = function()
    -- Window Navigation
    map("n", "<C-h>", "<C-w>h")
    map("n", "<C-l>", "<C-w>l")
    map("n", "<C-k>", "<C-w>k")
    map("n", "<C-j>", "<C-w>j")

    -- Terminal Navigation
    map("t", "<C-h>", "<C-\\><C-N><C-h>")
    map("t", "<C-l>", "<C-\\><C-N><C-l>")
    map("t", "<C-j>", "<C-\\><C-N><C-j>")
    map("t", "<C-k>", "<C-\\><C-N><C-k>")

    vim.cmd('autocmd! TermOpen * startinsert')
  end,
}

