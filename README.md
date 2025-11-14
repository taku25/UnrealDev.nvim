# UnrealDev.nvim

# Unreal Engine Development Sweet 💓 Neovim

`UnrealDev.nvim` is a thin wrapper plugin that integrates the functionality of the **Unreal Neovim Plugin Sweet** suite (`UEP`, `UBT`, `UCM`, `ULG`, `USH`) into a single global command, `:UDEV`.

Its purpose is to simplify the setup of each plugin and allow all Unreal Engine-related operations to be called from a single interface.

[English](README.md) | [日本語 (Japanese)](README_ja.md)

-----

## 📚 Detailed Documentation (Wiki)

**Detailed installation instructions, configuration, command lists, and API usage examples are all available on the [GitHub Wiki](https://github.com/taku25/UnrealDev.nvim/wiki).**

Please refer to the wiki first when setting up or customizing.

  * **[➡️ 🚀 Installation & Setup](https://github.com/taku25/UnrealDev.nvim/wiki/Installation)**
  * **[➡️ ⚙️Configuration](https://github.com/taku25/UnrealDev.nvim/wiki/Configuration)**

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

**✅ For a complete list of external tool requirements (like `fd`, `rg`) and recommended UI plugins (like `telescope`, `neo-tree`), please see the [Wiki Installation Page](https://github.com/taku25/UnrealDev.nvim/wiki/Installation).**

## 🚀 Installation

Example installation for [lazy.nvim](https://github.com/folke/lazy.nvim).
Define `UnrealDev.nvim` as dependent on all other suite plugins.

```lua
return {
  {
    'taku25/UnrealDev.nvim',
    -- Specify all plugins in the development suite as dependencies
    dependencies = {
      {
        'taku25/UNL.nvim', -- Core Library
        lazy = false,
      }
      'taku25/UEP.nvim', -- Project Explorer
      'taku25/UBT.nvim', -- Build Tool
      'taku25/UCM.nvim', -- Class Manager
      'taku25/ULG.nvim', -- Log Viewer
      'taku25/USH.nvim', -- Unreal Shell
      {
        'taku25/USX.nvim', -- Syntax highlight
        lazy=false,
      }
      
      -- UI Plugins (Optional)
      'nvim-telescope/telescope.nvim',
      'j-hui/fidget.nvim',
      'nvim-lualine/lualine.nvim',
      -- ...
    },
    opts = {
      -- Configuration specific to UnrealDev.nvim (mainly logging)
    },
  },

  -- ---
  -- Individual Plugin Settings (Optional)
  -- ---
  { 'taku25/UBT.nvim', opts = { ... } },
  { 'taku25/UEP.nvim', opts = { ... } },
  -- ...
}
```

**✅ For a complete installation example including UI plugins, and detailed `opts` examples for each plugin (`UEP`, `UBT`, etc.), please see the [Wiki Installation Guide](https://github.com/taku25/UnrealDev.nvim/wiki/Installation).**

## ⚙️ Configuration

Configuration for `UnrealDev.nvim` itself is minimal, such as `logging` settings shown in the `opts` table above.

Configuration for each plugin in the suite (`UEP`, `UBT`, etc.) is done by passing `opts` to each plugin's spec in `lazy.nvim` (see installation example above).

**✅ For detailed configuration options for each plugin, please refer to the [Wiki Configuration Page](https://github.com/taku25/UnrealDev.nvim/wiki/Configuration) or each plugin's individual `README`.**

## ⚡ Usage

All commands start with `:UDEV`.

```viml
" ===== (Examples) ===== "

" Rescan the project
:UDEV refresh

" Find files
:UDEV files

" Build a target
:UDEV build

" Create a new class
:UDEV new MyNewActor AActor

" Switch header/source
:UDEV switch

" Start tailing a log
:UDEV start_log
```

**✅ For details on all `UDEV` subcommands, arguments, and command name conflicts (e.g., `:UDEV class_delete`), please see the [Wiki Command Reference](https://github.com/taku25/UnrealDev.nvim/wiki/Commands).**
*(Note: Assuming the English page for `Command_ja` is `Commands`)*

## 🤖 API & Automation Examples

You can access all functions programmatically through the `UnrealDev.api` module.

```lua
-- (Example) Map UCM's 'switch' function
vim.keymap.set('n', '<leader>oo', function()
  require('UnrealDev.api').switch_file({ current_file_path = vim.api.nvim_buf_get_name(0) })
end, { noremap = true, silent = true, desc = "UDEV: Switch H/S file" })

-- (Example) Map UEP's 'files' function
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
  * [USX.nvim](https://github.com/taku25/USX.nvim)
      * Plugin for highlight settings for tree-sitter-unreal-cpp and tree-sitter-unreal-shader.
  * [neo-tree-unl](https://github.com/taku25/neo-tree-unl.nvim)
      * Display an IDE-like project explorer.
  * [tree-sitter for Unreal Engine](https://github.com/taku25/tree-sitter-unreal-cpp)
      * Provides syntax highlighting using tree-sitter, including UCLASS, etc.
  * [tree-sitter for Unreal Engine Shader](https://github.com/taku25/tree-sitter-unreal-shader)
      * Provides syntax highlighting for Unreal Shaders like usf, ush.

## 📜 License

MIT License

Copyright (c) 2025 taku25

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons whom the Software is
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
