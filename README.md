# nvim-treesitter-rails

A small Neovim plugin that ports the Rails/RSpec/Minitest highlighting portions of
[tpope/vim-rails](https://github.com/tpope/vim-rails) to Treesitter queries.

This plugin does **not** attempt to replace `vim-rails` navigation/commands. It only
adds Rails-aware Treesitter highlight captures for Ruby files.

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
  highlights = false,
})
```

## Captures

The plugin defines default highlight links for these captures:

- `@rails.assertion.ruby`
- `@rails.attribute.ruby`
- `@rails.callback.ruby`
- `@rails.debug.ruby`
- `@rails.entity.ruby`
- `@rails.helper.ruby`
- `@rails.macro.ruby`
- `@rails.pending.ruby`
- `@rails.rake.ruby`
- `@rails.response.ruby`
- `@rails.route.ruby`
- `@rails.schema.ruby`
- `@rails.test.action.ruby`
- `@rails.test.helper.ruby`
- `@rails.test.macro.ruby`
- `@rails.url_helper.ruby`
- `@rails.validation.ruby`
- `@rails.view_helper.ruby`

## Load order

The custom predicates, such as `#is-active-record?`, must be registered before
Ruby Treesitter highlights are parsed. Loading this plugin during startup is the
simplest option.
