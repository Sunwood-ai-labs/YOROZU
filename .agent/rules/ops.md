---
slug: operational-rules
description: 標準的な運用コマンドと手順を定義します。
trigger: model_decision
---
# 運用基準

## ビルドとテスト
- **ビルドコマンド**: `pnpm run build` (または、pnpmが利用できない環境では `npm run build`)
- **テストコマンド**: 
  - `node --test` (ネイティブNode.jsテストランナー) または 
  - `npm test`
- **インストールコマンド**: `pnpm install`

## バージョン管理
- **コミット**: 意味のあるメッセージを使用してください（説明は日本語を推奨）。
- **ブランチ戦略**: Git Flowに従ってください (develop, feature/xxx, main)。
