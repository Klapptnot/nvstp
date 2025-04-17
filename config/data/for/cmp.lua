-- stylua: ignore
local kind_icons = {
  Text          = "",
  Method        = "󰆧",
  Function      = "󰊕",
  Constructor   = "",
  Field         = "󰇽",
  Variable      = "󰂡",
  Class         = "󰠱",
  Interface     = "",
  Module        = "",
  Property      = "󰜢",
  Unit          = "",
  Value         = "󰎠",
  Enum          = "",
  Keyword       = "󰌋",
  Snippet       = "",
  Color         = "󰏘",
  File          = "󰈙",
  Reference     = "",
  Folder        = "󰉋",
  EnumMember    = "",
  Constant      = "󰏿",
  Struct        = "",
  Event         = "",
  Operator      = "󰆕",
  TypeParameter = "󰅲",
}

local borders = {
  { "╭", "CMPBorder" },
  { "─", "CMPBorder" },
  { "╮", "CMPBorder" },
  { "│", "CMPBorder" },
  { "╯", "CMPBorder" },
  { "─", "CMPBorder" },
  { "╰", "CMPBorder" },
  { "│", "CMPBorder" },
}

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      dependencies = "rafamadriz/friendly-snippets",
      opts = { history = true, updateevents = "TextChanged,TextChangedI" },
      config = function(opts)
        require("luasnip").config.set_config(opts)
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load({
          paths = vim.g.vscode_snippets_path or "",
        })
        require("luasnip.loaders.from_snipmate").load()
        require("luasnip.loaders.from_snipmate").lazy_load({
          paths = vim.g.snipmate_snippets_path or "",
        })
        require("luasnip.loaders.from_lua").load()
        require("luasnip.loaders.from_lua").lazy_load({ paths = vim.g.lua_snippets_path or "" })
        vim.api.nvim_create_autocmd("InsertLeave", {
          callback = function()
            if
              require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
              and not require("luasnip").session.jump_active
            then
              require("luasnip").unlink_current()
            end
          end,
        })
      end,
    },
    {
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-calc",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    cmp.setup({
      window = {
        completion = {
          side_padding = 0, -- flat_dark
          border = borders,
          -- winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        },
        documentation = {
          border = borders,
          -- winhighlight = "Normal:CMPBorder",
        },
      },
      snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
      },
      experimental = {
        native_menu = false,
        ghost_text = true,
      },
      formatting = {
        format = function(entry, vim_item)
          -- load lspkind icons
          vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)

          --       |
          -- stylua: ignore
          vim_item.menu = ({
            nvim_lsp = " 󰒌 ",
            nvim_lua = "  ",
            luasnip  = "  ",
            buffer   = "  ",
            path     = "  ",
            calc     = " 󰃬 ",
            cmdline  = "  "
          })[entry.source.name] or "  "

          return vim_item
        end,
      },
      mapping = {
        ["<C-Up>"] = cmp.mapping.scroll_docs(-8),
        ["<C-Down>"] = cmp.mapping.scroll_docs(8),
        ["<C-o>"] = cmp.mapping.open_docs(),
        ["<Tab>"] = cmp.mapping.confirm({ select = false }),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Esc>"] = cmp.mapping.close(),
        ["<Up>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
        ["<Down>"] = cmp.mapping.select_next_item({ behavior = "select" }),
      },
      sources = {
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "treesitter" },
        { name = "luasnip" },
        { name = "emoji" },
        { name = "path" },
        { name = "calc" },
        {
          name = "buffer",
          keyword_length = 5,
          option = {
            get_bufnr = function() return vim.api.nvim_list_bufs() end,
          },
        },
        { name = "crates" }, -- crates does check if file is a `Cargo.toml` file
      },
    })
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
        {
          name = "cmdline",
          option = {},
        },
      }),
    })
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })
  end,
}
