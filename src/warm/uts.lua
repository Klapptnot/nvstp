-- Not used more than a couple of times power functions

local str = require("src.warm.str")
local main = {}

---Sleep simple, allowing to sleep n seconds
--
---To sleep n milliseconds, use fractions of seconds (0.5, 0.225)
---@param n number
function main.sleep(n)
  local t0 = os.clock()
  while os.clock() - t0 <= n do
  end
end

---Get the bit lenght of a integer (Bits needed to store it)
---@param i integer
---@return integer
function main.bit_length(i)
  local len = 0
  if i > 255 then
    len = 8
    i = math.floor(i / 255)
  end
  while i > 0 do
    i = math.floor(i / 2)
    len = len + 1
  end
  return len
end

-- Number to hex notation
---@param i integer
---@return string
function main.hex(i) return string.format("0x%x", tostring(i)) end

-- Execute a command using io.popen
---@param prog string
---@param strip boolean?
---@return string
function main.execute(prog, strip)
  local exeo = io.popen(prog, "r")
  if exeo == nil then return "" end
  local out = exeo:read("a")
  exeo:close()
  if strip then out = out:gsub("^[\n|%s]*(.-)[\n|%s]*$", "%1") end
  return out
end

---Run a single command and get stdout, stderr and exit code
---@param cmd string[]
---@param env string[]
---@return string?
---@return {out:string, err:string, exi:integer?}?
function main.nrun(cmd, env)
  local stderr = vim.uv.new_pipe(false)
  local stdout = vim.uv.new_pipe(false)

  local handle, exit_code
  local outD, errD = {}, {}

  -- man.lua@neovim
  local command = cmd
  if type(env) == "table" then
    command = { "env" }
    vim.list_extend(command, env)
    vim.list_extend(command, cmd)
  end

  local wait_for_proc = true
  local wait_time = 0

  handle = vim.uv.spawn(command[1], {
    args = vim.list_slice(command, 2),
    stdio = { nil, stdout, stderr },
    ---@diagnostic disable-next-line: unused-local -- signal:unused
  }, function(code, signal)
    wait_for_proc = false
    exit_code = code
    stdout:close()
    stderr:close()
    ---@diagnostic disable-next-line: need-check-nil
    handle:close()
  end)

  if handle == nil then
    stdout:close()
    stderr:close()
    return "command not started", nil
  end

  stdout:read_start(function(_, data)
    if data ~= nil then outD[#outD + 1] = data end
  end)
  stderr:read_start(function(_, data)
    if data ~= nil then errD[#errD + 1] = data end
  end)

  while wait_for_proc do
    main.sleep(0.2)
    wait_time = wait_time + 1
    if wait_time >= 128 then
      if handle ~= nil then
        handle:close()
        stdout:close()
        stderr:close()
      end
      return "command timed out", nil
    end
  end

  return nil, {
    out = outD or "",
    err = errD or "",
    exi = exit_code,
  }
end

---Get the path to caller function's file parent folder or path to file
---@param full? boolean
---@param lvl? integer
---@return string
function main.fwd(full, lvl)
  if full == nil then full = false end
  assert(type(full) == "boolean", "argument #1 to 'fwd' must be a boolean")
  if lvl == nil then lvl = 1 end
  assert(type(lvl) == "number", "argument #2 to 'fwd' must be a integer")

  local ps = package.config:sub(1, 1)

  local pwd = vim.fn.getenv("PWD")
  if pwd == nil then return "./" end
  local csrc = debug.getinfo(lvl + 1).source
  if not str.starts_with(csrc, "@" .. pwd) and str.starts_with(csrc, "@%.") then
    csrc = csrc:gsub("^@", pwd .. ps)
  else
    csrc = csrc:sub(2)
  end
  -- Replacing '/./' -> '/' or '\.\' -> '\' Not needed in a embedded Lua
  csrc = csrc:gsub(ps .. "%." .. ps, ps)
  if full then return csrc end
  local cpm = csrc:match("^(.*)" .. ps)
  return cpm
end

---Return the content of a file as a string. nil on error
---@param filepath string
---@return string?
function main.file_as_str(filepath)
  local file = io.open(filepath, "r")
  if not file then return end
  local content = file:read("a")
  file:close()
  return content
end

---Create a file with s as its content
---@param s string
---@param filepath string
function main.str_to_file(s, filepath)
  local file = io.open(filepath, "w")
  if not file then error(string.format("Error opening file: %s", filepath)) end

  file:write(s)
  file:close()
end

---Get some of the content of a file; from line {inp} to {enp} line
---@param filepath string
---@param inp? integer
---@param enp? integer
---@return string?, table?
function main.get_file_range(filepath, inp, enp)
  local file = io.open(filepath, "r")
  if not file then return end
  file:close()

  local lines = {}
  local linestr = ""
  local cl = 1

  for ln in io.lines(filepath) do
    if cl >= inp and cl <= enp then
      lines[#lines + 1] = {
        n = cl,
        c = ln,
      }
      linestr = linestr .. "\n" .. ln
    end
    cl = cl + 1
  end

  return linestr, lines
end

return main
