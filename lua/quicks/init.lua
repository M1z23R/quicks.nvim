local M = {}

local go = require("quicks.go")
local js = require("quicks.js")
local git = require("quicks.git")

local js_filetypes = { javascript = true, typescript = true, javascriptreact = true, typescriptreact = true }
local go_filetypes = { go = true, gomod = true }

local all_actions = {
  { name = "Run npm script", fn = js.run, filetypes = js_filetypes },
  { name = "Go Debug", fn = go.debug, filetypes = go_filetypes },
  { name = "Go Fix all", fn = go.fix_all, filetypes = go_filetypes },
  { name = "JS/TS Attach", fn = js.debug, filetypes = js_filetypes },
  { name = "Remove unused imports", fn = js.remove_unused, filetypes = js_filetypes },
  { name = "JS/TS Fix all", fn = js.fix_all, filetypes = js_filetypes },
  { name = "Quick git", fn = git.prompt, filetypes = nil },
}

local function get_actions_for_filetype(ft)
  local actions = {}
  for _, action in ipairs(all_actions) do
    if action.filetypes == nil or action.filetypes[ft] then
      table.insert(actions, action)
    end
  end
  return actions
end

local function run_or_debug()
  local ft = vim.bo.filetype
  local actions = get_actions_for_filetype(ft)

  local action_names = {}
  for _, action in ipairs(actions) do
    table.insert(action_names, action.name)
  end

  vim.ui.select(
    action_names,
    {
      prompt = "Choose an action:",
      format_item = function(item)
        return item
      end,
    },
    function(selection)
      if not selection or selection == "" then
        vim.notify("Action selection cancelled.", vim.log.levels.INFO)
        return
      end

      for _, action in ipairs(actions) do
        if action.name == selection then
          action.fn()
          return
        end
      end

      vim.notify("Invalid action selected.", vim.log.levels.ERROR)
    end
  )
end

M.run_or_debug = run_or_debug
return M
