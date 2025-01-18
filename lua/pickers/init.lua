local M = {}

local go = require("pickers.go")
local js = require("pickers.js")
local git = require("pickers.git")
local utils = require("pickers.utility")

local function start_debug(env, quick)
  if env == "unknown" then
    vim.notify("Unknown project type", vim.log.levels.INFO)
    return
  elseif env == "go" then
    go.debug()
  elseif env == "javascript" or env == "typescript" then
    js.debug(quick)
  elseif env == "git" then
    git.prompt()
  end
end

local function run_in_tmux(env)
  if env == "go" then
    go.run()
  elseif env == "git" then
    git.prompt()
  else
    js.run()
  end
end

local function run_or_debug()
  vim.ui.select(
    { "Run in tmux", "Debug Current File", "Debug Advanced" },
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

      local env = utils.detect_project_type()
      local actions = {
        ["Run in tmux"] = function()
          run_in_tmux(env)
        end,
        ["Debug Current File"] = function()
          start_debug(env, true)
        end,
        ["Debug Advanced"] = function()
          start_debug(env)
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

vim.keymap.set("n", "<leader>tt", run_or_debug, { desc = "Run or Debug" })

M.run_or_debug = run_or_debug
return M
