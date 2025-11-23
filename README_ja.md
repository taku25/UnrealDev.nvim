# UnrealDev.nvim

# Unreal Engine Development Sweet 💓 Neovim

<img width="2048" height="1342" alt="screenshot-20251122-191958" src="https://github.com/user-attachments/assets/4b26c5e7-461b-4e78-953b-9b2d6d24988e" />


`UnrealDev.nvim` は、 **Unreal Neovim Plugin Sweet** スイート（`UEP`, `UBT`, `UCM`, `ULG`, `USH`, `UEA`）の機能を、単一のグローバルコマンド `:UDEV` に統合する薄いラッパープラグインです。

各プラグインのセットアップを簡素化し、Unreal Engine関連のすべての操作を単一のインターフェースから呼び出せるようにすることを目的としています。

[English](README.md) | [日本語 (Japanese)](README_ja.md)

-----

# 一部機能の紹介

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

他にも様々な機能があります

-----

## 📚 詳細ドキュメント (Wiki)

**詳しいインストール方法、設定、コマンド一覧、APIの使用例は、すべて [GitHub Wiki](https://github.com/taku25/UnrealDev.nvim/wiki) にまとめてあります。**

セットアップやカスタマイズの際は、まずこちらをご覧ください。

  * **[➡️ 🚀 インストールと設定 (Installation & Setup)](https://github.com/taku25/UnrealDev.nvim/wiki/Installation_ja)**
  * **[➡️ ⚙️ オプション詳細 (Configuration)](https://github.com/taku25/UnrealDev.nvim/wiki/Configuration_ja)**

-----

## ✨ Features

  * **統一されたコマンドインターフェース**:
      * 検出されたスイートの全プラグイン機能（プロジェクト探索、ビルド、クラス管理、ログ閲覧、シェル操作、アセット検索）を `:UDEV` コマンドから呼び出せます。
  * **機能の自動検出**:
      * インストール済みのスイートプラグイン（`UEP`, `UBT`, `UCM`, `ULG`, `USH`, `UEA`）を`pcall`経由で自動検出し、利用可能なコマンドのみを提供します。
  * **統一されたAPI**:
      * `require('UnrealDev.api')` を介して利用可能なすべてのスイートプラグインAPI関数にアクセスでき、キーマップや自動化の作成が容易になります。

## 🔧 Requirements

  * Neovim v0.11.3 or later
  * [**UNL.nvim**](https://github.com/taku25/UNL.nvim) (**必須コアライブラリ**)
  * **推奨スイートプラグイン:** (これらのうち、必要なものをインストールします)
      * [**UEP.nvim**](https://github.com/taku25/UEP.nvim) (プロジェクト探索)
      * [**UEA.nvim**](https://github.com/taku25/UEA.nvim) (アセット(BP)検索)
      * [**UBT.nvim**](https://github.com/taku25/UBT.nvim) (ビルドツール)
      * [**UCM.nvim**](https://github.com/taku25/UCM.nvim) (クラス管理)
      * [**ULG.nvim**](https://github.com/taku25/ULG.nvim) (ログ閲覧)
      * [**USH.nvim**](https://github.com/taku25/USH.nvim) (Unreal シェル)
      * [**UNX.nvim**](https://github.com/taku25/UNX.nvim) (ロジカルビュー)

**✅ `fd`, `rg` などの外部ツール要件や、`telescope` `neo-tree` などの推奨UIプラグインの完全なリストは、[Wikiのインストールページ](https://github.com/taku25/UnrealDev.nvim/wiki/Installation_ja) を参照してください。**

## 🚀 Installation

[lazy.nvim](https://github.com/folke/lazy.nvim) でのインストール例です。
`UnrealDev.nvim` と、あなたが使いたいスイートプラグインを（依存関係としてではなく）並列にリストアップします。

```lua
return {
  {
    'taku25/UnrealDev.nvim',
    -- 開発スイートの全プラグインを依存関係に指定
    -- (UnrealDevが自動検出するため、実際には 'dependencies' でなくても動作します)
    -- (ただし、依存関係として定義するのが 'lazy.nvim' の慣習として分かりやすいでしょう)
    dependencies = {
      {
        'taku25/UNL.nvim', -- コアライブラリ
        lazy = false,
      },
      'taku25/UEP.nvim', -- プロジェクト探索
      'taku25/UEA.nvim', -- アセット(BP)検索
      'taku25/UBT.nvim', -- ビルドツール
      'taku25/UCM.nvim', -- クラス管理
      'taku25/ULG.nvim', -- ログ閲覧
      'taku25/USH.nvim', -- Unreal シェル
      'taku25/UNX.nvim', -- ロジカルビュー
      {
        'taku25/USX.nvim', -- カラーハイライト
        lazy=false,
      },
      
      -- UI Plugins (Optional)
      'nvim-telescope/telescope.nvim',
      'j-hui/fidget.nvim',
      'nvim-lualine/lualine.nvim',
      -- ...
    },
    opts = {
      -- UnrealDev.nvim 固有の設定
      -- (例: インストールしていないプラグインのセットアップを無効化)
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
  -- 各プラグインの個別設定 (Optional)
  -- ---
  { 'taku25/UBT.nvim', opts = { ... } },
  { 'taku25/UEP.nvim', opts = { ... } },
  { 'taku25/UEA.nvim', opts = { ... } },
  -- ...
}
````

**✅ UIプラグインを含む完全なインストール例や、各プラグイン (`UEP`, `UBT` 等) への詳細な `opts` 設定例は、[Wikiのインストールガイド](https://github.com/taku25/UnrealDev.nvim/wiki/Installation_ja) を参照してください。**

## ⚙️ Configuration

`UnrealDev.nvim` 自体の設定は、上記の `setup_modules` テーブルのような最小限のものです。

スイートに含まれる各プラグイン（`UEP`、`UBT` など）の設定は、`lazy.nvim` で各プラグインのスペックに `opts` を渡すことで行います（上記インストール例参照）。

**✅ 各プラグインの設定詳細については、[WikiのConfigurationページ](https://github.com/taku25/UnrealDev.nvim/wiki/Configuration_ja) または各プラグインの `README` を参照してください。**

## ⚡ Usage

すべてのコマンドは `:UDEV` から始まります。
インストールされているプラグインのコマンドのみが利用可能です。

```viml
" ===== (使用例) ===== "

" プロジェクトを再スキャン (UEPより)
:UDEV refresh

" ファイルを検索 (UEPより)
:UDEV files

" ターゲットをビルド (UBTより)
:UDEV build

" 新しいクラスを作成 (UCMより)
:UDEV new MyNewActor AActor

" ヘッダー/ソースを切り替え (UCMより)
:UDEV switch

" ログの追跡を開始 (ULGより)
:UDEV start_log

" Blueprintの使用箇所を検索 (UEAより)
:UDEV find_bp_usages
```

**✅ `UDEV` の全サブコマンド、引数、およびコマンド名の競合（例: `:UDEV class_delete`）に関する詳細は、[Wikiのコマンドリファレンス](https://github.com/taku25/UnrealDev.nvim/wiki/Command_ja) を参照してください。**

## 🤖 API & Automation Examples

`UnrealDev.api` モジュールを通じて、すべての（利用可能な）機能にプログラムからアクセスできます。
プラグインがインストールされていない場合、対応するAPI関数は `nil` になります。

```lua
-- (例) UCMの 'switch' をキーマップ (安全なnilチェック)
vim.keymap.set('n', '<leader>oo', function()
  local api = require('UnrealDev.api')
  if api.switch_file then
    api.switch_file({ current_file_path = vim.api.nvim_buf_get_name(0) })
  end
end, { noremap = true, silent = true, desc = "UDEV: H/S ファイル切り替え" })

-- (例) UEPの 'files' をキーマップ (安全なnilチェック)
vim.keymap.set('n', '<leader>pf', function()
  local api = require('UnrealDev.api')
  if api.files then
    api.files({})
  end
end, { desc = "UDEV: プロジェクトファイル検索" })
```

## Others

Unreal Engine 関連プラグイン:

  * [UEP.nvim](https://github.com/taku25/UEP.nvim)
      * .uproject を解析し、ファイル移動を簡便にします。
  * [UEA.nvim](https://www.google.com/url?sa=E&source=gmail&q=https://github.com/taku25/UEA.nvim)
      * C++クラスがどのBlueprintアセットから使用されているかを検索します。
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
