return {
  {
    "nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local compare = require('cmp.config.compare')
      opts.sorting.comparators = {
        compare.locality,
        compare.recently_used,
        compare.scopes,
        compare.score,
        compare.offset,
        compare.order,
      }
    end,
  },
}
