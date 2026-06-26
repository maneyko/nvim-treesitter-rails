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
  highlights = false,
})
```

## Captures

The plugin defines default highlight links for these captures:

### Vim Ruby syntax captures

- `@vim_ruby.access.ruby`
- `@vim_ruby.attribute.ruby`
- `@vim_ruby.begin_end.ruby`
- `@vim_ruby.boolean.ruby`
- `@vim_ruby.class.ruby`
- `@vim_ruby.class_name.ruby`
- `@vim_ruby.class_variable.ruby`
- `@vim_ruby.comment.documentation.ruby`
- `@vim_ruby.conditional.ruby`
- `@vim_ruby.constant.ruby`
- `@vim_ruby.control.ruby`
- `@vim_ruby.data.ruby`
- `@vim_ruby.define.ruby`
- `@vim_ruby.encoding.ruby`
- `@vim_ruby.eval.ruby`
- `@vim_ruby.exception.ruby`
- `@vim_ruby.exception_handler.ruby`
- `@vim_ruby.float.ruby`
- `@vim_ruby.global_variable.ruby`
- `@vim_ruby.heredoc_delimiter.ruby`
- `@vim_ruby.include.ruby`
- `@vim_ruby.instance_variable.ruby`
- `@vim_ruby.integer.ruby`
- `@vim_ruby.interpolation_delimiter.ruby`
- `@vim_ruby.keyword.ruby`
- `@vim_ruby.macro.ruby`
- `@vim_ruby.magic_comment.ruby`
- `@vim_ruby.method_name.ruby`
- `@vim_ruby.module.ruby`
- `@vim_ruby.module_name.ruby`
- `@vim_ruby.operator.*.ruby`
- `@vim_ruby.predefined_constant.ruby`
- `@vim_ruby.predefined_variable.ruby`
- `@vim_ruby.pseudo_variable.ruby`
- `@vim_ruby.regexp.ruby`
- `@vim_ruby.regexp_delimiter.ruby`
- `@vim_ruby.regexp_special.ruby`
- `@vim_ruby.repeat.ruby`
- `@vim_ruby.sharpbang.ruby`
- `@vim_ruby.string.ruby`
- `@vim_ruby.string_escape.ruby`
- `@vim_ruby.symbol.ruby`
- `@vim_ruby.todo.ruby`

### Rails captures

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
