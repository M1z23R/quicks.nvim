local M = {}

local utils = require("quicks.utility")
local configs = require("quicks.configs")

local function debug_npm_script()
  vim.ui.select(utils.get_package_scripts(), {
    prompt = "File or Script",
    format_item = function(v)
      return v.name
    end,
  }, function(selected)
    if selected == nil or selected == "" then
      vim.notify("Debug configuration selection cancelled", vim.log.levels.INFO)
      return
    end

    local config = configs.js_ts_debug_script
    config.runtimeArgs = { selected.value }
    require("dap").run(config)
  end)
end

local function run_and_debug()
  vim.ui.select({ "Current File", "Npm Script" }, {
    prompt = "File or Script",
    format_item = function(v)
      return v
    end,
  }, function(selected)
    if selected == "Current File" then
      require("dap").run(configs.js_ts_debug_current_file)
    elseif selected == "Npm Script" then
      debug_npm_script()
    else
      vim.notify("Debug configuration selection cancelled", vim.log.levels.INFO)
    end
  end)
end

local function debug(quick)
  if quick then
    require("dap").run(configs.js_ts_debug_current_file)
    return
  end


  vim.ui.select({ "Run", "Attach", }, {
    prompt = "Run or Attach",
    format_item = function(v)
      return v
    end,
  }, function(selected)
    print(selected)
    if selected == "Run" then
      run_and_debug()
    elseif selected == "Attach" then
      require("dap").run(configs.js_ts_attach_config)
    else
      vim.notify("Debug configuration selection cancelled", vim.log.levels.INFO)
    end
  end)
end

local function run()
  vim.ui.select(utils.get_package_scripts(), {
    prompt = "Choose script",
    format_item = function(config)
      return config.name
    end,
  }, function(selected)
    if selected then
      local tmux_cmd = "tmux split-window -v 'npm run " .. selected.value .. "'"
      vim.fn.system(tmux_cmd)
    else
      vim.notify("Debug configuration selection cancelled", vim.log.levels.INFO)
    end
  end)
end

M.run = run
M.debug = debug
M.run_and_debug = run_and_debug

return M
