---
description: Semantic Versioningに基づくリリース作成と、バージョン入りヘッダー画像の生成を自動化します
---
# 🚀 リリース作成ワークフロー

このワークフローは、`main` ブランチの最新状態からGitHubリリースを作成します。バージョン判定、リリースノート生成、および専用ヘッダー画像の作成を自動化します。

## Step 1: 🌿 準備と確認 // turbo
1. **ブランチ確認**: `main` ブランチにチェックアウトし、`git pull` で最新化します。
2. **既存タグ確認**: `git tag` または `gh release list` で最新のバージョンを確認します。

## Step 2: 🏷️ バージョン決定
- **ユーザー指定**: ユーザーが明示的にバージョンを指定した場合（例: `v1.0.0`）、それを採用します。
- **自動判定**: 指定がない場合、前回のタグからの変更内容（コミットメッセージの `feat`, `fix`, `BREAKING CHANGE` 等）に基づいてSemantic Versioningで決定します。
  - 初回リリースやAlpha段階の場合、ユーザーに確認しつつ推奨値（例: `v0.1.0-alpha`）を提案します。
  - **現状**: このリポジトリは **Alphaテスト中** です。プレレリースタグ（`-alpha`）の付与を推奨します。

## Step 3: 🎨 リリース用ヘッダー画像生成
- `assets/header_prompt.txt` の内容をベースに、**リポジトリ名とバージョン番号** を含む画像を生成します。
- **プロンプト構築**:
  - ベース: `assets/header_prompt.txt` (Miyabi style)
  - 追加指示: "Include text '[RepoName] [Version]' elegantly..."
  - **重要**: "NO Kanji" ルールを維持します。
- **生成と保存**:
  - ツール: `generate_image`, `scripts/crop_header.ps1`
  - 保存先: `assets/release_header_[version].png`

## Step 4: 📝 洗練されたリリースノートの生成 // turbo
- 単なるログ出力ではなく、以下の手順で高品質なリリースノートを作成します。
1. **差分分析**: 前回のタグから現在のHEADまでの差分（`git diff`, `git log`）を取得します。
2. **ノート執筆**: 以下の構成でマークダウンを作成し、`release_notes.md` に保存します。
   - **ヘッダー画像**: Step 3で作成した画像を最上部に配置（`![Header](url)`）。
   - **構成ルール**:
     - **見出し（Headings）は英語**（Overview, Key Features, Code Improvements, etc.）。
     - **本文は日本語**。
     - **内容**: コミットログだけでなく、実際のコード差分を分析して技術的な「品質と内容の向上」をアピールします。
   - **構成例**:
     ```markdown
     ![Release Header]([画像URL])

     ## Overview
     （日本語で概要を記述）

     ## Key Features
     - **[機能名]**: （コードレベルの解説を含む日本語説明）

     ## Code Improvements
     - （リファクタリングやパフォーマンス改善点）
     ```

## Step 5: 🚀 リリース作成 // turbo
- `gh release create` コマンドを使用してリリースを作成します。
  - **タグ**: Step 2で決定したタグ。
  - **ノート**: `-F release_notes.md` オプションで作成したノートを指定します。
  - **アセット**: Step 3で生成したヘッダー画像を添付します。
  - **オプション**: `--title "[タグ名]"`、Alpha/Betaの場合は `--prerelease`。

  ```bash
  # 例
  gh release create v0.1.0-alpha \
    --title "v0.1.0-alpha" \
    -F release_notes.md \
    --prerelease \
    assets/release_header_v0.1.0-alpha.png
  ```

## Step 6: 📢 完了通知 // turbo
- リリースが作成されたURLをユーザーに通知します。
