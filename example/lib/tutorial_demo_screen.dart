import 'package:colaxy_tutorial/colaxy_tutorial.dart';
import 'package:flutter/material.dart';

class DemoFeatureItem extends StatelessWidget {
  final IconData icon;

  final String title;
  final String description;
  const DemoFeatureItem({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TutorialDemoScreen extends StatefulWidget {
  const TutorialDemoScreen({super.key});

  @override
  State<TutorialDemoScreen> createState() => _TutorialDemoScreenState();
}

class _TutorialDemoScreenState extends State<TutorialDemoScreen> {
  // GlobalKeyを各ウィジェットに対して定義
  final GlobalKey _welcomeKey = GlobalKey();
  final GlobalKey _buttonKey = GlobalKey();
  final GlobalKey _cardKey = GlobalKey();
  final GlobalKey _settingsKey = GlobalKey();
  final GlobalKey _menuKey = GlobalKey();

  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: _welcomeKey,
        title: const Text('チュートリアルデモ'),
        backgroundColor: Colors.blue.shade100,
        elevation: 2,
        actions: [
          IconButton(
            key: _menuKey,
            icon: const Icon(Icons.menu),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('メニューが開かれました')));
            },
          ),
          IconButton(
            key: _settingsKey,
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TutorialSettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              key: _cardKey,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Icon(Icons.numbers, size: 48, color: Colors.blue),
                    const SizedBox(height: 16),
                    Text(
                      'カウンター',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$_counter',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _showAdvancedDialog,
                  icon: const Icon(Icons.lightbulb),
                  label: const Text('ヒント表示'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _showMainTutorial,
                  icon: const Icon(Icons.replay),
                  label: const Text('チュートリアル再生'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'チュートリアル機能の説明',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      DemoFeatureItem(
                        icon: Icons.timeline,
                        title: 'ステップバイステップガイド',
                        description: '複数のステップを順序立てて表示',
                      ),
                      DemoFeatureItem(
                        icon: Icons.highlight,
                        title: 'ハイライト機能',
                        description: '円形または角丸四角形でのハイライト',
                      ),
                      DemoFeatureItem(
                        icon: Icons.place,
                        title: '配置設定',
                        description: '上下左右の任意の位置にコンテンツを表示',
                      ),
                      DemoFeatureItem(
                        icon: Icons.memory,
                        title: '状態記憶',
                        description: '一度表示したチュートリアルは自動的に記憶',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: _buttonKey,
        onPressed: _incrementCounter,
        tooltip: 'カウンターを増やす',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // 画面が表示された後にチュートリアルを開始
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showMainTutorial();
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<void> _showAdvancedDialog() async {
    await TutorialTool.showTutorialDialog(
      showDontShowAgain: false,
      id: 'advanced_feature_dialog',
      buildContext: context,
      title: '高度な機能',
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, size: 48, color: Colors.amber),
          SizedBox(height: 16),
          Text(
            'この機能は上級ユーザー向けです。',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'バージョン履歴やユーザーの使用状況に基づいて、'
            '適切なタイミングでヒントを表示できます。',
            textAlign: TextAlign.center,
          ),
        ],
      ),
      // 例：特定のバージョンを使用したことがあるユーザーにのみ表示
      // anyChecker: (version) => version == '1.0.0',
    );
  }

  Future<void> _showMainTutorial() async {
    final tutorialDataSets = [
      TutorialDataSet(
        id: 'welcome_tutorial',
        key: _welcomeKey,
        align: TutorialAlign.bottom,
        shape: TutorialShape.rRect,
        builder: (context) => const TutorialContent(
          title: 'ようこそ！',
          description:
              'これは Colaxy Tutorial パッケージのデモです。'
              'このヘッダーから始めましょう！',
        ),
      ),
      TutorialDataSet(
        id: 'card_tutorial',
        key: _cardKey,
        align: TutorialAlign.top,
        shape: TutorialShape.rRect,
        builder: (context) => const TutorialContent(
          title: 'カウンター表示',
          description:
              'このカードには現在のカウンター値が表示されます。'
              'チュートリアルはこのように任意の形状でハイライトできます。',
        ),
      ),
      TutorialDataSet(
        id: 'button_tutorial',
        key: _buttonKey,
        align: TutorialAlign.top,
        shape: TutorialShape.circle,
        builder: (context) => const TutorialContent(
          title: 'アクションボタン',
          description:
              'このボタンをタップするとカウンターが増加します。'
              '円形のハイライトでボタンを強調表示しています。',
        ),
      ),
      TutorialDataSet(
        id: 'menu_tutorial',
        key: _menuKey,
        align: TutorialAlign.left,
        shape: TutorialShape.circle,
        builder: (context) => const TutorialContent(
          title: 'メニューボタン',
          description: 'このメニューボタンから追加のオプションにアクセスできます。',
        ),
      ),
      TutorialDataSet(
        id: 'settings_tutorial',
        key: _settingsKey,
        align: TutorialAlign.bottom,
        shape: TutorialShape.circle,
        builder: (context) => const TutorialContent(
          title: '設定',
          description:
              'チュートリアル設定はここから管理できます。'
              'これでメインチュートリアルは完了です！',
        ),
      ),
    ];

    await TutorialTool.showTutorial(
      dataSets: tutorialDataSets,
      buildContext: context,
    );
  }
}
