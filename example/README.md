# Colaxy Tutorial Example

このプロジェクトは、**colaxy_tutorial** パッケージの使用方法を実演するサンプルアプリケーションです。

## 機能の実演

この Example アプリでは以下の機能を確認できます：

### 📚 インタラクティブチュートリアル

- ステップバイステップのガイド機能
- 各 UI コンポーネントのハイライト表示
- カスタムコンテンツによる説明

### 💬 ダイアログベースのヒント

- コンテキストに応じた情報表示
- ユーザーが「再表示しない」を選択可能
- バージョン管理との連携

### ⚙️ 設定管理

- チュートリアルの表示設定
- 完了済みチュートリアルのリセット機能
- 組み込み設定画面

### 🌐 多言語対応

- 日本語、英語、韓国語、中国語（簡体字）対応
- easy_localization パッケージとの統合

## 実行方法

### 前提条件

- Flutter SDK 3.9.0 以上
- macOS での実行（この例では macOS プラットフォームのみを対象）

### セットアップ

1. 依存関係のインストール:

```bash
flutter pub get
```

2. アプリケーションの実行:

```bash
flutter run -d macos
```

## コード構造

```
lib/
├── main.dart                    # メインアプリケーション
└── tutorial_demo_screen.dart    # チュートリアル機能のデモ画面
```

### main.dart

- アプリケーションのエントリーポイント
- ローカライゼーションとプロバイダーの設定
- メイン画面の実装

### tutorial_demo_screen.dart

- チュートリアル機能の包括的なデモ
- 複数の TutorialDataSet の実装例
- 異なる配置オプションとハイライト形状の実演

## 使用されているパッケージ機能

### TutorialDataSet

```dart
TutorialDataSet(
  id: 'unique_id',           // 一意識別子
  key: GlobalKey(),          // ターゲットウィジェットのキー
  align: TutorialAlign.bottom, // コンテンツの配置
  shape: TutorialShape.circle, // ハイライトの形状
  builder: (context) => Widget(), // コンテンツビルダー
)
```

### TutorialTool.showTutorial()

複数のチュートリアルステップを順次表示:

```dart
await TutorialTool.showTutorial(
  dataSets: tutorialDataSets,
  buildContext: context,
);
```

### TutorialTool.showColaxyDialog()

ダイアログベースのヒント表示:

```dart
await TutorialTool.showColaxyDialog(
  id: 'dialog_id',
  buildContext: context,
  title: 'タイトル',
  child: Widget(),
);
```

### VersionRecorder

アプリバージョンの記録と追跡:

```dart
await VersionRecorder.recordVersion();
```

## カスタマイズ例

### ハイライト形状

- `TutorialShape.circle` - 円形
- `TutorialShape.rRect` - 角丸四角形

### コンテンツ配置

- `TutorialAlign.top` - 上部
- `TutorialAlign.bottom` - 下部
- `TutorialAlign.left` - 左側
- `TutorialAlign.right` - 右側

### バージョン条件チェック

```dart
// 特定バージョンを使用したユーザーにのみ表示
anyChecker: (version) => version == '1.0.0',

// すべての指定バージョンを使用したユーザーに表示
everyChecker: (version) => ['1.0.0', '1.1.0'].contains(version),
```

## 学習ポイント

1. **GlobalKey の管理**: チュートリアルターゲットとなるウィジェットには GlobalKey が必要
2. **ライフサイクル管理**: `addPostFrameCallback`を使用してウィジェット構築後にチュートリアルを開始
3. **状態管理**: チュートリアルの表示状態は自動的に保存され、重複表示を防ぐ
4. **ユーザビリティ**: 「再表示しない」オプションでユーザー体験を向上

## トラブルシューティング

### よくある問題

1. **チュートリアルが表示されない**

   - GlobalKey が正しく設定されているか確認
   - ウィジェットが完全に構築された後にチュートリアルを開始しているか確認

2. **ローカライゼーションファイルが読み込まれない**

   - `assets/localizations/`フォルダが存在するか確認
   - pubspec.yaml の assets セクションが正しく設定されているか確認

3. **設定がリセットされない**
   - SharedPreferences の権限が正しく設定されているか確認

## 関連リンク

- [colaxy_tutorial パッケージ](https://pub.dev/packages/colaxy_tutorial)
- [tutorial_coach_mark](https://pub.dev/packages/tutorial_coach_mark)
- [easy_localization](https://pub.dev/packages/easy_localization)
- [flutter_riverpod](https://pub.dev/packages/flutter_riverpod)
