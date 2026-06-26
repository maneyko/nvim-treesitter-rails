local M = {}

local defaults = {
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
