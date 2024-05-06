-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.del("n", "<leader>l") -- remove lazy vim keybind
vim.keymap.del("n", "<leader><leader>") -- remove telescope find_files rot
vim.keymap.set("n", "<leader><leader>", ":Telescope find_files<cr>", { desc = "Find files" })
vim.keymap.set("i", "<C-CR>", "<C-o>o")

vim.keymap.set("i", "jk", "<esc>l")
vim.keymap.set("n", "<leader>L", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- do not yank with x
vim.keymap.set("n", "x", '"_x')

-- window keys
vim.keymap.set("n", "<leader>ws", ":split<CR>", { desc = "Window hsplit" })
vim.keymap.set("n", "<leader>wv", ":vsplit<CR>", { desc = "Window vsplit" })
vim.keymap.set("n", "<leader>wd", ":q!<CR>", { desc = "Window delete!" })

--
-- buffer keys
vim.keymap.set("n", "<leader>bs", ":w<CR>", { desc = "Save buffer" })
vim.keymap.set("n", "<leader>bS", ":wa<CR>", { desc = "Save all buffers" })
--
-- tabs keys
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tc", ":tabc<CR>", { desc = "Close tab" })

-- scratch
vim.keymap.set("n", "<leader>bx", ":e" .. vim.fn.expand("~/.local/share/nvim/scratch") .. "<CR>", { desc = "Scratch" })

-- yank file name without extension
vim.keymap.set("n", "<leader>y.", ":let @+ = expand('%:t:r')<CR>", { desc = "Yank name" })

vim.keymap.set("n", "<leader>sl", function()
  vim.ui.select({
    { label = "en", value = "en" },
    { label = "pl", value = "pl" },
    { label = "turn off" },
  }, {
    prompt = "Choose spell language",
    format_item = function(item)
      return item.label
    end,
  }, function(selected)
    if selected and selected.value then
      vim.cmd("set spelllang=" .. selected.value)
      vim.notify("Spall language set to " .. selected.value)
    elseif selected and not selected.value then
      vim.cmd("set nospell")
      vim.notify("Spell checker turned off")
    end
  end)
end, { desc = "Choose spell lang" })

vim.keymap.set("n", "<leader>Se", ":set spelllang=en_us<CR>")
vim.keymap.set("n", "<leader>Sp", ":set spelllang=pl<CR>")

local ignore_windows = {
  "DiffviewFilePanel$",
  "neo-tree",
}

local function should_ignore_window(name)
  for _, pattern in ipairs(ignore_windows) do
    if string.match(name, pattern) then
      return true
    end
  end
  return false
end

---@param idx integer
local function change_window(idx)
  local current_tabpage = vim.api.nvim_get_current_tabpage()
  local list = vim.api.nvim_tabpage_list_wins(current_tabpage)
  local windows = {}

  for _, id in ipairs(list) do
    local name = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(id))

    if not should_ignore_window(name) then
      table.insert(windows, id)
    end
  end

  local target_index = idx
  while target_index > #windows do
    target_index = target_index - #windows
  end

  if windows[target_index] ~= nil then
    vim.api.nvim_set_current_win(windows[target_index])
  end
end

for i = 1, 6, 1 do
  local lhs = "<m-" .. i .. ">"
  local rhs = function()
    change_window(i)
  end
  vim.keymap.set("n", lhs, rhs, { desc = "Move to window " .. i })
end

-- toggle backups
local backup_state = vim.o.backup
vim.keymap.set("n", "<leader>tb", function()
  vim.o.backup = not backup_state
  vim.o.writebackup = not backup_state
  backup_state = vim.o.backup
  vim.notify("Backup " .. (backup_state and "enabled" or "disabled"))
end, { desc = "Toggle backup" })
