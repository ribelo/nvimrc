-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.del("n", "<leader>l") -- remove lazy vim keybind
vim.keymap.del("n", "<leader><leader>") -- remove telescope find_files rot
vim.keymap.set("n", "<leader><leader>", ":Telescope find_files<cr>", { desc = "Find files" })
vim.keymap.set("i", "<C-CR>", "<C-o>o")

vim.keymap.set("i", "jk", "<esc>l")
vim.keymap.set("n", "<leader>L", "<cmd>:Lazy<cr>", { desc = "Lazy" })
-- leader timeout
-- (vim.cmd("set timeoutlen=1000"))

-- do not yank with x
vim.keymap.set("n", "x", '"_x')
--
-- (map :n "q:" :<nop> opts) ;; add timeout to q :/
--
-- window keys
vim.keymap.set("n", "<leader>ws", ":split<CR>", { desc = "Window hsplit" })
vim.keymap.set("n", "<leader>wv", ":vsplit<CR>", { desc = "Window vsplit" })
vim.keymap.set("n", "<leader>wd", ":q!<CR>", { desc = "Window delete!" })

-- terminal
-- map("t", "<esc>", "<C-\\><C-n>", opts)
-- (map :t :jk "<C-\\><C-n>" opts)
-- (map :v :<localleader>ss ":ToggleTermSendVisualSelection<CR>" opts)
--
-- buffer keys
vim.keymap.set("n", "<leader>bs", ":w<CR>", { desc = "Save buffer" })
vim.keymap.set("n", "<leader>bS", ":wa<CR>", { desc = "Save all buffers" })
--
-- tabs keys
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tc", ":tabc<CR>", { desc = "Close tab" })

-- change window to id
local function change_window(x)
  local list = vim.api.nvim_list_wins()
  local windows = {}
  for _, id in ipairs(list) do
    local win = vim.api.nvim_win_get_number(id)
    windows[win] = id
  end
  if windows[x] ~= nil then
    vim.api.nvim_set_current_win(windows[x])
  end
end

for i = 1, 6, 1 do
  local lhs = "<m-" .. i .. ">"
  local rhs = function()
    change_window(i)
  end
  vim.keymap.set("n", lhs, rhs, { desc = "Move to window " .. i })
end
