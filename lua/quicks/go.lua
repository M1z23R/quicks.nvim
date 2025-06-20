local M = {}

local scan = require("plenary.scandir")
local Path = require("plenary.path")
local dap = require("dap")
local dapui = require("dapui")
local current_file_config = {
  type = "go",
  name = "Debug Current File",
  request = "launch",
  program = vim.fn.expand("%:p"),
}

local function get_cmd_binaries()
  local entries = scan.scan_dir(vim.fn.getcwd() .. "/cmd", {
    only_dirs = true,
    depth = 1,
  })

  for i, path in ipairs(entries) do
    entries[i] = Path:new(path):make_relative(vim.fn.getcwd())
  end

  return entries
end

local function debug()
  local binaries = get_cmd_binaries()
  local items = {
    { name = "Debug Current File", value = "file" },
  }

  for _, bin in ipairs(binaries) do
    table.insert(items, { name = "Debug " .. bin, value = bin })
  end

  vim.ui.select(items, {
    prompt = "Select debug target",
    format_item = function(item)
      return item.name
    end,
  }, function(selected)
    if not selected then
      vim.notify("Debug target selection cancelled", vim.log.levels.INFO)
      return
    end

    if selected.value == "file" then
      dap.run(current_file_config)
    else
      dap.run({
        type = "go",
        name = "Debug " .. selected.value,
        request = "launch",
        program = vim.fn.getcwd() .. "/" .. selected.value,
      })
    end
    dapui.open()
  end)
end

M.debug = debug

return M
