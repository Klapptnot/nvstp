local api = require("src.nvstp.api")

local __def_opts_lua__ = { expr = false }
local __def_opts_vim__ = { silent = true }

---@alias NvstpKeyMapp {mapp:string, mode:string[], exec:fun()|string, desc:string?, opts:table<string, any>?}

---@type NvstpKeyMapp[]
return {
  -- ^ Lua functions
  {
    mapp = "<C-s>",
    mode = { "n", "v", "i" },
    exec = api.save,
    desc = "Save current file",
    opts = __def_opts_lua__,
  },

  {
    mapp = "<C-q>",
    mode = { "n", "v", "i" },
    exec = api.quit,
    desc = "Quit nvim safely",
    opts = __def_opts_lua__,
  },

  {
    mapp = "th",
    mode = { "n", "v" },
    exec = api.tab_prev,
    desc = "Go to prev tab/buffer",
    opts = __def_opts_lua__,
  },

  {
    mapp = "tl",
    mode = { "n", "v" },
    exec = api.tab_next,
    desc = "Go to next tab/buffer",
    opts = __def_opts_lua__,
  },

  {
    mapp = "tk",
    mode = { "n", "v" },
    exec = api.tab_new,
    desc = "Add a new tab/buffer",
    opts = __def_opts_lua__,
  },

  {
    mapp = "tj",
    mode = { "n", "v" },
    exec = api.tab_close,
    desc = "Close tab/buffer",
    opts = __def_opts_lua__,
  },

  {
    mapp = "tr",
    mode = { "n", "v" },
    exec = api.tab_rename,
    desc = "Rename current tab/buffer",
    opts = __def_opts_lua__,
  },

  {
    mapp = "<C-b>",
    mode = { "n", "v" },
    exec = api.toggle_file_tree,
    desc = "Toggle/focus files tree",
    opts = __def_opts_lua__,
  },

  {
    mapp = "<leader>ih",
    mode = { "n", "v" },
    exec = api.toggle_inlayhints,
    desc = "Toggle LSP inlay hints",
    opts = __def_opts_lua__,
  },

  {
    mapp = "w",
    mode = { "n" },
    exec = api.win_jump,
    desc = "Easy jump to another window",
    opts = __def_opts_lua__,
  },

  {
    mapp = "W",
    mode = { "n" },
    exec = api.win_close,
    desc = "Easy close picked window",
    opts = __def_opts_lua__,
  },

  {
    mapp = "<C-t>",
    mode = { "n" },
    exec = api.resize_win_interact,
    desc = "Interactively resize current window",
    opts = __def_opts_lua__,
  },

  {
    mapp = "<leader>sv",
    mode = { "n" },
    exec = function() vim.cmd("vsplit") end,
    desc = "Split current window vertically",
    opts = __def_opts_lua__,
  },

  {
    mapp = "<leader>sh",
    mode = { "n" },
    exec = function() vim.cmd("split") end,
    desc = "Split current window horizontally",
    opts = __def_opts_lua__,
  },

  {
    mapp = "<leader>g",
    mode = { "n" },
    exec = api.find,
    desc = "Open search",
    opts = __def_opts_lua__,
  },

  {
    mapp = "<leader>r",
    mode = { "n" },
    exec = api.find_replace,
    desc = "Open find and replace",
    opts = __def_opts_lua__,
  },

  {
    mapp = "<A-Up>",
    mode = { "n", "i" },
    exec = api.move_line_up,
    desc = "Move line up",
    opts = __def_opts_lua__,
  },

  {
    mapp = "<A-Down>",
    mode = { "n", "i" },
    exec = api.move_line_down,
    desc = "Move line down",
    opts = __def_opts_lua__,
  },

  {
    mapp = "<C-d>",
    mode = { "n", "i" },
    exec = api.duplicate_line,
    desc = "Duplicate line",
    opts = __def_opts_lua__,
  },

  {
    mapp = "<C-d>",
    mode = { "v" },
    exec = api.duplicate_selection,
    desc = "Duplicate selection",
    opts = __def_opts_lua__,
  },

  {
    mapp = "<C-v>",
    mode = { "n", "v", "i" },
    exec = api.paste,
    desc = "Paste yanked (copied) text",
    opts = __def_opts_lua__,
  },

  {
    mapp = "<C-c>",
    mode = { "n", "v", "i" },
    exec = api.copy,
    desc = "Copy selected text/line",
    opts = __def_opts_lua__,
  },

  {
    mapp = "<C-z>",
    mode = { "n", "v", "i" },
    exec = api.undo,
    desc = "Undo",
    opts = __def_opts_lua__,
  },

  {
    mapp = "<C-y>",
    mode = { "n", "v", "i" },
    exec = api.redo,
    desc = "Redo",
    opts = __def_opts_lua__,
  },

  {
    mapp = "<C-`>",
    mode = { "n", "v", "t" },
    exec = api.toggle_fterm,
    desc = "Toggle floating terminal",
    opts = __def_opts_lua__,
  },

  {
    mapp = "<M-1>",
    mode = { "n", "v", "t" }, -- Allow hiding term when in terminal mode
    exec = api.toggle_hterm,
    desc = "Toggle horizontal terminal",
    opts = __def_opts_lua__,
  },

  {
    mapp = "<M-2>",
    mode = { "n", "v", "t" },
    exec = api.toggle_vterm,
    desc = "Toggle vertical terminal",
    opts = __def_opts_lua__,
  },


  {
    mapp = "<",
    mode = { "n", "v" },
    exec = api.remove_indent,
    desc = "Unindent",
    opts = __def_opts_lua__,
  },

  {
    mapp = ">",
    mode = { "n", "v" },
    exec = api.add_indent,
    desc = "Indent",
    opts = __def_opts_lua__,
  },

  -- {
  --   mapp = "<ScrollWheelUp>",
  --   mode = { "n", "v", "t" },
  --   exec = "<PageUp>",
  --   desc = "Scroll up",
  --   opts = __def_opts_vim__,
  -- },
  --
  -- {
  --   mapp = "<ScrollWheelDown>",
  --   mode = { "n", "v", "t" },
  --   exec = "<PageDown>",
  --   desc = "Scroll down",
  --   opts = __def_opts_vim__,
  -- },

  {
    mapp = "<khome>",
    mode = { "n", "v", "i" },
    exec = api.home_key,
    desc = "Go to line home or line start",
    opts = __def_opts_lua__,
  },

  {
    mapp = "W",
    mode = { "v" },
    exec = api.wrap_selection,
    desc = "Wrap the visual selection",
    opts = __def_opts_lua__,
  },

  -- ^ Vim expressions
  {
    mapp = "<C-BS>",
    mode = { "i" },
    exec = "<C-w>",
    desc = "Delete word backwards",
    opts = __def_opts_vim__,
  },

  {
    mapp = "<leader>so",
    mode = { "n" },
    exec = "<cmd> SymbolsOutline <CR>",
    desc = "Toggle Symbols Outline window",
    opts = __def_opts_vim__,
  },

  {
    mapp = "<C-/>",
    mode = { "n", "i" },
    exec = '<cmd> lua require("Comment.api").toggle.linewise.current() <CR>',
    desc = "Toggle comment",
    opts = __def_opts_vim__,
  },

  {
    mapp = "<C-/>",
    mode = { "v" },
    exec = '<ESC><cmd> lua require("Comment.api").toggle.linewise(vim.fn.visualmode()) <CR>',
    desc = "Toggle comments in visual mode",
    opts = __def_opts_vim__,
  },

  {
    mapp = "<leader>ff",
    mode = { "n" },
    exec = "<cmd> Telescope find_files <CR>",
    desc = "Telescope: Find files",
    opts = __def_opts_vim__,
  },

  {
    mapp = "<leader>fa",
    mode = { "n" },
    exec = "<cmd> Telescope find_files follow=true hidden=true <CR>",
    desc = "Telescope: Find all",
    opts = __def_opts_vim__,
  },

  {
    mapp = "<leader>fw",
    mode = { "n" },
    exec = "<cmd> Telescope live_grep <CR>",
    desc = "Telescope: Live grep",
    opts = __def_opts_vim__,
  },

  {
    mapp = "<leader>fb",
    mode = { "n" },
    exec = "<cmd> Telescope buffers <CR>",
    desc = "Telescope: Find buffers",
    opts = __def_opts_vim__,
  },

  {
    mapp = "<leader><leader>",
    mode = { "n" },
    exec = "<cmd> Telescope buffers <CR>",
    desc = "Telescope: Find buffers",
    opts = __def_opts_vim__,
  },

  {
    mapp = "<leader>fh",
    mode = { "n" },
    exec = "<cmd> Telescope help_tags <CR>",
    desc = "Telescope: Help pages",
    opts = __def_opts_vim__,
  },

  {
    mapp = "<leader>fo",
    mode = { "n" },
    exec = "<cmd> Telescope oldfiles <CR>",
    desc = "Telescope: Find oldfiles",
    opts = __def_opts_vim__,
  },

  {
    mapp = "<leader>fz",
    mode = { "n" },
    exec = "<cmd> Telescope current_buffer_fuzzy_find <CR>",
    desc = "Telescope: Find in current buffer",
    opts = __def_opts_vim__,
  },

  {
    mapp = "<leader>gc",
    mode = { "n" },
    exec = "<cmd> Telescope git_commits <CR>",
    desc = "Telescope: Git commits",
    opts = __def_opts_vim__,
  },

  {
    mapp = "<leader>gt",
    mode = { "n" },
    exec = "<cmd> Telescope git_status <CR>",
    desc = "Telescope: Git status",
    opts = __def_opts_vim__,
  },

  {
    mapp = "<leader>th",
    mode = { "n" },
    exec = "<cmd> Telescope themes <CR>",
    desc = "Telescope: Switch themes",
    opts = __def_opts_vim__,
  },

  -- ^ Small hacks (vim expr)
  -- Dont copy text replaced with p
  {
    mapp = "p",
    mode = { "v", "n" },
    exec = 'p:let @+=@0<CR>:let @"=@0<CR>',
    desc = "Paste",
    opts = __def_opts_vim__,
  },
}
