---
description: Semantic Versioningに基づくリリース作成と、バージョン入りヘッダー画像の生成を自動化します
---

# 🚀 リリース作成ワークフロー

このワークフローは、`main` ブランチの最新状態からGitHubリリースを作成します。バージョン判定、リリースノート生成、および専用ヘッダー画像の作成を自動化します。

## Step 1: 🌿 準備と確認 // turbo
以下のコマンドを順に実行します。**コマンドはセミコロンで連結せず、必ず1つずつ実行してください。**

1. ブランチの切り替え
   ```bash
   git checkout main
   ```
2. 最新コードの取得
   ```bash
   git pull
   ```
3. 最新タグの確認
   ```bash
   git describe --tags --abbrev=0
   ```
4. ステータスの確認
   ```bash
   git status
   ```

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

## Step 4: 📝 洗練されたリリースノートの生成  // turbo

### 4.1 情報収集
```bash
# 変更ファイル一覧
git diff --stat [前タグ]..HEAD

# コミットログ（種別付き）
git log --oneline --pretty=format:"%s (%h)" [前タグ]..HEAD

# 貢献者一覧
git log --format='%an' [前タグ]..HEAD | sort -u
```

### 4.2 テンプレート適用
- `templates/release_notes_template.md` をベースに生成
- 各セクションをコミット分析結果で埋める
- Breaking Changesがある場合はマイグレーションガイドを必須で含める

### 4.3 品質チェック
- [ ] Overview が3文以内で要点を伝えているか
- [ ] 各変更にPR/Issueリンクがあるか
- [ ] コード例が動作するか
- [ ] 画像/GIFが適切に表示されるか

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