local M = {}

local js_ts_debug_script = {
  name = "Run npm script",
  type = "pwa-node",
  request = "launch",
  cwd = "${workspaceFolder}",
  rootPath = "${workspaceFolder}",
  sourceMaps = true,
  skilpFiles = { "<node_internals>/**/*.js", "node_modules/**/*.js" },
  resolveSourceMapLocations = {
    "${workspaceFolder}/**",
    "!**/node_modules/**"
  },
  protocol = "inspector",
  console = "integratedTerminal",
  runtimeExecutable = "npm",
  runtimeArgs = {}
}

local js_ts_debug_current_file = {
  name = "Debug Current File",
  type = "pwa-node",
  request = "launch",
  cwd = "${workspaceFolder}",
  sourceMaps = true,
  skilpFiles = { "<node_internals>/**/*.js", "node_modules/**/*.js" },
  resolveSourceMapLocations = {
    "${workspaceFolder}/**",
    "!**/node_modules/**"
  },
  protocol = "inspector",
  console = "integratedTerminal",
  runtimeExecutable = "ts-node-dev",
  runtimeArgs = { "--respawn", "--transpile-only", "--pretty", "${file}" },
}

--local js_ts_debug_current_file = {
--  name = "Current File",
--  type = "pwa-node",
--  request = "launch",
--  runtimeExecutable = "node",
--  runtimeArgs = { "-r", "ts-node/register" },
--  args = { "--inspect", "${file}" },
--  skipFiles = { "node_modules/**" },
--}

local js_ts_attach_config = {
  name = "Run npm script",
  type = "node",
  request = "attach",
  skilpFiles = { "<node_internals>/**" },
}



local goConfigs = {
  {
    type = "go",
    name = "Debug",
    request = "launch",
    program = "${file}",
    dlvToolPath = vim.fn.exepath('dlv'),
  },
  {
    type = "go",
    name = "Debug Project",
    request = "launch",
    program = "${workspaceFolder}",
    dlvToolPath = vim.fn.exepath('dlv'),
  }
}

M.go = goConfigs
M.attach = js_ts_attach_config
M.current_file = js_ts_debug_current_file
M.js_ts_debug_script = js_ts_debug_script

return M
