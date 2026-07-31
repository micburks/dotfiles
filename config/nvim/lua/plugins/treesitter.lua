return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- <--- Ensure this line is present
    after = { "nvim-treesitter" }, -- Optionally, can also use 'after'
    config = function()
      -- Optional: Custom configuration for nvim-treesitter-textobjects
      -- require('nvim-treesitter.configs').setup { ... } should NOT be here
      -- it belongs in the main nvim-treesitter configuration.
    end
  },
}
