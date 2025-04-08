---@diagnostic disable: deprecated

NVSTP_TWEAKS = {
  detect_indent = false,
  reset_cursor = false,
  lua_functions = false,
}

local tweaks_fns = {
  detect_indent = function()
    local function guess_set_indent()
      local a, b, c = vim.bo.shiftwidth, vim.bo.tabstop, vim.bo.softtabstop
      local width = require("src.warm.indent").guess()
      if width == nil then return end
      vim.bo.shiftwidth = width
      vim.bo.tabstop = width
      vim.bo.softtabstop = width

      if a == width then return end
      vim.notify(
        string.format(
          "Indentation size changed\n{\n  before = { shiftwidth = %d, tabstop = %d, softtabstop = %d },\n  after = %d\n}",
          a,
          b,
          c,
          width
        ),
        vim.log.levels.INFO,
        { title = "Tweaks" }
      )
    end

    -- Set indentation based on guesses, works better btw
    vim.api.nvim_create_user_command("NvstpIndentSet", function(opts)
      local width = tonumber(opts.fargs[1])
      assert(width ~= nil, "number is nil")
      assert(width % 2 == 0, "number is not a even number")
      if vim.bo.shiftwidth == width then return end

      print(
        string.format(
          "Change from %d:%d:%d to %d",
          vim.bo.shiftwidth,
          vim.bo.tabstop,
          vim.bo.softtabstop,
          width
        )
      )

      vim.bo.shiftwidth = width
      vim.bo.tabstop = width
      vim.bo.softtabstop = width
    end, { desc = "Guess and set indent level [def: 2]", nargs = "+" })
    vim.api.nvim_create_autocmd({ "BufReadPost" }, {
      pattern = "*",
      callback = guess_set_indent,
    })
    NVSTP_TWEAKS.detect_indent = true
  end,
  reset_cursor = function()
    -- Reset cursor style on exit
    vim.api.nvim_create_autocmd({ "VimLeave" }, {
      pattern = { "*" },
      command = 'set guicursor= | call chansend(v:stderr, "\\x1b[ q")',
    })

    NVSTP_TWEAKS.reset_cursor = true
  end,

  lua_functions = function()
    -- !! Neovim has Lua 5.1, so make it appear Lua 5.4
    -- !! moving unpack to table.unpack
    -- !! making forward compatibility easy (When available, remove this)
    table.unpack = unpack

    ---Simple check if string contains other string inside
    --
    ---Patterns are escaped and matched as single string
    -- ```lua
    -- local valid_types = "string,number"
    -- assert(valid_types:has(type(v)), 'argument #1 must be either string or number')
    -- ```
    ---@param s string|number
    ---@param str string|number
    ---@param init? integer
    ---@return boolean
    string.has = function(s, str, init)
      if init == nil then init = 1 end
      assert(type(init) == "number", "argument #1 must be a number")
      return string.find(s, str, 1, true) ~= nil
    end

    ---Print string to `stdout`.
    ---Same as print(string), but avoiding weird editing
    -- ```lua
    -- local fmt = '%d.%d.%d'
    -- fmt:format(major, minor, patch):print()
    -- ```
    ---@param s string
    string.print = function(s) print(s) end

    ---Write string to default output file (mainly `stdout`).
    ---Used to `print()` without trailing `\n`
    -- ```lua
    -- local fmt = '%d.%d.%d'
    -- fmt:format(major, minor, patch):put()
    -- ```
    ---@param s string
    string.put = function(s) io.write(s) end
    NVSTP_TWEAKS.lua_functions = true
  end,
}

local main = {}

---Apply tweaks to the runtime environment and functionality

function main.apply(tweaks)
  local failed = {}
  for i, v in ipairs(tweaks) do
    if tweaks_fns[v] ~= nil then
      tweaks_fns[v]()
    else
      failed[#failed + 1] = i
    end
  end
  return failed
end

return main
