local M = {}

local defaults = {
  ["@vim_ruby.access.ruby"]                   = "Macro",
  ["@vim_ruby.attribute.ruby"]                = "Macro",
  ["@vim_ruby.begin_end.ruby"]                = "Statement",
  ["@vim_ruby.boolean.ruby"]                  = "Boolean",
  ["@vim_ruby.class.ruby"]                    = "Define",
  ["@vim_ruby.class_name.ruby"]               = "Type",
  ["@vim_ruby.class_variable.ruby"]           = "Identifier",
  ["@vim_ruby.comment.documentation.ruby"]    = "Comment",
  ["@vim_ruby.conditional.ruby"]              = "Conditional",
  ["@vim_ruby.constant.ruby"]                 = "Type",
  ["@vim_ruby.control.ruby"]                  = "Statement",
  ["@vim_ruby.data.ruby"]                     = "Comment",
  ["@vim_ruby.define.ruby"]                   = "Define",
  ["@vim_ruby.eval.ruby"]                     = "Statement",
  ["@vim_ruby.exception.ruby"]                = "Exception",
  ["@vim_ruby.exception_handler.ruby"]        = "Conditional",
  ["@vim_ruby.float.ruby"]                    = "Float",
  ["@vim_ruby.global_variable.ruby"]          = "Identifier",
  ["@vim_ruby.heredoc_delimiter.ruby"]        = "Delimiter",
  ["@vim_ruby.include.ruby"]                  = "Include",
  ["@vim_ruby.instance_variable.ruby"]        = "Identifier",
  ["@vim_ruby.integer.ruby"]                  = "Number",
  ["@vim_ruby.interpolation_delimiter.ruby"]  = "Delimiter",
  ["@vim_ruby.keyword.ruby"]                  = "Keyword",
  ["@vim_ruby.macro.ruby"]                    = "Macro",
  ["@vim_ruby.magic_comment.ruby"]            = "SpecialComment",
  ["@vim_ruby.method_name.ruby"]              = "Function",
  ["@vim_ruby.module.ruby"]                   = "Define",
  ["@vim_ruby.module_name.ruby"]              = "Type",
  ["@vim_ruby.operator.arithmetic.ruby"]      = "Operator",
  ["@vim_ruby.operator.assignment.ruby"]      = "Operator",
  ["@vim_ruby.operator.bitwise.ruby"]         = "Operator",
  ["@vim_ruby.operator.boolean.ruby"]         = "Operator",
  ["@vim_ruby.operator.comparison.ruby"]      = "Operator",
  ["@vim_ruby.operator.english_boolean.ruby"] = "Operator",
  ["@vim_ruby.operator.equality.ruby"]        = "Operator",
  ["@vim_ruby.operator.pseudo.ruby"]          = "Special",
  ["@vim_ruby.operator.range.ruby"]           = "Operator",
  ["@vim_ruby.operator.ternary.ruby"]         = "Operator",
  ["@vim_ruby.predefined_constant.ruby"]      = "Identifier",
  ["@vim_ruby.predefined_variable.ruby"]      = "Identifier",
  ["@vim_ruby.pseudo_variable.ruby"]          = "Constant",
  ["@vim_ruby.regexp.ruby"]                   = "String",
  ["@vim_ruby.regexp_delimiter.ruby"]         = "Delimiter",
  ["@vim_ruby.regexp_special.ruby"]           = "Special",
  ["@vim_ruby.repeat.ruby"]                   = "Repeat",
  ["@vim_ruby.sharpbang.ruby"]                = "PreProc",
  ["@vim_ruby.string.ruby"]                   = "String",
  ["@vim_ruby.string_escape.ruby"]            = "Special",
  ["@vim_ruby.symbol.ruby"]                   = "Constant",
  ["@vim_ruby.todo.ruby"]                     = "Todo",

  ["@rails.assertion.ruby"]   = "Exception",
  ["@rails.attribute.ruby"]   = "Macro",
  ["@rails.callback.ruby"]    = "Macro",
  ["@rails.debug.ruby"]       = "Debug",
  ["@rails.entity.ruby"]      = "Macro",
  ["@rails.helper.ruby"]      = "Function",
  ["@rails.macro.ruby"]       = "Macro",
  ["@rails.pending.ruby"]     = "Comment",
  ["@rails.rake.ruby"]        = "Macro",
  ["@rails.response.ruby"]    = "Keyword",
  ["@rails.route.ruby"]       = "Keyword",
  ["@rails.schema.ruby"]      = "Keyword",
  ["@rails.test.action.ruby"] = "Keyword",
  ["@rails.test.helper.ruby"] = "Function",
  ["@rails.test.macro.ruby"]  = "Macro",
  ["@rails.url_helper.ruby"]  = "Function",
  ["@rails.validation.ruby"]  = "Macro",
  ["@rails.view_helper.ruby"] = "Function",
}

function M.setup(opts)
  opts = opts or {}
  local links = vim.tbl_extend("force", defaults, opts.links or {})
  local default = opts.default

  -- Initial automatic setup should not override colorschemes/user config, but an
  -- explicit `setup({ highlights = { links = ... } })` call should be able to
  -- replace the default links installed by the plugin entrypoint.
  if default == nil then
    default = opts.links == nil
  end

  for group, link in pairs(links) do
    vim.api.nvim_set_hl(0, group, {
      default = default,
      link = link,
    })
  end
end

return M
