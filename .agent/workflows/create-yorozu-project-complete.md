---
description: ユーザー指定のリポジトリを作成し、YOROZUブランド化、コミット、リリース作成までを一気通貫で行います
---
# 🚀 YOROZU プロジェクト完全作成ワークフロー

このワークフローは、既存のワークフロー（リポジトリ作成、ブランド化、コミット、リリース）を統合し、ゼロからリリース済みリポジトリを作成するためのマスターワークフローです。

## Step 1: 📂 リポジトリの準備と初期化 // turbo
1. **フォルダ作成**: 指定されたプロジェクト名のフォルダがなければ作成し、移動します。
2. **リポジトリ化**: `/create-repo-from-folder` を実行します。
   - **Privacy**: Privateリポジトリとして作成します。
   - **Branch**: `main` ブランチを作成します。

## Step 2: 🏗️ アプリケーションの実装
- `/build-app-simple` を実行します。
  - ユーザーの要件（作成したいアプリの内容）に基づいて、HTML/CSS/JSで実装を行います。
  - **重要**: YOROZU Identityを適用する前に、まずアプリ自体の機能を完成させます。

## Step 3: 🌸 YOROZU Identityの適用 // turbo
- `/update-yorozu-identity` を実行します。
  1. **ヘッダー生成**: 「リポジトリ名」を含んだMiyabiスタイルのヘッダー画像を作成します。
  2. **README更新**: ヘッダー画像を最上部に配置し、GitHub Alertsを追加します。

## Step 4: 💾 変更のコミット // turbo
- `/git-auto-commit` の戦略に基づき、Identity適用の変更をコミットします。
  - **Type**: `style` または `docs`
  - **メッセージ**: "✨ style: Apply YOROZU identity and documentation"

  ```bash
  git add .
  ```
  ```bash
  git commit -m "✨ style: YOROZUブランド（ヘッダー・README）を適用" -m "- Miyabiスタイルヘッダー画像の生成" -m "- READMEレイアウトの標準化とAlerts導入"
  ```
  ```bash
  git push origin main
  ```

## Step 5: 🚀 初回リリースの作成 // turbo
- `/create-release` を実行します。
  - **バージョン**: Alphaテスト中であるため、`v0.1.0-alpha` を指定します。
  - **リリースノート**: 差分分析に基づき、自動生成されたリッチなノートを使用します。
  - **ヘッダー画像**: バージョン入りの専用リリースヘッダーを生成して添付します。

## 完了
- 作成されたリポジトリとリリースのURLをユーザーに通知します。
