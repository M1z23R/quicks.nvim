local M = {}

local go = require("quicks.go")
local js = require("quicks.js")
local git = require("quicks.git")
local utils = require("quicks.utility")


local function run_or_debug()
  vim.ui.select(
    { "Run npm script", "Go Debug", "JS/TS Attach", "Quick git" },
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

      local actions = {
        ["Run npm script"] = function()
          js.run()
        end,
        ["Go Debug"] = function()
          go.debug()
        end,
        ["JS/TS Attach"] = function()
          js.debug()
        end,
        ["Quick git"] = function()
          git.prompt()
        end,
      }

      local execute = actions[selection]
      if execute then
        execute()
      else
        vim.notify("Invalid action selected.", vim.log.levels.ERROR)
      end
    end
  )
end

M.run_or_debug = run_or_debug
return M
