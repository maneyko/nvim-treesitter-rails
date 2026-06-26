local M = {}

local defaults = {
  highlights = true,
}

function M.setup(opts)
  opts = vim.tbl_deep_extend("force", defaults, opts or {})

  require("treesitter-rails.predicates").setup()

  if opts.highlights then
    local highlight_opts = type(opts.highlights) == "table" and opts.highlights or {}
    require("treesitter-rails.highlights").setup(highlight_opts)
  end
end

return M
