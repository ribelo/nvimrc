# nvimrc (ribelo)

Editor-first Neovim config.

## Features

- File sidebar: **neo-tree** (`<leader>e`)
- Search: **telescope** (`<leader>ff`, `<leader>fg`)
- Git: **gitsigns** (`<leader>gb`, `<leader>gd`) + **lazygit.nvim** (`<leader>gg`)
- AI companion: **codecompanion.nvim** (`<leader>ac` chat, `<leader>aa` actions)

## AI setup

Uses **OpenRouter** via the OpenAI-compatible API.

- Required env var: `OPENROUTER_API_KEY`
- Default model: `google/gemini-3-flash-preview`

