# UnrealDev.nvim

# Unreal Engine Development Sweet 💓 Neovim

`UnrealDev.nvim`は、**Unreal Neovim Plugin sweet** スイート（`UEP`, `UBT`, `UCM`, `ULG`, `USH`）の機能を、単一のグローバルコマンド `:UDEV` に統合する、薄いラッパープラグインです。

各プラグインのセットアップを簡素化し、すべてのUnreal Engine関連操作を
単一のインターフェースから呼び出すことを目的としています。

[English](README.md) | [日本語 (Japanese)](README_ja.md)

-----

## ✨ 機能 (Features)

  * **統一されたコマンドインターフェース**:
      * `:UDEV` コマンドから、スイートに含まれるすべてのプラグインの機能（プロジェクト探索、ビルド、クラス管理、ログ表示、シェル操作）を呼び出せます。
  * **シンプルな依存関係管理**:
      * このプラグインを導入するだけで、Unreal Engine開発に必要なすべてのNeovimプラグイン（`UNL`, `UEP`, `UBT`, `UCM`, `ULG`, `USH`）を依存関係として一元管理できます。
  * **統一されたAPI**:
      * `require('UnrealDev.api')` を通じて、すべてのスイートプラグインのAPI関数にアクセスでき、キーマップや自動化の作成が容易になります。

## 🔧 必要要件 (Requirements)

  * Neovim v0.11.3 以上
  * [**UNL.nvim**](https://github.com/taku25/UNL.nvim) (**必須のコアライブラリ**)
  * **必須のスイートプラグイン:**
      * [**UEP.nvim**](https://github.com/taku25/UEP.nvim)
      * [**UBT.nvim**](https://github.com/taku25/UBT.nvim)
      * [**UCM.nvim**](https://github.com/taku25/UCM.nvim)
      * [**ULG.nvim**](https://github.com/taku25/ULG.nvim)
      * [**USH.nvim**](https://github.com/taku25/USH.nvim)
  * **外部ツール (各プラグインが要求):**
      * [fd](https://github.com/sharkdp/fd) (UEPのスキャン、UCM、ULG のUIで推奨)
      * [rg](https://github.com/BurntSushi/ripgrep) (UEPのGrepに必須)
  * **オプション (UI) (スイート全体の体験向上のため、導入を強く推奨):**
      * **UI (Picker):**
          * [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
          * [fzf-lua](https://github.com/ibhagwan/fzf-lua)
      * **UI (Tree View):**
          * [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
          * [neo-tree-unl.nvim](https://github.com/taku25/neo-tree-unl.nvim) (UEPのツリー や ULG の insights に必要)
      * **UI (Progress):**
          * [fidget.nvim](https://github.com/j-hui/fidget.nvim) (UBTの進捗表示に推奨)
      * **UI (Statusline):**
          * [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) (ULGのステータス表示に推奨)

## 🚀 インストール (Installation)

[lazy.nvim](https://github.com/folke/lazy.nvim) でのインストール例です。
`UnrealDev.nvim` が他のすべてのスイートプラグインに依存していることを定義します。

```lua
return {
  {
    'taku25/UnrealDev.nvim',
    -- 開発スイートの全プラグインを依存関係として指定
    dependencies = {
      'taku25/UNL.nvim', -- コアライブラリ
      'taku25/UEP.nvim', -- プロジェクトエクスプローラー
      'taku25/UBT.nvim', -- ビルドツール
      'taku25/UCM.nvim', -- クラス管理
      'taku25/ULG.nvim', -- ログビューア
      'taku25/USH.nvim', -- Unreal シェル
      
      -- UIプラグイン (オプション)
      'nvim-telescope/telescope.nvim',
      'ibhagwan/fzf-lua',
      'nvim-neo-tree/neo-tree.nvim',
      'taku25/neo-tree-unl.nvim',
      'j-hui/fidget.nvim',
      'nvim-lualine/lualine.nvim',
    },
    -- UnrealDev.nvim 固有の設定 (主にロギング)
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
  -- 各プラグインの個別設定 (オプション)
  -- ---
  -- (例) UBT.nvim の設定
  {
    'taku25/UBT.nvim',
    opts = {
      presets = {
          -- カスタムプリセット
      },
      preset_target = "Win64DevelopWithEditor",
    }
  },
  
  -- (例) UEP.nvim の設定
  {
    'taku25/UEP.nvim',
    opts = {
      engine_path = "C:/Program Files/Epic Games/UE_5.4", -- エンジンパス指定
    }
  },
  
  -- (例) UCM.nvim の設定
  { 'taku25/UCM.nvim', opts = { ... } },
  -- (例) ULG.nvim の設定
  { 'taku25/ULG.nvim', opts = { ... } },
  -- (例) USH.nvim の設定
  { 'taku25/USH.nvim', opts = { ... } },
}
```

## ⚙️ 設定 (Configuration)

`UnrealDev.nvim` 自体の設定は、上記の `opts` テーブルに示すように、`logging` など最小限のものです。

スイートに含まれる各プラグイン（`UEP`, `UBT` など）の
設定は、`lazy.nvim` の各プラグインのスペック（定義）に `opts` を渡すことで行います（上記のインストール例を参照）。
設定の詳細は、各プラグインの `README` を参照してください。

## ⚡ 使い方 (Usage)

すべてのコマンドは `:UDEV` から始まります。

```viml
" ===== UEP コマンド ===== "
" プロジェクトを再スキャン
:UDEV refresh [Game|Engine]
" ファイルを検索
:UDEV files[!] [Game|Engine]
" クラスの #include を挿入
:UDEV add_include[!] [ClassName]
" 派生クラスを検索
:UDEV find_derived[!] [ClassName]
" プロジェクトツリーを表示
:UDEV tree
" (他、UEPの全コマンド: module_files, grep, open_file, cd など)


" ===== UBT コマンド ===== "
" ターゲットをビルド
:UDEV build[!] [label]
" compile_commands.json を生成
:UDEV gencompiledb[!] [label]
" プロジェクトファイル (slnなど) を生成
:UDEV genproject
" プロジェクトを実行
:UDEV run
" (他、UBTの全コマンド: genheader, lint, diagnostics)


" ===== UCM コマンド ===== "
" 新しいクラスを作成
:UDEV new [class_name] [parent_class]
" ヘッダー/ソースを切り替え
:UDEV switch
" クラスを削除 (名前が衝突するため class_delete に変更)
:UDEV class_delete [file_path]
" (他、UCMの全コマンド: move, rename)


" ===== ULG コマンド ===== "
" ログの追跡を開始
:UDEV start_log[!]
" ログの追跡を停止
:UDEV stop_log
" ログウィンドウを閉じる
:UDEV close_log
" (他、ULGの全コマンド: trace_log, crash_log, remote, remote_command)


" ===== USH コマンド ===== "
" UShell セッションを開始
:UDEV start_session
" UShell セッションを停止
:UDEV stop_session
" UShell 経由でビルド
:UDEV ushell_build
" (他、USHの全コマンド: ushell_cook, ushell_run, sln, uat, stage, p4, direct)
```

### コマンド詳細

`UnrealDev.nvim` は、各プラグインのコマンドを `:UDEV` のサブコマンドとしてマッピングします。

  * `UEP.nvim` の `:UEP refresh` は `:UDEV refresh` になります。
  * `UBT.nvim` の `:UBT build` は `:UDEV build` になります。

**名前の衝突について:**

  * `:UCM delete` は `:UDEV class_delete` にマッピングされます。
  * `:UEP delete` は `:UDEV project_delete` にマッピングされます。
  * `ULG` のコマンドは `:UDEV start_log`, `:UDEV stop_log` のように `_log` が付きます。
  * `USH` のコマンドは `:UDEV ushell_build` のように `ushell_` が付くものがあります。

**各コマンドの引数や詳細な動作については、オリジナルのプラグインのドキュメントを参照してください。**

  * [**UEP.nvim (使い方)**](https://github.com/taku25/UEP.nvim/blob/main/README_ja.md)
  * [**UBT.nvim (README)**](https://github.com/taku25/UBT.nvim/blob/main/README_ja.md)
  * [**UCM.nvim (README)**](https://github.com/taku25/UCM.nvim/blob/main/README_ja.md)
  * [**ULG.nvim (README)**](https://github.com/taku25/ULG.nvim/blob/main/README_ja.md)
  * [**USH.nvim (README)**](https://github.com/taku25/USH.nvim/blob/main/README_ja.md)

## 🤖 API & 自動化 (Automation Examples)

`UnrealDev.api` モジュールを通じて、すべての機能にプログラムでアクセスできます。

  * **`require('UnrealDev.api').refresh(opts)`** (UEP)
  * **`require('UnrealDev.api').build(opts)`** (UBT)
  * **`require('UnrealDev.api').new_class(opts)`** (UCM)
  * **`require('UnrealDev.api').start_log(opts)`** (ULG)
  * **`require('UnrealDev.api').start_session(opts)`** (USH)
  * ... など、すべてのAPIが利用可能です。

### キーマップ作成例

`UEP.api` や `UCM.api` を個別に `require` する代わりに、`UnrealDev.api` を使用できます。

#### インクルードファイルを開く (Open File)

標準の`gf`コマンドをUEPのインテリジェントなファイル検索で強化します。

```lua
-- init.lua や keymaps.lua などに記述
vim.keymap.set('n', 'gf', require('UnrealDev.api').open_file, { noremap = true, silent = true, desc = "UDEV: インクルードファイルを開く" })
```

#### インクルードを追加 (Add Include)

カーソル下のクラスに対する\#includeディレクティブを素早く追加します。

```lua
-- init.lua や keymaps.lua などに記述
vim.keymap.set('n', '<leader>ai', require('UnrealDev.api').add_include, { noremap = true, silent = true, desc = "UDEV: #includeディレクティブを追加" })
```

#### ヘッダー/ソース切り替え (Switch H/S)

UCMの切り替え機能をキーマップに割り当てます。

```lua
-- init.lua や keymaps.lua などに記述
vim.keymap.set('n', '<leader>oo', function()
  require('UnrealDev.api').switch_file({ current_file_path = vim.api.nvim_buf_get_name(0) })
end, { noremap = true, silent = true, desc = "UDEV: H/Sファイルを切り替え" })
```

#### ファイル検索

プロジェクトのファイルを素早く検索するためのキーマップを作成します。

```lua
-- init.lua や keymaps.lua などに記述
vim.keymap.set('n', '<leader>pf', function()
  require('UnrealDev.api').files({})
end, { desc = "UDEV: プロジェクトファイル検索" })
```

## その他

Unreal Engine 関連プラグイン:

  * [UEP.nvim](https://github.com/taku25/UEP.nvim)
      * urpojectを解析してファイルナビゲートなどを簡単に行えるようになります
  * [UBT.nvim](https://github.com/taku25/UBT.nvim)
      * BuildやGenerateClangDataBaseなどを非同期でNeovim上から使えるようになります
  * [UCM.nvim](https://github.com/taku25/UCM.nvim)
      * クラスの追加や削除がNeovim上からできるようになります。
  * [ULG.nvim](https://github.com/taku25/ULG.nvim)
      * UEのログやliveCoding,stat fpsなどnvim上からできるようになります
  * [USH.nvim](https://github.com/taku25/USH.nvim)
      * ushellをnvimから対話的に操作できるようになります
  * [neo-tree-unl](https://github.com/taku25/neo-tree-unl.nvim)
      * IDEのようなプロジェクトエクスプローラーを表示できます。
  * [tree-sitter for Unreal Engine](https://github.com/taku25/tree-sitter-unreal-cpp)
      * UCLASSなどを含めてtree-sitterの構文木を使ってハイライトができます。

## 📜 ライセンス (License)

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
