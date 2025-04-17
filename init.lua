do -- bootstrap
  local nvcfg = vim.fn.stdpath("config")
  ---@cast nvcfg string
  local p = {
    s = package.config:sub(1, 1), -- Path separator
    d = package.config:sub(3, 3), -- package.path separator
    p = package.config:sub(5, 5), -- name placeholder
  }
  -- stylua: ignore
  package.path = package.path
      -- ";{}/?/init.lua"
      .. p.d .. nvcfg .. p.s .. p.p .. p.s .. "init.lua"
      -- ";{}/?.lua"
      .. p.d .. nvcfg .. p.s .. p.p .. ".lua"

  local lazypath = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "lazy.nvim")
  ---@diagnostic disable-next-line: undefined-field
  if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end

  vim.opt.rtp:prepend(lazypath)
  vim.cmd("silent! helptags " .. vim.fn.stdpath("config") .. "/doc")
end

NVSTP = {
  less_complex_things = true,
  tweaks = {
    detect_indent = true,
    reset_cursor = true,
    lua_functions = true,
  },
  cache_path = vim.fs.joinpath(vim.fn.stdpath("cache"), "nvstp"),
}

if not vim.uv.fs_stat(NVSTP.cache_path) then vim.fn.mkdir(NVSTP.cache_path, "p") end

-- Space is <leader> key
vim.g.mapleader = " "

---@type NvstpConfig
local config = require("config")

config.plugins:apply()
config.globals:apply()
config.options:apply()
config
    .mapping
    :add({ mapp = "<khome>", exec = "<Home>", mode = { "n", "v", "i" } })
    :add({ mapp = "<kend>", exec = "<End>", mode = { "n", "v", "i" } })
    :no_op_key({ "<C-z>" }) -- disable backgrounding when <C-z> is pressed
    :apply()

vim.cmd.colorscheme("catppuccin")

require("src.nvstp.tweaks").apply()
require("src.nvstp.term").setup()
require("src.nvstp.statusline").set({
  ignore = "neo-tree,Outline,toggleterm",
  bar = {
    "mode",
    "file",
    "git_branch",
    "truncate",
    "lsp_name",
    "lsp_diag",
    "shift_to_end",
    "git_stat",
    "cursor_pos",
    "cwd",
    "file_eol",
    "file_encoding",
    "file_type",
  },
  colors = {                                        -- Catppuccin with diversified colors
    mode = {
      normal = { bg = "#a6e3a1", fg = "#11111b" },  -- Green
      insert = { bg = "#f5c2e7", fg = "#11111b" },  -- Pink
      visual = { bg = "#89dceb", fg = "#11111b" },  -- Teal
      prompt = { bg = "#eba0ac", fg = "#11111b" },  -- Maroon
      replace = { bg = "#f38ba8", fg = "#11111b" }, -- Red
      other = { bg = "#f9e2af", fg = "#11111b" },   -- Yellow
    },
    cwd = { bg = "#b4befe", fg = "#11111b" },       -- Lavender
    file = {
      name = { bg = "#cba6f7", fg = "#11111b" },    -- Mauve
      type = { bg = "#f9e2af", fg = "#11111b" },    -- Yellow
      eol = { bg = "#bac2de", fg = "#11111b" },     -- Subtext0
      enc = { bg = "#fab387", fg = "#11111b" },     -- Peach
    },
    lsp = {
      name = { bg = "#94e2d5", fg = "#11111b" },  -- Sky
      error = { bg = "#f38ba8", fg = "#11111b" }, -- Red
      hint = { bg = "#89b4fa", fg = "#11111b" },  -- Blue
      warn = { bg = "#fab387", fg = "#11111b" },  -- Peach
      info = { bg = "#74c7ec", fg = "#11111b" },  -- Sapphire
    },
    git = {
      branch = { bg = "#b4befe", fg = "#11111b" },   -- Lavender
      changed = { bg = "#f2cdcd", fg = "#11111b" },  -- Flamingo
      added = { bg = "#a6e3a1", fg = "#11111b" },    -- Green
      removed = { bg = "#f38ba8", fg = "#11111b" },  -- Red
    },
    cursor_pos = { bg = "#cdd6f4", fg = "#11111b" }, -- Text
  },
  separators = {
    l = "",
    r = "",
  },
  swap = true,
}, true)

local toggles = require("src.nvstp.toggle")

toggles.add(
  "diagnostic-lines",
  function(s) vim.diagnostic.config({ virtual_lines = s }) end,
  true
)
toggles.add("inlay-hints", function(s) vim.lsp.inlay_hint.enable(s) end, true)
toggles.add("spell-check", function(s) vim.opt.spell = s end, false)
toggles.add("mouse-support", function(s) vim.opt.mouse = s and "a" or "" end, true)
