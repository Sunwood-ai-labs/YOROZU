---
description: 指定されたレガシーモジュールを体系的にクリーンアップする。
---
# Refactor Legacy Code

## Identify Scope
指定されたファイルを読み込み、密結合している依存関係を特定せよ。

## Plan
依存性注入（Dependency Injection）などのデカップリング戦略を提案せよ。

## Execute
インターフェースを抽出せよ。
ロジックをサービスクラスに移動せよ。
元のファイルが新しいサービスを使用するように更新せよ。

## Verify // turbo
npm test を実行し、リグレッションがないことを確認せよ。
