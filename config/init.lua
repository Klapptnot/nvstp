-- config loader

---@alias NvstpConfig {globals:NvimGlobalsConfig; mapping:NvimMappingConfig; options:NvimOptionsConfig; plugins:NvimPluginsConfig}

---@type NvstpConfig
local main = {
  ---@return NvimGlobalsConfig
  globals = require("config.globals"):new(),
  ---@return NvimMappingConfig
  mapping = require("config.mapping"):new(),
  ---@return NvimOptionsConfig
  options = require("config.options"):new(),
  ---@return NvimPluginsConfig
  plugins = require("config.plugins"):new(),
} -- Return all configs classes

return main
