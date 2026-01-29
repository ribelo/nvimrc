-- Keymaps

local map = vim.keymap.set

-- basic
map("i", "jk", "<esc>l")
map("i", "<C-CR>", "<C-o>o")

-- do not yank with x
map("n", "x", '"_x')

-- window
map("n", "<leader>ws", ":split<CR>", { desc = "Window hsplit" })
map("n", "<leader>wv", ":vsplit<CR>", { desc = "Window vsplit" })
map("n", "<leader>wd", ":q!<CR>", { desc = "Window delete!" })

-- buffers
map("n", "<leader>bs", ":w<CR>", { desc = "Save buffer" })
map("n", "<leader>bS", ":wa<CR>", { desc = "Save all buffers" })

-- tabs
map("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })
map("n", "<leader>tc", ":tabc<CR>", { desc = "Close tab" })

-- scratch
map("n", "<leader>bx", ":e" .. vim.fn.expand("~/.local/share/nvim/scratch") .. "<CR>", { desc = "Scratch" })

-- yank file name without extension
map("n", "<leader>y.", ":let @+ = expand('%:t:r')<CR>", { desc = "Yank name" })

-- file picker (Spacemacs: SPC SPC)
map("n", "<leader><space>", LazyVim.pick("files"), { desc = "Find Files (Root Dir)" })

-- git
map("n", "<leader>gb", function()
  require("gitsigns").blame_line({ full = true })
end, { desc = "Git blame (full)" })
map("n", "<leader>gd", function()
  require("gitsigns").diffthis()
end, { desc = "Git diff" })
map("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Neogit" })

-- AI companion (CodeCompanion)
map("n", "<leader>ac", "<cmd>CodeCompanionChat<CR>", { desc = "AI Chat" })
map({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionActions<CR>", { desc = "AI Actions" })

-- Translate selection to English (Spacemacs-ish: SPC a t)
map("v", "<leader>at", ":'<,'>CodeCompanion /translate<CR>", { desc = "AI translate to English" })

-- spell language selector
map("n", "<leader>sl", function()
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
      vim.notify("Spell language set to " .. selected.value)
    elseif selected and not selected.value then
      vim.cmd("set nospell")
      vim.notify("Spell checker turned off")
    end
  end)
end, { desc = "Choose spell lang" })

map("n", "<leader>Se", ":set spelllang=en_us<CR>")
map("n", "<leader>Sp", ":set spelllang=pl<CR>")

-- alt+number window jumping (ignore neo-tree)
local ignore_windows = {
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

for i = 1, 6 do
  map("n", "<m-" .. i .. ">", function()
    change_window(i)
  end, { desc = "Move to window " .. i })
end

-- toggle backups
local backup_state = vim.o.backup
map("n", "<leader>tb", function()
  vim.o.backup = not backup_state
  vim.o.writebackup = not backup_state
  backup_state = vim.o.backup
  vim.notify("Backup " .. (backup_state and "enabled" or "disabled"))
end, { desc = "Toggle backup" })
