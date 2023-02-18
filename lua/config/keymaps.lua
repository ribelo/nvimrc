-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

local map = vim.keymap.set
local api = vim.api

vim.keymap.del("n", "<leader>l")
map("i", "jk", "<esc>l", opts)
map("n", "<leader>L", "<cmd>:Lazy<cr>", { desc = "Lazy" })
-- leader timeout
-- (vim.cmd("set timeoutlen=1000"))

-- do not yank with x
map("n", "x", '"_x')
--
-- (map :n "q:" :<nop> opts) ;; add timeout to q :/
--
-- window keys
map("n", "<leader>ws", ":split<CR>", opts)
map("n", "<leader>wv", ":vsplit<CR>", opts)
map("n", "<leader>wd", ":q!<CR>", opts)

-- terminal
-- map("t", "<esc>", "<C-\\><C-n>", opts)
-- (map :t :jk "<C-\\><C-n>" opts)
-- (map :v :<localleader>ss ":ToggleTermSendVisualSelection<CR>" opts)
--
-- buffer keys
map("n", "<leader>bs", ":w<CR>", opts)
map("n", "<leader>bS", ":wa<CR>", opts)
--
-- tabs keys
map("n", "<leader>tn", ":tabnew<CR>", opts)
map("n", "<leader>tc", ":tabc<CR>", opts)

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
  map("n", lhs, rhs, { desc = "Move to window " .. i })
end
