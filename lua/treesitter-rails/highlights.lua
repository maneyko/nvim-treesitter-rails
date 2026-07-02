local M = {}

local defaults = {
  links = {
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
    ["@vim_ruby.encoding.ruby"]                 = "Constant",
    ["@vim_ruby.eval.ruby"]                     = "Statement",
    ["@vim_ruby.exception.ruby"]                = "Exception",
    ["@vim_ruby.exception_handler.ruby"]        = "Conditional",
    ["@vim_ruby.float.ruby"]                    = "Float",
    ["@vim_ruby.global_variable.ruby"]          = "Identifier",
    ["@vim_ruby.heredoc_delimiter.ruby"]        = "String",
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
    ["@vim_ruby.operator.pseudo.ruby"]          = "Normal",
    ["@vim_ruby.operator.range.ruby"]           = "Operator",
    ["@vim_ruby.operator.ternary.ruby"]         = "Operator",
    ["@vim_ruby.predefined_constant.ruby"]      = "Identifier",
    ["@vim_ruby.parameter.block.implicit"]      = "Identifier",
    ["@vim_ruby.parameter.block.numbered"]      = "Identifier",
    ["@vim_ruby.predefined_variable.ruby"]      = "Identifier",
    ["@vim_ruby.pseudo_variable.ruby"]          = "Constant",
    ["@vim_ruby.regexp.ruby"]                   = "String",
    ["@vim_ruby.regexp_content.ruby"]           = "String",
    ["@vim_ruby.regexp_delimiter.ruby"]         = "String",
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
}

function M.setup(opts)
  opts = vim.tbl_deep_extend("force", defaults, opts or {})

  for group, link in pairs(opts.links) do
    vim.api.nvim_set_hl(0, group, {
      default = true,  -- Do not override existing highlight definition
      link    = link,
    })
  end
end

return M

-- local mapping = {
--   {
--     selector = "@rails.test.helper",
--     predicate = "#is-rails-system-test-or-feature-spec?",
--     identifiers = {
--       "body", "current_host", "current_path", "current_scope", "current_url", "current_window", "html", "response_headers",
--       "source", "status_code", "title", "windows", "page", "text", "all", "field_labeled", "find", "find_all", "find_button",
--       "find_by_id", "find_field", "find_link", "first",
--     },
--   },
--   {
--     selector = "@rails.test.action",
--     predicate = "#is-rails-system-test-or-feature-spec?",
--     identifiers = {
--       "evaluate_script", "execute_script", "go_back", "go_forward", "open_new_window", "save_and_open_page", "save_and_open_screenshot",
--       "save_page", "save_screenshot", "switch_to_frame", "switch_to_window", "visit", "window_opened_by", "within",
--       "within_element", "within_fieldset", "within_frame", "within_table", "within_window", "reset_session!",
--       "attach_file", "check", "choose", "click_button", "click_link", "click_link_or_button", "click_on", "fill_in",
--       "select", "uncheck", "unselect",
--     },
--   }
-- }
--
-- local function concat(t, str)
--   if type(str) == "table" then
--     for _, v in ipairs(str) do
--       concat(t, v)
--     end
--   else
--     t[#t+1] = str
--   end
--   return t
-- end
--
-- local highlight_extension = {";; extends\n"}
--
-- for _, config in ipairs(mapping) do
--   local s = table.concat(config.identifiers, '" "')
--   -- Target a chained call: page.visit("foo")
--   concat(highlight_extension, {[[
-- (call
--   .
--   receiver: (identifier) ]], config.selector, [[
--
--   (#any-of? ]], config.selector, [[
--
--     "]], s, [["
--   )
--   (]], config.predicate, [[))
-- ]]})
--
--   -- Target as a regular method call: page().text
--   concat(highlight_extension, {[[
-- (call
--   .
--   method: (identifier) ]], config.selector, [[
--
--   (#any-of? ]], config.selector, [[
--
--     "]], s, [["
--   )
--   (]], config.predicate, [[))
-- ]]})
--
--   -- Target as an ordinary identifier: expect(page).to have_text("foo")
--   concat(highlight_extension, {[[
-- ((identifier) ]], config.selector, [[
--
--   (#any-of? ]], config.selector, [[
--
--     "]], s, [["
--   )
--   (#set! priority 110)
--   (#not-has-parent? ]], config.selector, [[ call)
--   (]], config.predicate, [[))
-- ]]})
--
-- end
--
-- local query = table.concat(highlight_extension)
--
-- vim.treesitter.query.set("ruby", "highlights", query)
--
-- return M
