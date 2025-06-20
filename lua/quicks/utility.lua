local M = {}

local function get_package_scripts()
  local scripts = {}
  local file = io.open("package.json", "r")
  if file then
    local content = file:read("*a")
    file:close()
    local parsed = vim.fn.json_decode(content)
    if parsed.scripts then
      for n, _ in pairs(parsed.scripts) do
        table.insert(scripts, { name = n, value = n })
      end
    end
  end
  return scripts
end

M.get_package_scripts = get_package_scripts

return M
