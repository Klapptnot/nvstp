local api = require("src.nvstp.api")

local __def_opts_lua__ = { expr = false }
local __def_opts_vim__ = { silent = true }

---@alias NvstpKeyMapp {mapp:string, mode:string[], exec:fun()|string, desc:string?,
---opts:vim.api.keyset.keymap?}

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
    mapp = "W",
    mode = { "n" },
    exec = api.win_jump,
    desc = "Easy jump to another window",
    opts = __def_opts_lua__,
  },

  {
    mapp = "E",
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
    mapp = "<leader>fr",
    mode = { "v", "n" },
    exec = api.find_and_open_refs,
    desc = "Open a path ref from buffer",
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
    mode = { "n", "v", "t" },
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

  {
    mapp = "<Home>",
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

  -- vim expr
  {
    mapp = "<A-m>",
    mode = { "n", "i" },
    exec = "<cmd> Man<CR>",
    desc = "Open man page for symbol under cursor",
    opts = __def_opts_vim__,
  },
  -- do not save replaced selection
  {
    mapp = "p",
    mode = { "x" },
    exec = '"_dp',
    desc = "Paste",
    opts = __def_opts_vim__,
  },
  -- Use gj|jk if no v:count
  -- https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk
  {
    mapp = "k",
    mode = { "v", "n" },
    exec = "(v:count == 0 ? 'gk' : 'k')",
    desc = "Move cursor up",
    opts = { silent = true, expr = true },
  },
  {
    mapp = "j",
    mode = { "v", "n" },
    exec = "(v:count == 0 ? 'gj' : 'j')",
    desc = "Move cursor down",
    opts = { silent = true, expr = true },
  },
  {
    mapp = "<Up>",
    mode = { "v", "n" },
    exec = "(v:count == 0 ? 'gk' : 'k')",
    desc = "Move cursor up",
    opts = { silent = true, expr = true },
  },
  {
    mapp = "<Down>",
    mode = { "v", "n" },
    exec = "(v:count == 0 ? 'gj' : 'j')",
    desc = "Move cursor down",
    opts = { silent = true, expr = true },
  },
}
