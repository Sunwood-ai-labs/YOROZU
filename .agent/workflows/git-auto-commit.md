---
description: git statusとdiffを解析し、適切なブランチ作成・日本語での粒度の細かいコミット・マージを自動化します
---
# 🤖 Git 自動コミットワークフロー (V4.2 Lite)

このワークフローは、[Sunwood-ai-labs MysticLibrary](https://github.com/Sunwood-ai-labs/MysticLibrary) のコミット戦略に基づき、変更内容を解析して適切な粒度でコミットを行います。

## Step 1: 🔍 状態確認 // turbo
- 以下のコマンドを実行して、現在の変更状態を確認してください。
  ```bash
  git status
  git --no-pager diff --stat
  ```

## Step 2: 🌿 develop ブランチの準備 // turbo
1. `develop` ブランチが存在するか確認します。
2. 存在しない場合は作成し、プッシュします。
3. 存在する場合はチェックアウトし、`git pull origin develop` で最新化します。

## Step 3: 🌿 作業用ブランチの作成 // turbo
- 変更内容に基づき、適切な英語のブランチ名を提案・作成します。
  - 命名規則: `feature/[機能名]-[日付]`
  - 例: `feature/update-readme-alerts-20251227`
  - **Issue番号は含めないでください**。

## Step 4: 💻 粒度の細かいコミット
- `git diff` の内容を分析し、**作業の単位ごとに細かく分割してコミット**します。
- **コミットメッセージのルール**:
  - **Type（型）**: 以下のリストから適切なものを選んでください。
    - `feat`: 新機能
    - `fix`: バグ修正
    - `docs`: ドキュメントの変更
    - `style`: コードスタイルの変更（動作に影響しない）
    - `refactor`: リファクタリング
    - `perf`: パフォーマンス改善
    - `test`: テストの追加・修正
    - `chore`: ビルドプロセスやツールの変更
  - **日本語**で記述すること。
  - **絵文字**をプレフィックスとして付与すること。
  - **3行程度の箇条書き**で詳細を含めること。
  - コマンド例:
    ```bash
    git add [ファイルA]
    git commit -m "✨ feat: [機能] 日本語の要約" -m "- 詳細な変更点1" -m "- 詳細な変更点2"
    ```

## Step 5: 🔍 コミット確認 // turbo
- 全ての変更がコミットされたか確認します。
  ```bash
  git status
  ```

## Step 6: 🔄 develop へのマージ // turbo
1. `develop` ブランチに切り替えます。
2. `--no-ff` オプションを付けてマージします。
   ```bash
   git merge --no-ff feature/[ブランチ名] -m "🔀 Merge: [タスク概要]"
   ```
3. リモートへプッシュします。

## Step 7: 🗑️ 作業ブランチの削除 // turbo
- マージ済みの作業ブランチを削除します。
  ```bash
  git branch -d feature/[ブランチ名]
  ```
