# UnrealDev.nvim

# Unreal Engine Development Sweet 💓 Neovim

`UnrealDev.nvim` は、 **Unreal Neovim Plugin Sweet** スイート（`UEP`, `UBT`, `UCM`, `ULG`, `USH`）の機能を、単一のグローバルコマンド `:UDEV` に統合する薄いラッパープラグインです。

各プラグインのセットアップを簡素化し、Unreal Engine関連のすべての操作を単一のインターフェースから呼び出せるようにすることを目的としています。

[English](README.md) | [日本語 (Japanese)](README_ja.md)

-----

## 📚 詳細ドキュメント (Wiki)

**詳しいインストール方法、設定、コマンド一覧、APIの使用例は、すべて [GitHub Wiki](https://github.com/taku25/UnrealDev.nvim/wiki) にまとめてあります。**

セットアップやカスタマイズの際は、まずこちらをご覧ください。

  * **[➡️ 🚀 インストールと設定 (Installation & Setup)](https://github.com/taku25/UnrealDev.nvim/wiki/Installation_ja)**
  * **[➡️ ⚙️ オプション詳細 (Configuration)](https://github.com/taku25/UnrealDev.nvim/wiki/Configuration_ja)**

-----

## ✨ Features

  * **統一されたコマンドインターフェース**:
      * スイートの全プラグイン機能（プロジェクト探索、ビルド、クラス管理、ログ閲覧、シェル操作）を `:UDEV` コマンドから呼び出せます。
  * **シンプルな依存関係管理**:
      * このプラグインをインストールするだけで、Unreal Engine開発に必要なNeovimプラグイン（`UNL`, `UEP`, `UBT`, `UCM`, `ULG`, `USH`）を依存関係として一元管理できます。
  * **統一されたAPI**:
      * `require('UnrealDev.api')` を介してすべてのスイートプラグインAPI関数にアクセスでき、キーマップや自動化の作成が容易になります。

## 🔧 Requirements

  * Neovim v0.11.3 or later
  * [**UNL.nvim**](https://github.com/taku25/UNL.nvim) (**必須コアライブラリ**)
  * **必須スイートプラグイン:**
      * [**UEP.nvim**](https://github.com/taku25/UEP.nvim)
      * [**UBT.nvim**](https://github.com/taku25/UBT.nvim)
      * [**UCM.nvim**](https://github.com/taku25/UCM.nvim)
      * [**ULG.nvim**](https://github.com/taku25/ULG.nvim)
      * [**USH.nvim**](https://github.com/taku25/USH.nvim)

**✅ `fd`, `rg` などの外部ツール要件や、`telescope` `neo-tree` などの推奨UIプラグインの完全なリストは、[Wikiのインストールページ](https://github.com/taku25/UnrealDev.nvim/wiki/Installation_ja) を参照してください。**

## 🚀 Installation

[lazy.nvim](https://github.com/folke/lazy.nvim) でのインストール例です。
`UnrealDev.nvim` が他のすべてのスイートプラグインに依存するように定義します。

```lua
return {
  {
    'taku25/UnrealDev.nvim',
    -- 開発スイートの全プラグインを依存関係に指定
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
        'taku25/USX.nvim', -- Color highlight
        lazy=false,
      }
      
      -- UI Plugins (Optional)
      'nvim-telescope/telescope.nvim',
      'j-hui/fidget.nvim',
      'nvim-lualine/lualine.nvim',
      -- ...
    },
    opts = {
      -- UnrealDev.nvim 固有の設定 (主にロギング)
    },
  },

  -- ---
  -- 各プラグインの個別設定 (Optional)
  -- ---
  { 'taku25/UBT.nvim', opts = { ... } },
  { 'taku25/UEP.nvim', opts = { ... } },
  -- ...
}
```

**✅ UIプラグインを含む完全なインストール例や、各プラグイン (`UEP`, `UBT` 等) への詳細な `opts` 設定例は、[Wikiのインストールガイド](https://github.com/taku25/UnrealDev.nvim/wiki/Installation_ja) を参照してください。**

## ⚙️ Configuration

`UnrealDev.nvim` 自体の設定は、上記の `opts` テーブルに示すような `logging` など最小限です。

スイートに含まれる各プラグイン（`UEP`、`UBT` など）の設定は、`lazy.nvim` で各プラグインのスペックに `opts` を渡すことで行います（上記インストール例参照）。

**✅ 各プラグインの設定詳細については、[WikiのConfigurationページ](https://github.com/taku25/UnrealDev.nvim/wiki/Configuration_ja) または各プラグインの `README` を参照してください。**

## ⚡ Usage

すべてのコマンドは `:UDEV` から始まります。

```viml
" ===== (使用例) ===== "

" プロジェクトを再スキャン
:UDEV refresh

" ファイルを検索
:UDEV files

" ターゲットをビルド
:UDEV build

" 新しいクラスを作成
:UDEV new MyNewActor AActor

" ヘッダー/ソースを切り替え
:UDEV switch

" ログの追跡を開始
:UDEV start_log
```

**✅ `UDEV` の全サブコマンド、引数、およびコマンド名の競合（例: `:UDEV class_delete`）に関する詳細は、[Wikiのコマンドリファレンス](https://github.com/taku25/UnrealDev.nvim/wiki/Command_ja) を参照してください。**

## 🤖 API & Automation Examples

`UnrealDev.api` モジュールを通じて、すべての機能にプログラムからアクセスできます。

```lua
-- (例) UCMの 'switch' をキーマップ
vim.keymap.set('n', '<leader>oo', function()
  require('UnrealDev.api').switch_file({ current_file_path = vim.api.nvim_buf_get_name(0) })
end, { noremap = true, silent = true, desc = "UDEV: Switch H/S file" })

-- (例) UEPの 'files' をキーマップ
vim.keymap.set('n', '<leader>pf', function()
  require('UnrealDev.api').files({})
end, { desc = "UDEV: Find project files" })
```


## Others

Unreal Engine 関連プラグイン:

  * [UEP.nvim](https://github.com/taku25/UEP.nvim)
      * .uproject を解析し、ファイル移動を簡便にします。
  * [UBT.nvim](https://github.com/taku25/UBT.nvim)
      * Neovim から非同期に Build, GenerateClangDataBase などを使用します。
  * [UCM.nvim](https://github.com/taku25/UCM.nvim)
      * Neovim からクラスの追加、削除を行います。
  * [ULG.nvim](https://github.com/taku25/ULG.nvim)
      * Neovim から UE のログ、LiveCoding、stat fps などを見ます。
  * [USH.nvim](https://github.com/taku25/USH.nvim)
      * Neovim から ushell を操作します。
  * [USX.nvim](https://github.com/taku25/USX.nvim)
      * tree-sitter-unreal-cpp, tree-sitter-unreal-shader のハイライト設定プラグイン
  * [neo-tree-unl](https://github.com/taku25/neo-tree-unl.nvim)
      * IDE ライクなプロジェクトエクスプローラーを表示します。
  * [tree-sitter for Unreal Engine](https://github.com/taku25/tree-sitter-unreal-cpp)
      * UCLASS などを含む tree-sitter を利用したシンタックスハイライトを提供します。
  * [tree-sitter for Unreal Engine Shader](https://github.com/taku25/tree-sitter-unreal-shader)
      * usf, ushなどのUnreal Shaderのシンタックスハイライトを提供します

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
