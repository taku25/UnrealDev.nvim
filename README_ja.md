# UnrealDev.nvim

# Unreal Engine Development Sweet 💓 Neovim

<img width="2048" height="1342" alt="screenshot-20251122-191958" src="https://github.com/user-attachments/assets/4b26c5e7-461b-4e78-953b-9b2d6d24988e" />


`UnrealDev.nvim` は、 **Unreal Neovim Plugin Sweet** スイート（`UEP`, `UBT`, `UCM`, `ULG`, `USH`, `UEA`, `UNX`, `UDB`）の機能を、単一のグローバルコマンド `:UDEV` に統合する薄いラッパープラグインです。

各プラグインのセットアップを簡素化し、Unreal Engine関連のすべての操作を単一のインターフェースから呼び出せるようにすることを目的としています。

[English](README.md) | [日本語 (Japanese)](README_ja.md)

![GitHub stars](https://img.shields.io/github/stars/taku25/UnrealDev.nvim)
[![Qiita](https://img.shields.io/badge/Qiita-Weekly%20Updates-55c500?style=flat&logo=qiita)](https://qiita.com/taku25)
[![Dev.to](https://img.shields.io/badge/dev.to-Weekly%20Updates-0A0A0A?style=flat&logo=dev.to)](https://dev.to/taku25)

-----

# 一部機能の紹介

<table>
  <tr>
   <td>
    <div align=center>
      <img width="100%" alt="image" src="https://github.com/user-attachments/assets/4cc958a0-515e-4b4d-bfdc-a2b5fde27146" />
      UDEV refresh
    </div>
  </td>
   <td>
    <div align=center>
      <img width="100%" alt="image" src="https://github.com/user-attachments/assets/30596bc6-a2a3-4805-a84e-1d28350da207" />
      UDEV gencompiledb
    </div>
    </td>
  </tr>
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
      symbols
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
  * **[➡️ 📖 使い方ガイド (Usage Guide)](https://github.com/taku25/UnrealDev.nvim/wiki/UsageGuide_ja)**
    
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
  * **Rust** (UNL.nvimのスキャナをビルドするために必要です)
  * [**UNL.nvim**](https://github.com/taku25/UNL.nvim) (**必須コアライブラリ**)
  * **推奨スイートプラグイン:** (これらのうち、必要なものをインストールします)
      * [**UEP.nvim**](https://github.com/taku25/UEP.nvim) (プロジェクト探索)
      * [**UEA.nvim**](https://github.com/taku25/UEA.nvim) (アセット(BP)検索)
      * [**UBT.nvim**](https://github.com/taku25/UBT.nvim) (ビルドツール)
      * [**UCM.nvim**](https://github.com/taku25/UCM.nvim) (クラス管理)
      * [**ULG.nvim**](https://github.com/taku25/ULG.nvim) (ログ閲覧)
      * [**USH.nvim**](https://github.com/taku25/USH.nvim) (Unreal シェル)
      * [**UNX.nvim**](https://github.com/taku25/UNX.nvim) (ロジカルビュー)
      * [**UDB.nvim**](https://github.com/taku25/UDB.nvim) (デバッグ)
      * [**blink-cmp-unreal**](https://github.com/taku25/blink-cmp-unreal) (補完)

**✅ `fd`, `rg` などの外部ツール要件や、`telescope` `neo-tree` などの推奨UIプラグインの完全なリストは、[Wikiのインストールページ](https://github.com/taku25/UnrealDev.nvim/wiki/Installation_ja) を参照してください。**

## 🚀 Installation

[lazy.nvim](https://github.com/folke/lazy.nvim) でのインストール例です。
`UnrealDev.nvim` と、あなたが使いたいスイートプラグインを（依存関係としてではなく）並列にリストアップします。

```lua
return {
  {
    'taku25/UnrealDev.nvim',
    -- Define all plugins in the development suite.
    -- You can remove any plugins you don't use.
    dependencies = {
      {
        'taku25/UNL.nvim', -- Core Library
        build = "cargo build --release --manifest-path scanner/Cargo.toml",
        lazy = false,
      },
      'taku25/UEP.nvim', -- Project Explorer
      'taku25/UEA.nvim', -- Asset (Blueprint) Inspector
      'taku25/UBT.nvim', -- Build Tool
      'taku25/UCM.nvim', -- Class Manager
      'taku25/ULG.nvim', -- Log Viewer
      'taku25/USH.nvim', -- Unreal Shell
      {
        'taku25/UNX.nvim', -- Logical View 
        dependencies = {
          "MunifTanjim/nui.nvim",
          "nvim-tree/nvim-web-devicons",
        },
      },
      'taku25/UDB.nvim', -- Debug
      {
        'taku25/USX.nvim', -- Syntax highlight
        lazy=false,
      },
      
      -- UI Plugins (Optional)
      'nvim-telescope/telescope.nvim',
      'j-hui/fidget.nvim',
      'nvim-lualine/lualine.nvim',
      { 
          'nvim-treesitter/nvim-treesitter',
           branch = "main",
           config = function(_, opts)
             vim.api.nvim_create_autocmd('User', { pattern = 'TSUpdate',
               callback = function()
                 local parsers = require('nvim-treesitter.parsers')
                 parsers.cpp = {
                   install_info = {
                     url  = 'https://github.com/taku25/tree-sitter-unreal-cpp',
                     revision  = '67198f1b35e052c6dbd587492ad53168d18a19a8',
                   },
                 }
                 parsers.ushader = {
                   install_info = {
                     url  = 'https://github.com/taku25/tree-sitter-unreal-shader',
                     revision  = '26f0617475bb5d5accb4d55bd4cc5facbca81bbd',
                   },
                 }
              end
            })
            local langs = { "c", "cpp", "ushader","json"  }
            require("nvim-treesitter").install(langs)
            local group = vim.api.nvim_create_augroup('MyTreesitter', { clear = true })
            vim.api.nvim_create_autocmd('FileType', {
               group = group,
               pattern = langs,
               callback = function(args)
                  vim.treesitter.start(args.buf)
                  vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
               end,
            })
         end
       }
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
  --{ 'taku25/UBT.nvim', opts = { ... } },
  --{ 'taku25/UEP.nvim', opts = { ... } },
  --{ 'taku25/UEA.nvim', opts = { ... } },
  -- ...
}
````

**✅ UIプラグインを含む完全なインストール例や、各プラグイン (`UEP`, `UBT` 等) への詳細な `opts` 設定例は、[Wikiのインストールガイド](https://github.com/taku25/UnrealDev.nvim/wiki/Installation_ja) を参照してください。**


## ✅ インストールの確認 (Verify Installation)

インストール後、以下のコマンドを実行して、依存プラグイン、外部ツール（fd, rg）、およびカスタムTree-sitterパーサーが正しく設定されているか確認してください。

```vim
:checkhealth UnrealDev
````

もし **Error** や **Warning** が表示された場合は、出力されるアドバイスに従って修正してください。
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

## その他

Unreal Engine 関連プラグイン:

  * [**UnrealDev.nvim**](https://github.com/taku25/UnrealDev.nvim)
      * **推奨:** これら全てのUnreal Engine関連プラグインを一括で導入・管理できるオールインワンスイートです。
  * [**UNX.nvim**](https://github.com/taku25/UNX.nvim)
      * **標準搭載:** Unreal Engine開発に特化した専用のエクスプローラー＆サイドバーです。Neo-tree等に依存せず、プロジェクト構造、クラス概形、プロファイリング結果などを表示できます。
  * [UEP.nvim](https://github.com/taku25/UEP.nvim)
      * .uprojectを解析してファイルナビゲートなどを簡単に行えるようになります。
  * [UEA.nvim](https://github.com/taku25/UEA.nvim)
      * C++クラスがどのBlueprintアセットから使用されているかを検索します。
  * [UBT.nvim](https://github.com/taku25/UBT.nvim)
      * BuildやGenerateClangDataBaseなどを非同期でNeovim上から使えるようになります。
  * [UCM.nvim](https://github.com/taku25/UCM.nvim)
      * クラスの追加や削除がNeovim上からできるようになります。
  * [ULG.nvim](https://github.com/taku25/ULG.nvim)
      * UEのログやLiveCoding, stat fpsなどをNeovim上から操作できるようになります。
  * [USH.nvim](https://github.com/taku25/USH.nvim)
      * ushellをNeovimから対話的に操作できるようになります。
  * [USX.nvim](https://github.com/taku25/USX.nvim)
      * tree-sitter-unreal-cpp や tree-sitter-unreal-shader のハイライト設定などを補助するプラグインです。
  * [tree-sitter for Unreal Engine](https://github.com/taku25/tree-sitter-unreal-cpp)
      * UCLASSなどを含めてtree-sitterの構文木を使ってハイライトができます。
  * [tree-sitter for Unreal Engine Shader](https://github.com/taku25/tree-sitter-unreal-shader)
      * .usfや.ushなどのUnreal Shader用のシンタックスハイライトを提供します。
  * [blink-cmp-unreal](https://github.com/taku25/blink-cmp-unreal)
      * blink-cmp用の補完ソースです。UEP.nvimのデータベースとtree-sitterを使用して、Unreal Engine C++のインテリジェントな補完を提供します。

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
