local __globals__ = require("config.data.globals")

---@class NvimGlobalsConfig
local main = {}

---Return a instance of globals table
---@param tbl? table
---@return NvimGlobalsConfig
function main:new(tbl)
  self = tbl or __globals__
  setmetatable(self, { __index = main })
  return self
end

---Add a new global into self
---@param id string
---@param props any
---@return NvimGlobalsConfig
function main:add(id, props)
  if self[id] == nil then self[id] = props end
  return self
end

---Merge the given table into self
---@param tbl table
---@return NvimGlobalsConfig
function main:merge(tbl) return self:new(vim.tbl_deep_extend("force", self, tbl)) end

---Apply globals to nvim
function main:apply()
  for k, v in pairs(self) do
    vim.g[k] = v
  end
end

return main
