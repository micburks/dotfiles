return {
  {
    "nvim-mini/mini.pairs",
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { "string" },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    },
    config = function() end,
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
  },
  {
    "phaazon/hop.nvim",
    keys = {
---movement.util - g\            - hop
      { "g<leader>", function() require("hop").hint_words() end, desc = "Hint words", mode = "n" },
      --{noremap=true})
    },
    opts = {},
  },
}
