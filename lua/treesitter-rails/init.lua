local M = {}

local defaults = {
  highlights = {
    enabled = true,
    links = {},
  }
}

function M.setup(opts)
  opts = vim.tbl_deep_extend("force", defaults, opts or {})

  require("treesitter-rails.predicates").setup()

  if opts.highlights.enabled then
    require("treesitter-rails.highlights").setup(opts.highlights)
  end
end

return M
