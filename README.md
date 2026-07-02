# nvim-treesitter-rails

A small Neovim plugin that ports the highlighting portions of Vim's Ruby syntax
file plus the Rails/RSpec/Minitest highlighting portions of
[tpope/vim-rails](https://github.com/tpope/vim-rails) to Treesitter queries.

This plugin does **not** attempt to replace `vim-rails` navigation/commands. It adds
Ruby/Rails-aware Treesitter highlight captures for Ruby files.

## Requirements

- Neovim with Treesitter query support
- A Ruby Treesitter parser installed

## Installation

With Neovim's built-in package manager:

```lua
vim.pack.add({
  "https://github.com/maneyko/nvim-treesitter-rails",
})
```

## Configuration

No configuration is required.

To customize highlights:

```lua
require("treesitter-rails").setup({
  highlights = {
    links = {
      ["@rails.assertion.ruby"]   = "Exception",
      ["@rails.callback.ruby"]    = "Macro",
      ["@rails.helper.ruby"]      = "Function",
      ["@rails.response.ruby"]    = "Keyword",
      ["@rails.test.action.ruby"] = "Keyword",
      ["@rails.test.helper.ruby"] = "Function",
      ["@rails.test.macro.ruby"]  = "Macro",
    },
  },
})
```

Or disable default highlight links entirely:

```lua
require("treesitter-rails").setup({
  highlights = { enabled = false }
})
```

## Captures

For a complete list of captures from the plugin, see: [`queries/ruby/highlights.scm`](https://github.com/maneyko/nvim-treesitter-rails/blob/main/queries/ruby/highlights.scm)
