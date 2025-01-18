# quicks.nvim

**quicks.nvim** is a Neovim configuration that provides an optimized setup with a focus on speed, usability, and ease of use. It integrates a set of essential plugins and features, including intelligent code completion, syntax highlighting, and file navigation, to enhance your Neovim experience.

---

## Installation

### Using Lazy (Recommended)

1. **Install Lazy Plugin Manager** (if you haven't already):

   If you are using a plugin manager like `lazy.nvim`, install it by adding the following in your `init.lua` or `plugins.lua` file:

   ```lua
   -- Install Lazy plugin manager
   return require('lazy').setup({
     -- Add your plugins here
   })
   ```

2. **Install quicks.nvim:**

   Add the following configuration to your `init.lua` or `plugins.lua`:

   ```lua
   return {
     "M1z23R/quicks.nvim",
     config = function()
       -- Quick pickers configuration
       local pickers = require("quicks")
       vim.keymap.set('n', '<leader>tt', pickers.run_or_debug)
     end
   }
   ```

3. **Sync Plugins:**

   After adding the configuration, run the following command in Neovim to sync and install the plugins:

   ```vim
   :Lazy sync
   ```

---

## Key Bindings

- `<leader>tt`: This binds the quick picker function `run_or_debug`, enabling you to quickly run or debug code in your project.

---

## Example Configuration

Here’s how to use `quicks.nvim` with the Lazy plugin manager in your `init.lua`:

```lua
return {
  "M1z23R/quicks.nvim",
  config = function()
    -- Load quick pickers and set a keybinding for run_or_debug
    local pickers = require("quicks")
    vim.keymap.set('n', '<leader>tt', pickers.run_or_debug)
  end
}
```

---

Testing plugin
