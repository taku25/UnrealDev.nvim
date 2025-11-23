# UnrealDev.nvim

# Unreal Engine Development Sweet 💓 Neovim


<img width="2048" height="1342" alt="screenshot-20251122-191958" src="https://github.com/user-attachments/assets/4b26c5e7-461b-4e78-953b-9b2d6d24988e" />



`UnrealDev.nvim` is a thin wrapper plugin that integrates the functionality of the **Unreal Neovim Plugin Sweet** suite (`UEP`, `UBT`, `UCM`, `ULG`, `USH`, `UEA`) into a single global command, `:UDEV`.

Its purpose is to simplify the setup of each plugin and allow all Unreal Engine-related operations to be called from a single interface.

[English](README.md) | [日本語 (Japanese)](README_ja.md)

-----

# Introduction to Some Features


<table>
  <tr>
   <td>
    <div align=center>
      <img width="100%" alt="image" src="https://github.com/user-attachments/assets/b0a5080a-7f45-4d2f-94ed-898b307239b0" />
      UDEV tree
    </div>
  </td>
   <td>
    <div align=center>
      <img width="100%" alt="image" src="https://github.com/user-attachments/assets/0f0ef9a4-770e-4900-a5cf-6a29596a90c4" />
      UDEV tree & symbols
    </div>
    </td>
  </tr>
  <tr>
   <td>
    <div align=center>
      <img width="100%" alt="image" src="https://github.com/user-attachments/assets/f1907046-d1bb-48cb-936d-5ad45f1809cc" />
      UDEV build & error
    </div>
   </td>
   <td>
   <div align=center>
    <img width="100%" alt="image" src="https://github.com/user-attachments/assets/7753f489-b1ec-44bf-bea2-16ba268262cc" />
     UDEV new class
    </div>
    </td>
  </tr>
  <tr>
   <td>
    <div align=center>
      <img width="100%" alt="image" src="https://github.com/user-attachments/assets/c4bd92d5-e1e6-44ac-8b5c-b13bed5496ab" />
      UDEV classes
    </div>
   </td>
   <td>
   <div align=center>
    <img width="100%" alt="image" src="https://github.com/user-attachments/assets/ab76c626-f3d1-435a-b720-88cdb73fc731" />
      UDEV config_grep
    </div>
    </td>
  </tr>
</table>

many other features

-----

## 📚 Detailed Documentation (Wiki)

**Detailed installation instructions, configuration, command lists, and API usage examples are all available on the [GitHub Wiki](https://github.com/taku25/UnrealDev.nvim/wiki).**

Please refer to the wiki first when setting up or customizing.

  * **[➡️ 🚀 Installation & Setup](https://github.com/taku25/UnrealDev.nvim/wiki/Installation)**
  * **[➡️ ⚙️Configuration](https://github.com/taku25/UnrealDev.nvim/wiki/Configuration)**

-----

## ✨ Features

  * **Unified Command Interface**:
      * Call all detected plugin functions from the suite (project exploration, build, class management, log viewing, shell operations, asset inspection) from the `:UDEV` command.
  * **Automatic Feature Detection**:
      * Auto-detects installed suite plugins (`UEP`, `UBT`, `UCM`, `ULG`, `USH`, `UEA`) via `pcall` and provides commands only for those that are available.
  * **Unified API**:
      * Access all available suite plugin API functions via `require('UnrealDev.api')`, making it easy to create keymaps and automation.

## 🔧 Requirements

  * Neovim v0.11.3 or later
  * [**UNL.nvim**](https://github.com/taku25/UNL.nvim) (**Required core library**)
  * **Recommended Suite Plugins:** (Install any or all of these)
      * [**UEP.nvim**](https://github.com/taku25/UEP.nvim) (Project Explorer)
      * [**UEA.nvim**](https://github.com/taku25/UEA.nvim) (Asset (BP) Inspector)
      * [**UBT.nvim**](https://github.com/taku25/UBT.nvim) (Build Tool)
      * [**UCM.nvim**](https://github.com/taku25/UCM.nvim) (Class Manager)
      * [**ULG.nvim**](https://github.com/taku25/ULG.nvim) (Log Viewer)
      * [**USH.nvim**](https://github.com/taku25/USH.nvim) (Unreal Shell)
      * [**UNX.nvim**](https://github.com/taku25/UNX.nvim) (Logical View)

**✅ For a complete list of external tool requirements (like `fd`, `rg`) and recommended UI plugins (like `telescope`, `neo-tree`), please see the [Wiki Installation Page](https://github.com/taku25/UnrealDev.nvim/wiki/Installation).**

## 🚀 Installation

Example installation for [lazy.nvim](https://github.com/folke/lazy.nvim).
`UnrealDev.nvim` should be listed, and any suite plugins you want to use should be listed as well (they are no longer hard dependencies, but peers).

```lua
return {
  {
    'taku25/UnrealDev.nvim',
    -- Define all plugins in the development suite.
    -- You can remove any plugins you don't use.
    dependencies = {
      {
        'taku25/UNL.nvim', -- Core Library
        lazy = false,
      },
      'taku25/UEP.nvim', -- Project Explorer
      'taku25/UEA.nvim', -- Asset (Blueprint) Inspector
      'taku25/UBT.nvim', -- Build Tool
      'taku25/UCM.nvim', -- Class Manager
      'taku25/ULG.nvim', -- Log Viewer
      'taku25/USH.nvim', -- Unreal Shell
      'taku25/UNX.nvim', -- Logical View 
      {
        'taku25/USX.nvim', -- Syntax highlight
        lazy=false,
      },
      
      -- UI Plugins (Optional)
      'nvim-telescope/telescope.nvim',
      'j-hui/fidget.nvim',
      'nvim-lualine/lualine.nvim',
      -- ...
    },
    opts = {
      -- Configuration specific to UnrealDev.nvim
      -- (e.g., disable setup for plugins you don't have)
      setup_modules = {
        UBT = true,
        UEP = true,
        ULG = true,
        USH = true,
        UCM = true,
        UEA = true,
        UNX = true,
      },
    },
  },

  -- ---
  -- Individual Plugin Settings (Optional)
  -- ---
  { 'taku25/UBT.nvim', opts = { ... } },
  { 'taku25/UEP.nvim', opts = { ... } },
  { 'taku25/UEA.nvim', opts = { ... } },
  -- ...
}
````

**✅ For a complete installation example including UI plugins, and detailed `opts` examples for each plugin (`UEP`, `UBT`, etc.), please see the [Wiki Installation Guide](https://github.com/taku25/UnrealDev.nvim/wiki/Installation).**

## ⚙️ Configuration

Configuration for `UnrealDev.nvim` itself is minimal, such as the `setup_modules` table shown above.

Configuration for each plugin in the suite (`UEP`, `UBT`, etc.) is done by passing `opts` to each plugin's spec in `lazy.nvim` (see installation example above).

**✅ For detailed configuration options for each plugin, please refer to the [Wiki Configuration Page](https://github.com/taku25/UnrealDev.nvim/wiki/Configuration) or each plugin's individual `README`.**

## ⚡ Usage

All commands start with `:UDEV`. Only commands for *installed* plugins will be available.

```viml
" ===== (Examples) ===== "

" Rescan the project (from UEP)
:UDEV refresh

" Find files (from UEP)
:UDEV files

" Build a target (from UBT)
:UDEV build

" Create a new class (from UCM)
:UDEV new MyNewActor AActor

" Switch header/source (from UCM)
:UDEV switch

" Start tailing a log (from ULG)
:UDEV start_log

" Find Blueprint usages (from UEA)
:UDEV find_bp_usages
```

**✅ For details on all `UDEV` subcommands, arguments, and command name conflicts (e.g., `:UDEV class_delete`), please see the [Wiki Command Reference](https://github.com/taku25/UnrealDev.nvim/wiki/Commands).**
*(Note: Assuming the English page for `Command_ja` is `Commands`)*

## 🤖 API & Automation Examples

You can access all available functions programmatically through the `UnrealDev.api` module. If a plugin is not installed, its API functions will simply be `nil`.

```lua
-- (Example) Map UCM's 'switch' function (safe check)
vim.keymap.set('n', '<leader>oo', function()
  local api = require('UnrealDev.api')
  if api.switch_file then
    api.switch_file({ current_file_path = vim.api.nvim_buf_get_name(0) })
  end
end, { noremap = true, silent = true, desc = "UDEV: Switch H/S file" })

-- (Example) Map UEP's 'files' function (safe check)
vim.keymap.set('n', '<leader>pf', function()
  local api = require('UnrealDev.api')
  if api.files then
    api.files({})
  end
end, { desc = "UDEV: Find project files" })
```

## Others

Unreal Engine related plugins:

  * [UEP.nvim](https://github.com/taku25/UEP.nvim)
      * Analyzes .uproject to simplify file navigation.
  * [UEA.nvim](https://www.google.com/url?sa=E&source=gmail&q=https://github.com/taku25/UEA.nvim)
      * Finds Blueprint usages of C++ classes.
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
  * [UNX.nvim](https://github.com/taku25/UNX.nvim)
      *  A dedicated side-panel explorer for navigating project structure, class symbols, and performance insights. 
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
