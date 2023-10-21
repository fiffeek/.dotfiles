return {
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>und",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Delete all Notifications",
      },
    },
    opts = {
      level = 4,
      render = "minimal",
      stages = "static",
    },
  }
}
