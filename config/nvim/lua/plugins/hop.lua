-- # hop
---movement.util - g\            - hop
return {
  "phaazon/hop.nvim",
  keys = {
    { "g<leader>", function() require("hop").hint_words() end, desc = "Hint words", mode = "n" },
    --{noremap=true})
  },
  opts = {},
}
