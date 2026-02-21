local M = {}

local utils = require("quicks.utility")
local dap = require("dap")
local dapui = require("dapui")

local attach_config = {
  name = "Run npm script",
  type = "pwa-node",
  request = "attach",
  skilpFiles = { "<node_internals>/**/*.js", "node_modules/**/*.js" },
  resolveSourceMapLocations = {
    "${workspaceFolder}/**",
    "!**/node_modules/**"
  },
}

local function debug()
  dap.run(attach_config)
  dapui.open()
end

local function run_npm_script()
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

local function remove_unused_imports()
  vim.lsp.buf.code_action({
    apply = true,
    context = {
      only = { "source.removeUnused.ts" },
      diagnostics = {},
    },
  })
end

local function fix_all()
  vim.lsp.buf.code_action({
    apply = true,
    context = {
      only = { "source.fixAll.ts" },
      diagnostics = {},
    },
  })
end

M.run = run_npm_script
M.debug = debug
M.remove_unused = remove_unused_imports
M.fix_all = fix_all

return M
