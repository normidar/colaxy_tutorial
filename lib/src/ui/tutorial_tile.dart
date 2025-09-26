import 'package:app_lang_selector/app_lang_selector.dart';
import 'package:colaxy_tutorial/colaxy_tutorial.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// tutorial_tile

class TutorialTile extends ConsumerWidget {
  const TutorialTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _ = ref.watch(selectingLangProvider);
    return ListTile(
      leading: const Icon(Icons.tungsten_rounded),
      title: const Text('tile_title').tr(),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => const TutorialSettingsPage(),
          ),
        );
      },
    );
  }
}
