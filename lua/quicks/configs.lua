local M = {}

local js_ts_debug_script = {
  name = "Run npm script",
  type = "pwa-node",
  request = "launch",
  cwd = "${workspaceFolder}",
  rootPath = "${workspaceFolder}",
  sourceMaps = true,
  skilpFiles = { "<node_internals>/**", "node_modules/**" },
  protocol = "inspector",
  console = "integratedTerminal",
  runtimeExecutable = "npm",
  runtimeArgs = {}
}


local js_ts_debug_current_file = {
  name = "Current File",
  type = "node",
  request = "launch",
  runtimeArgs = { "-r", "ts-node/register" },
  runtimeExecutable = "node",
  args = { "--inspect", "${file}" },
  skipFiles = { "node_modules/**" },
  restart = true
}

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
