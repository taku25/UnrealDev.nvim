# UnrealDev.nvim

# Unreal Engine Development Sweet 💓 Neovim

`UnrealDev.nvim` is a thin wrapper plugin that integrates the functionality of the **Unreal Neovim Plugin Sweet** suite (`UEP`, `UBT`, `UCM`, `ULG`, `USH`) into a single global command, `:UDEV`.

Its purpose is to simplify the setup of each plugin and allow all Unreal Engine-related operations to be called from a single interface.

[English](README.md) | [日本語 (Japanese)](https://www.google.com/search?q=README_ja.md)

-----

## ✨ Features

  * **Unified Command Interface**:
      * Call all plugin functions from the suite (project exploration, build, class management, log viewing, shell operations) from the `:UDEV` command.
  * **Simple Dependency Management**:
      * By installing this plugin, you can centrally manage all Neovim plugins required for Unreal Engine development (`UNL`, `UEP`, `UBT`, `UCM`, `ULG`, `USH`) as dependencies.
  * **Unified API**:
      * Access all suite plugin API functions via `require('UnrealDev.api')`, making it easy to create keymaps and automation.

## 🔧 Requirements

  * Neovim v0.11.3 or later
  * [**UNL.nvim**](https://github.com/taku25/UNL.nvim) (**Required core library**)
  * **Required Suite Plugins:**
      * [**UEP.nvim**](https://github.com/taku25/UEP.nvim)
      * [**UBT.nvim**](https://github.com/taku25/UBT.nvim)
      * [**UCM.nvim**](https://github.com/taku25/UCM.nvim)
      * [**ULG.nvim**](https://github.com/taku25/ULG.nvim)
      * [**USH.nvim**](https://github.com/taku25/USH.nvim)
  * **External Tools (Required by various plugins):**
      * [fd](https://github.com/sharkdp/fd) (Required  for UEP scan, UCM, and ULG UI)
      * [rg](https://github.com/BurntSushi/ripgrep) (Required for UEP grep)
  * **Optional (UI) (Strongly recommended for the full suite experience):**
      * **UI (Picker):**
          * [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
          * [fzf-lua](https://github.com/ibhagwan/fzf-lua)
          * [snacks](https://github.com/folke/snacks.nvim)
      * **UI (Tree View):**
          * [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
          * [neo-tree-unl.nvim](https://github.com/taku25/neo-tree-unl.nvim) (Required for UEP tree and ULG insights)
      * **UI (Progress):**
          * [fidget.nvim](https://github.com/j-hui/fidget.nvim) (Recommended for UBT progress display)
      * **UI (Statusline):**
          * [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) (Recommended for ULG status display)

## 🚀 Installation

Example for [lazy.nvim](https://github.com/folke/lazy.nvim).
Define `UnrealDev.nvim` as dependent on all other suite plugins.

```lua
return {
  {
    'taku25/UnrealDev.nvim',
    -- Specify all plugins in the development suite as dependencies
    dependencies = {
      'taku25/UNL.nvim', -- Core Library
      'taku25/UEP.nvim', -- Project Explorer
      'taku25/UBT.nvim', -- Build Tool
      'taku25/UCM.nvim', -- Class Manager
      'taku25/ULG.nvim', -- Log Viewer
      'taku25/USH.nvim', -- Unreal Shell
      
      -- UI Plugins (Optional)
      -- picker
      'nvim-telescope/telescope.nvim',
      -- or 
      --'ibhagwan/fzf-lua',
      -- or
      --'folke/snacks.nvim',
      -- progress
      'j-hui/fidget.nvim',
      -- status line
      'nvim-lualine/lualine.nvim',
    },
    -- Configuration specific to UnrealDev.nvim (mainly logging)
    opts = {
      logging = {
        level = "info",
        echo = { level = "warn" },
        notify = { level = "error", prefix = "[UDEV]" },
        file = { enable = true, max_kb = 256, rotate = 1, filename = "udev.log" },
      },
    },
  },

  -- ---
  -- Individual Plugin Settings (Optional)
  -- ---
  -- (Example) UBT.nvim settings
  {
    'taku25/UBT.nvim',
    opts = {
      presets = {
          -- Custom presets
      },
      preset_target = "Win64DevelopWithEditor",
    }
  },
  
  -- (Example) UEP.nvim settings
  {
    'taku25/UEP.nvim',
    opts = {
      engine_path = "C:/Program Files/Epic Games/UE_5.4", -- Specify engine path
    }
  },
  
  -- (Example) UCM.nvim settings
  { 'taku25/UCM.nvim', opts = { ... } },
  -- (Example) ULG.nvim settings
  { 'taku25/ULG.nvim', opts = { ... } },
  -- (Example) USH.nvim settings
  { 'taku25/USH.nvim', opts = { ... } },
}
```

## ⚙️ Configuration

Configuration for `UnrealDev.nvim` itself is minimal, such as `logging`, as shown in the `opts` table above.

Configuration for each plugin included in the suite (`UEP`, `UBT`, etc.) is done by passing `opts` to each plugin's spec in `lazy.nvim` (see installation example above).
Please refer to each plugin's `README` for configuration details.

## ⚡ Usage

All commands start with `:UDEV`.

```viml
" ===== UEP Commands ===== "
" Rescan the project
:UDEV refresh [Game|Engine]
" Find files
:UDEV files[!] [Game|Engine]
" Insert #include for a class
:UDEV add_include[!] [ClassName]
" Find derived classes
:UDEV find_derived[!] [ClassName]
" Show project tree
:UDEV tree
" (And all other UEP commands: module_files, grep, open_file, cd, etc.)


" ===== UBT Commands ===== "
" Build a target
:UDEV build[!] [label]
" Generate compile_commands.json
:UDEV gencompiledb[!] [label]
" Generate project files (sln, etc.)
:UDEV genproject
" Run the project
:UDEV run
" (And all other UBT commands: genheader, lint, diagnostics)


" ===== UCM Commands ===== "
" Create a new class
:UDEV new [class_name] [parent_class]
" Switch between header/source
:UDEV switch
" Delete a class (renamed to class_delete to avoid conflict)
:UDEV class_delete [file_path]
" (And all other UCM commands: move, rename)


" ===== ULG Commands ===== "
" Start tailing a log
:UDEV start_log[!]
" Stop tailing the log
:UDEV stop_log
" Close log windows
:UDEV close_log
" (And all other ULG commands: trace_log, crash_log, remote, remote_command)


" ===== USH Commands ===== "
" Start UShell session
:UDEV start_session
" Stop UShell session
:UDEV stop_session
" Build via UShell
:UDEV ushell_build
" (And all other USH commands: ushell_cook, ushell_run, sln, uat, stage, p4, direct)
```

### Command Details

`UnrealDev.nvim` maps each plugin's commands as subcommands of `:UDEV`.

  * `:UEP refresh` from `UEP.nvim` becomes `:UDEV refresh`.
  * `:UBT build` from `UBT.nvim` becomes `:UDEV build`.

**Regarding Name Conflicts:**

  * `:UCM delete` is mapped to `:UDEV class_delete`.
  * `:UEP delete` is mapped to `:UDEV project_delete`.
  * `ULG` commands have `_log` appended, like `:UDEV start_log`, `:UDEV stop_log`.
  * `USH` commands may have `ushell_` prefixed, like `:UDEV ushell_build`.

**For arguments and detailed behavior of each command, please refer to the original plugin's documentation.**

  * [**UEP.nvim (Usage)**](https://github.com/taku25/UEP.nvim/blob/main/README.md)
  * [**UBT.nvim (README)**](https://github.com/taku25/UBT.nvim/blob/main/README.md)
  * [**UCM.nvim (README)**](https://github.com/taku25/UCM.nvim/blob/main/README.md)
  * [**ULG.nvim (README)**](https://github.com/taku25/ULG.nvim/blob/main/README.md)
  * [**USH.nvim (README)**](https://github.com/taku25/USH.nvim/blob/main/README.md)

## 🤖 API & Automation Examples

You can access all functions programmatically through the `UnrealDev.api` module.

  * **`require('UnrealDev.api').refresh(opts)`** (UEP)
  * **`require('UnrealDev.api').build(opts)`** (UBT)
  * **`require('UnrealDev.api').new_class(opts)`** (UCM)
  * **`require('UnrealDev.api').start_log(opts)`** (ULG)
  * **`require('UnrealDev.api').start_session(opts)`** (USH)
  * ... and all other APIs are available.

### Keymap Examples

Instead of `require`ing `UEP.api` or `UCM.api` individually, you can use `UnrealDev.api`.

#### Open Include File (Open File)

Enhance the standard `gf` command with UEP's intelligent file search.

```lua
-- In init.lua or keymaps.lua
vim.keymap.set('n', 'gf', require('UnrealDev.api').open_file, { noremap = true, silent = true, desc = "UDEV: Open include file" })
```

#### Add Include

Quickly add the \#include directive for the class under the cursor.

```lua
-- In init.lua or keymaps.lua
vim.keymap.set('n', '<leader>ai', require('UnrealDev.api').add_include, { noremap = true, silent = true, desc = "UDEV: Add #include directive" })
```

#### Switch Header/Source (Switch H/S)

Assign UCM's switch function to a keymap.

```lua
-- In init.lua or keymaps.lua
vim.keymap.set('n', '<leader>oo', function()
  require('UnrealDev.api').switch_file({ current_file_path = vim.api.nvim_buf_get_name(0) })
end, { noremap = true, silent = true, desc = "UDEV: Switch H/S file" })
```

#### Find Files

Create a keymap to quickly find project files.

```lua
-- In init.lua or keymaps.lua
vim.keymap.set('n', '<leader>pf', function()
  require('UnrealDev.api').files({})
end, { desc = "UDEV: Find project files" })
```

## Others

Unreal Engine related plugins:

  * [UEP.nvim](https://github.com/taku25/UEP.nvim)
      * Analyzes .uproject to simplify file navigation.
  * [UBT.nvim](https://github.com/taku25/UBT.nvim)
      * Use Build, GenerateClangDataBase, etc., asynchronously from Neovim.
  * [UCM.nvim](https://github.com/taku25/UCM.nvim)
      * Add or delete classes from Neovim.
  * [ULG.nvim](https://github.com/taku25/ULG.nvim)
      * View UE logs, LiveCoding, stat fps, etc., from Neovim.
  * [USH.nvim](https://github.com/taku25/USH.nvim)
      * Interact with ushell from Neovim.
  * [neo-tree-unl](https://github.com/taku25/neo-tree-unl.nvim)
      * Display an IDE-like project explorer.
  * [tree-sitter for Unreal Engine](https://github.com/taku25/tree-sitter-unreal-cpp)
      * Provides syntax highlighting using tree-sitter, including UCLASS, etc.

## 📜 License

MIT License

Copyright (c) 2025 taku25

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
