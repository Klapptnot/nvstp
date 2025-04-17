local __map__ = require("config.data.mapping")

---@class NvimMappingConfig
local main = {}

---Return a new instance of mapping table
---@param tbl? NvstpKeyMapp[]
---@return NvimMappingConfig
function main:new(tbl)
  ---@type NvstpKeyMapp[]
  self = tbl or __map__
  setmetatable(self, { __index = main })
  return self
end

---Merge mappings table into self
---@param tbl table
---@return NvimMappingConfig
function main:merge(tbl) return self:new(vim.tbl_deep_extend("force", self, tbl)) end

---Make all mappings on `mapps` non-op in the most common modes
---@param mapps string[]
---@return NvimMappingConfig
function main:no_op_key(mapps)
  if mapps == nil then return self end
  local opts = { noremap = false, silent = true }
  for _, mapp in ipairs(mapps) do
    vim.keymap.set("n", mapp, "<NOP>", opts)
    vim.keymap.set("v", mapp, "<NOP>", opts)
    vim.keymap.set("i", mapp, "<NOP>", opts)
    vim.keymap.set("t", mapp, "<NOP>", opts)
    vim.keymap.set("x", mapp, "<NOP>", opts)
    vim.keymap.set("s", mapp, "<NOP>", opts)
    vim.keymap.set("o", mapp, "<NOP>", opts)
    vim.keymap.set("c", mapp, "<NOP>", opts)
    vim.keymap.set("!", mapp, "<NOP>", opts)
    vim.keymap.set("l", mapp, "<NOP>", opts)
  end
  return self
end

---Disable the mouse mappings
---@return NvimMappingConfig
function main:disable_mouse()
  local mouse_events = {
    "<LeftMouse>",
    "<LeftDrag>",
    "<LeftRelease>",
    "<RightMouse>",
    "<RightDrag>",
    "<RightRelease>",
    "<MiddleMouse>",
    "<MiddleDrag>",
    "<MiddleRelease>",
    "<ScrollWheelUp>",
    "<ScrollWheelDown>",
    "<ScrollWheelLeft>",
    "<ScrollWheelRight>",
  }
  self:no_op_key(mouse_events)
  return self
end

---Add one keybinding to the table
---@param props NvstpKeyMapp
---@return NvimMappingConfig
function main:add(props)
  self[#self + 1] = props
  return self
end

---Apply all mappings to nvim
function main:apply()
  local rcall = require("src.warm.spr").rcall
  local fmt = string.format

  for _, props in pairs(self) do
    ---@cast props NvstpKeyMapp
    if type(props.exec) == "function" then
      ---@diagnostic disable-next-line: assign-type-mismatch
      props.opts.callback = props.exec
      props.exec = ""
    end
    props.opts = props.opts or {}
    props.opts.desc = props.desc -- Just to not nest items
    for _, mode in ipairs(props.mode) do
      local map_key = rcall(vim.api.nvim_set_keymap, mode, props.mapp, props.exec, props.opts)
      if not map_key() then
        print(fmt("Mapping error for '%s': %s", tostring(props.desc), map_key.unwrap(true)))
      end
    end
  end
  return self
end

return main
