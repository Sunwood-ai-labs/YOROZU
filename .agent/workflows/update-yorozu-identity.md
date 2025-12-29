---
description: リポジトリを「YOROZU」ブランド（雅・和風）に更新し、READMEレイアウトを整備します
---
# 🌸 YOROZU Identity Update

このワークフローは、リポジトリのIdentityを「YOROZU」スタイル（雅な和風デザイン）に統一し、READMEのレイアウトを標準化します。

## Step 1: 🎨 ヘッダー画像生成 (Miyabi) // turbo
- `/generate-header-image` ワークフローを呼び出すか、同等の手順を実行します。
  - **スタイル**: Japanese Miyabi (Gold, Indigo, Wagara).
  - **テキスト**: プロンプトに **「そのリポジトリの名前（英語表記）」** を含めます（漢字禁止）。
  - 保存先: `assets/header.png` (16:9)

## Step 2: 📝 README更新
- `README.md` を編集して以下の構成にします：
  1. **ヘッダー画像**: 最上部に配置。
  2. **タイトル**: そのリポジトリの正式名称（`# Title`）。**「YOROZU」には書き換えないでください**。
  3. **サブタイトル**: そのリポジトリに適したサブタイトルまた説明。**既存のものを維持してください**。
  4. **バッジ**: `release_notes_template.md` (`.agent\templates\release_notes_template.md`) を参考に、**最適なバッジ**（Version, License, PRs, **Tech Stack** etc.）を配置してください。
     - バッジのデザインや並び順はテンプレートに合わせてください。
     - **技術スタック**（言語、フレームワーク等）のバッジも適切に追加してください。
  5. **YOROZU Note**: 以下のAlertを概要の直後または末尾に追加します。
     ```markdown
     > [!NOTE]
     > このリポジトリはYOROZUで作成されました
     > https://github.com/Sunwood-ai-labs/YOROZU
     ```

## Step 3: ✅ 検証
- 生成された画像が「雅」であり、テキストが正しく含まれているか確認します。
- READMEのプレビューを確認し、レイアウトが崩れていないかチェックします。
