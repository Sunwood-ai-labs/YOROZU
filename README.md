<div align="center">

![Antigravity Agent](assets/header.png)

# YOROZU
### ～Your Own Repository Organization Zero-gravity Utility～

![Status](https://img.shields.io/badge/Status-Active-success)
![Agent](https://img.shields.io/badge/Agent-Google%20Antigravity-blue)
![Platform](https://img.shields.io/badge/Platform-Windows-0078D6)

**Google Antigravity エージェントを使用して `GAS_PROJECT` 配下のリポジトリ作成・管理を自動化するためのドキュメント**

</div>

## 📚 目次

- [概要](#-概要)
- [利用可能なワークフロー](#-利用可能なワークフロー)
  - [1. 既存フォルダをリポジトリ化する](#1-既存フォルダをリポジトリ化する)
  - [2. プロンプト管理用リポジトリを作成する](#2-プロンプト管理用リポジトリを作成する)
  - [3. リポジトリ品質レビュー](#3-リポジトリ品質レビュー)
  - [4. ヘッダー画像生成](#4-ヘッダー画像生成)
- [生成されるファイル構成](#-生成されるファイル構成)
- [設定ファイル（上級者向け）](#-設定ファイル上級者向け)

---

## 🌟 概要

エージェントには以下のルールとワークフローが設定されており、自然言語での指示に基づいてGitリポジトリの作成やフォルダのGit化を自動的に行います。

> [!NOTE]
> **主な機能**
> - **保存場所**: すべての新しいリポジトリは `GAS_PROJECT/` フォルダの直下に作成されます。
> - **命名規則**: リポジトリ名は `kebab-case`（例: `my-project-name`）が推奨され、エージェントが自動的に修正・提案します。
> - **Git設定**: `.gitignore` の作成や GitHub へのプッシュまでをサポートします。

---

## 🚀 利用可能なワークフロー

### 1. 既存フォルダをリポジトリ化する

すでに作業中のフォルダがあり、それをGitリポジトリとして `GAS_PROJECT` 配下で管理したい場合に使用します。

> [!TIP]
> **指示の例**
> - 「このフォルダをリポジトリにして」
> - 「今開いているフォルダをGit管理下に置いて」
> - 「OOOにあるフォルダのリポジトリを整備して」

#### 🤖 エージェントの動作
1. フォルダが `GAS_PROJECT` 外にある場合、移動や警告を行います。
2. フォルダ内のコンテンツを分析し、最適なリポジトリ名を提案します。
3. `git init`、`.gitignore` 作成、コミット、`gh repo create` によるGitHubリポジトリ作成を一貫して行います。

### 2. プロンプト管理用リポジトリを作成する

AIプロンプトを管理するための専用構成（フォルダ構造）を持つリポジトリを新規作成します。

> [!TIP]
> **指示の例**
> - 「プロンプトを管理するリポジトリを作成して」
> - 「新しいプロンプトリポジトリを作って」

#### 🤖 エージェントの動作
1. `GAS_PROJECT/prompt-management` （または指定名）フォルダを作成します。
2. `prompts/` フォルダや `templates/`、`README.md` などを自動生成します。
3. Gitの初期化とGitHubへのプッシュを行います。

### 3. リポジトリ品質レビュー

作成されたリポジトリが基準を満たしているかチェックします。

> [!TIP]
> **指示の例**
> - 「このリポジトリの品質をチェックして」
> - 「レビューして」

### 4. ヘッダー画像生成

README用の高品質なヘッダー画像（エレガントなフォント）を作成します。リリースノート等にも利用可能です。

> [!TIP]
> **指示の例**
> - 「このリポジトリのヘッダー画像を作って」

---

## 📂 生成されるファイル構成

```text
d:/Prj/GAG_Workspace/
└── GAS_PROJECT/           <-- すべてのリポジトリのルート
    ├── my-cool-project/   <-- 各プロジェクトのリポジトリ
    │   ├── .git/
    │   ├── .gitignore
    │   └── ...
    └── prompt-repo/
        ├── prompts/
        └── templates/
```

---

## 🔧 設定ファイル（上級者向け）

動作をカスタマイズしたい場合は、以下のファイルを編集してください。

- **ルール**: `.agent/rules/repo-creation.md`
- **ワークフロー**:
    - `.agent/workflows/create-repo-from-folder.md`
    - `.agent/workflows/create-prompt-repo.md`
    - `.agent/workflows/review-repo-quality.md`
    - `.agent/workflows/generate-header-image.md`
    - `.agent/workflows/create-release.md`
    - `.agent/workflows/git-auto-commit.md`
    - `.agent/workflows/create-yorozu-project-complete.md` (Master Workflow)

