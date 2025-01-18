local M = {}

local configs = require("quicks.configs")

local function debug()
  require("dap").run(configs.go)
end

local function run()
  vim.ui.select({ { name = "Run Project", value = "." }, { name = "Run File", value = "buffer" } }, {
    prompt = "Project or File",
    format_item = function(config)
      return config.name
    end,
  }, function(selected)
    if selected then
      local tmux_cmd = "tmux split-window -v 'go run " .. selected.value .. "'"
      vim.fn.system(tmux_cmd)
    else
      vim.notify("Debug configuration selection cancelled", vim.log.levels.INFO)
    end
  end)
end

M.debug = debug
M.run = run

return M
