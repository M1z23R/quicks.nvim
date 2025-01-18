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

local function detect_project_type()
  local cwd = vim.fn.getcwd()

  local project_types = {
    { type = "go",         file = "go.mod" },
    { type = "typescript", file = "tsconfig.json" },
    { type = "javascript", file = "package.json" },
    { type = "python",     file = "requirements.txt" },
    { type = "git",        file = ".git" },
  }

  for _, project in ipairs(project_types) do
    local filepath = cwd .. "/" .. project.file
    if vim.loop.fs_stat(filepath) then
      return project.type
    end
  end

  return "unknown"
end

M.get_package_scripts = get_package_scripts
M.detect_project_type = detect_project_type

return M
