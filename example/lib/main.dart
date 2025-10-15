import 'package:colaxy_tutorial/colaxy_tutorial.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'tutorial_demo_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // バージョンを記録
  await VersionRecorder.recordVersion();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ja', 'JP'),
        Locale('ko', 'KR'),
        Locale('zh', 'CN'),
      ],
      path: 'assets/localizations',
      fallbackLocale: const Locale('en', 'US'),
      child: const ProviderScope(child: MainApp()),
    ),
  );
}

class FeatureItem extends StatelessWidget {
  final IconData icon;

  final String title;
  final String description;
  const FeatureItem({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
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

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Colaxy Tutorial Example',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Colaxy Tutorial Example'),
        backgroundColor: Colors.blue.shade100,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to Colaxy Tutorial Example',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'This example demonstrates the features of the colaxy_tutorial package:\n'
                      '• Interactive step-by-step tutorials\n'
                      '• Dialog-based hints and tips\n'
                      '• Version tracking functionality\n'
                      '• Customizable tutorial settings',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TutorialDemoScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start Tutorial Demo'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () async {
                await TutorialTool.showTutorialDialog(
                  showDontShowAgain: false,
                  id: 'welcome_dialog',
                  buildContext: context,
                  title: 'Welcome Dialog',
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.info, size: 48, color: Colors.blue),
                      SizedBox(height: 16),
                      Text(
                        'This is a sample dialog tutorial. '
                        'It demonstrates how to show contextual hints to users.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.info),
              label: const Text('Show Sample Dialog'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () async {
                await TutorialTool.jumpToTutorialPage(
                  id: 'tutorial_page',
                  buildContext: context,
                  pages: [
                    _buildTutorialPage(
                      context,
                      icon: Icons.touch_app,
                      title: 'Welcome to Tutorial',
                      description:
                          'Swipe left to see the next page.\nTap Skip to exit anytime.',
                      color: Colors.blue.shade100,
                    ),
                    _buildTutorialPage(
                      context,
                      icon: Icons.favorite,
                      title: 'Easy to Use',
                      description:
                          'Our tutorial system makes it easy to guide users through your app features.',
                      color: Colors.pink.shade100,
                    ),
                    _buildTutorialPage(
                      context,
                      icon: Icons.settings,
                      title: 'Customizable',
                      description:
                          'You can customize the appearance and behavior to match your app.',
                      color: Colors.green.shade100,
                    ),
                    _buildTutorialPage(
                      context,
                      icon: Icons.rocket_launch,
                      title: 'Get Started!',
                      description:
                          'This is the last page.\nClick the "Start" button below to begin!',
                      color: Colors.purple.shade100,
                    ),
                  ],
                );
              },
              icon: const Icon(Icons.book),
              label: const Text('Open Tutorial Pages'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TutorialSettingsPage(),
                  ),
                );
              },
              icon: const Icon(Icons.settings),
              label: const Text('Tutorial Settings'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper method to build a tutorial page with consistent styling.
  static Widget _buildTutorialPage(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      color: color,
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 120, color: Colors.black87),
                const SizedBox(height: 40),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black87,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
