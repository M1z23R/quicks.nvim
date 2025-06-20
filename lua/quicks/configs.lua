local M = {}






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
