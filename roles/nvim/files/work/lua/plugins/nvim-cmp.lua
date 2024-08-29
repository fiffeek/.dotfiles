return {
  {
    "nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local compare = require("cmp.config.compare")
      opts.sorting.comparators = {
        compare.offset,
        compare.exact,
        compare.score,
        compare.recently_used,
      }
    end,
  },
}
