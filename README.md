# funline-base.nvim

This is a personal project based on [funline.nvim](https://github.com/kaze-k/funline.nvim)

## Requirements

- Neovim >= 0.10.0
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [possession](https://github.com/jedrzejboczar/possession.nvim)
- [nvim-lightbulb](https://github.com/kosayoda/nvim-lightbulb)
- [auto-save.nvim](https://github.com/okuuva/auto-save.nvim)
- [codeium.vim](https://github.com/Exafunction/codeium.vim)

## Installation

```lua
{
  "kaze-k/funline-base.nvim",
  dependencies = {
    "kaze-k/funline.nvim",
    "jedrzejboczar/possession.nvim",
    "nvim-lightbulb",
    "auto-save.nvim",
    "codeium.vim",
  },
  config = function()
    require("funline-base").setup()
  end
}
```

## Themes

- vanilla

## Configuration

```lua
require("funline-base").setup({
  theme = "vanilla",
})
```
