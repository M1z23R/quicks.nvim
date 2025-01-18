local M = {}

local function prompt_commit_message(callback)
  vim.ui.input({ prompt = "Enter commit message: " }, function(commit_message)
    if not commit_message or commit_message == "" then
      vim.notify("Commit message cannot be empty.", vim.log.levels.ERROR)
      return
    end
    callback(commit_message)
  end)
end

local function execute_git_command(cmd, success_message, failure_message)
  local joined_cmd = table.concat(cmd, "")
  print(joined_cmd)
  vim.fn.jobstart(joined_cmd, {
    on_exit = function(_, code)
      if code == 0 then
        vim.notify(success_message, vim.log.levels.INFO)
      else
        vim.notify(failure_message, vim.log.levels.ERROR)
      end
    end,
  })
end

local function prompt()
  vim.ui.select(
    {
      { name = "Stage & Commit",         value = "stage_commit" },
      { name = "Stage all",              value = "git_add" },
      { name = "Quick commit",           value = "quick_commit" },
      { name = "Stage, Commit and Push", value = "stage_commit_push" }
    },
    {
      prompt = "Quick git",
      format_item = function(config)
        return config.name
      end,
    },
    function(selected)
      if not selected then
        vim.notify("Nothing was selected.", vim.log.levels.INFO)
        return
      end

      local actions = {
        stage_commit = function()
          prompt_commit_message(function(commit_message)
            execute_git_command(
              { "git", "add", ".", "&&", "git", "commit", "-m", commit_message },
              "Changes staged and committed.",
              "Failed to stage and commit changes."
            )
          end)
        end,
        git_add = function()
          execute_git_command(
            { "git", "add", "." },
            "All changes staged.",
            "Failed to stage changes."
          )
        end,
        quick_commit = function()
          prompt_commit_message(function(commit_message)
            execute_git_command(
              { "git", "commit", "-m", commit_message },
              "Quick commit completed.",
              "Quick commit failed."
            )
          end)
        end,
        stage_commit_push = function()
          prompt_commit_message(function(commit_message)
            execute_git_command(
              { "git", "add", ".", "&&", "git", "commit", "-m", "\"" .. commit_message .. "\"", "&&", "git", "push" },
              "Changes staged, committed, and pushed.",
              "Failed to complete stage, commit, and push."
            )
          end)
        end,
      }

      local action = actions[selected.value]
      if action then
        action()
      else
        vim.notify("Invalid action selected.", vim.log.levels.ERROR)
      end
    end
  )
end

M.prompt = prompt

return M
