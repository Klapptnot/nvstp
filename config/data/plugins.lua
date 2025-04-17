return {
  -- required dependencies
  --#region
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-telescope/telescope.nvim", tag = "0.1.5" },
  --#endregion

  { "folke/trouble.nvim", event = { "BufReadPre", "BufNewFile" } },
  { "RRethy/vim-illuminate", event = { "BufReadPre", "BufNewFile" } },
  {
    "numToStr/Comment.nvim",
    opts = {},
    event = { "BufReadPre", "BufNewFile" },
  },
  { "stevearc/dressing.nvim" },

  require("config.data.for.wf"),
  require("config.data.for.cmp"),
  require("config.data.for.autopairs"),
  require("config.data.for.tabby"),
  require("config.data.for.treesitter"),
  require("config.data.for.symbols_outline"),
  require("config.data.for.gitsigns"),
  require("config.data.for.mason"),
  require("config.data.for.neo_tree"),
  require("config.data.for.hlchunk"),
  require("config.data.for.null_ls"),
  require("config.data.for.masonlsp"),
  require("config.data.for.lspconfig"),
  -- { "mg979/vim-visual-multi", event = { "UIEnter" } },
  -- { "folke/which-key.nvim", event = "VeryLazy", },

  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
    },
  },
  {
    "LhKipp/nvim-nu",
    ft = "nu",
    init = function()
      require("nu").setup({
        use_lsp_features = true,
        all_cmd_names = [[help commands | get name | str join "\n"]],
      })
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    init = function() require("colorizer").setup({}) end,
  },
  {
    "rcarriga/nvim-notify",
    name = "notify",
    lazy = false,
    init = function()
      if NVSTP.less_complex_things == false then
        -- Just to ignore notification
        require("notify").setup({ background_colour = "#000000" })
        vim.notify = require("notify")
      end
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
      })
    end,
  },
}
