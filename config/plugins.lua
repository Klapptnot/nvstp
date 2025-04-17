local __plugins__ = require("config.data.plugins")

---@class NvimPluginsConfig
local main = {}

---Return a new instance of plugins table
---@param tbl? table
---@return NvimPluginsConfig
function main:new(tbl)
  self = tbl or __plugins__
  setmetatable(self, { __index = main })
  return self
end

---Merge a table of plugins definitions into self
---@param tbl any
---@return NvimPluginsConfig
function main:merge(tbl) return self:new(vim.tbl_deep_extend("force", self, tbl)) end

---Add a plugin definition into self
---@param id string
---@param props table
---@return NvimPluginsConfig
function main:add(id, props)
  if self[id] == nil then self[id] = props end
  return self
end

---Return the table of plugins with no metatable
---@return table
function main:raw() return setmetatable(self, nil) end

---Install all plugins using lazy.nvim
---@param lazy_cfg? table
function main:apply(lazy_cfg)
  lazy_cfg = (lazy_cfg ~= nil and type(lazy_cfg) == "table") and lazy_cfg or {}
  require("lazy").setup(self:raw(), lazy_cfg)
end

return main
