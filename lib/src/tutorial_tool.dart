import 'dart:ui';

import 'package:colaxy_tutorial/colaxy_tutorial.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

const packageName = 'tutorial';

class TutorialTool {
  static bool tutorialVisible = true;

  static Future<bool> isFirstTime(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('$packageName:is_first_time:$id') ?? true;
    if (isFirstTime) {
      await prefs.setBool('$packageName:is_first_time:$id', false);
      await prefs.setStringList(
        '$packageName:is_first_time_ids',
        <String>{
          id,
          ...(prefs.getStringList('$packageName:is_first_time_ids') ?? []),
        }.toList(),
      );
    }
    return isFirstTime;
  }

  static Future<void> resetTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    final showedIds = prefs.getStringList('$packageName:showed_ids') ?? [];
    for (final id in showedIds) {
      await prefs.remove('$packageName:$id');
    }
    final isFirstTimeIds =
        prefs.getStringList('$packageName:is_first_time_ids') ?? [];
    for (final id in isFirstTimeIds) {
      await prefs.remove('$packageName:is_first_time:$id');
    }
  }

  static Future<void> showColaxyDialog({
    required String id,
    required BuildContext buildContext,
    required Widget child,
    required String title,

    /// 強制的に表示するかどうか。
    bool forceShow = false,

    /// バージョンが一致した場合にのみ表示する。
    bool Function(String version)? anyChecker,

    /// バージョンが一致した場合にのみ表示する。
    bool Function(String version)? everyChecker,
  }) async {
    final key = 'tutorial_showed_$id';

    final prefs = await SharedPreferences.getInstance();

    if (!forceShow) {
      if (anyChecker != null) {
        final isRecorded = await VersionRecorder.isRecordedVersionOr(
          checker: anyChecker,
        );
        if (!isRecorded) {
          return;
        }
      }
      if (everyChecker != null) {
        final isRecorded = await VersionRecorder.isRecordedVersionAnd(
          checker: everyChecker,
        );
        if (!isRecorded) {
          return;
        }
      }

      final showed = prefs.getBool(key) ?? false;
      if (showed) {
        return;
      }
    }
    if (buildContext.mounted) {
      final dontShowAgain = await showDialog<bool>(
        context: buildContext,
        barrierDismissible: false,
        builder: (context) => TutorialToolNotifier(title: title, child: child),
      );
      if (dontShowAgain != null && dontShowAgain) {
        await prefs.setBool(key, true);
      }
    }
  }

  static Future<void> showTutorial({
    required List<TutorialDataSet> dataSets,
    required BuildContext buildContext,
  }) async {
    if (!tutorialVisible) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    final toShowIds = <String>[];

    /// ターゲットを作成する。
    final targets = <TargetFocus>[];
    for (final dataSet in dataSets) {
      final showed = prefs.getBool('$packageName:${dataSet.id}') ?? false;
      if (showed) {
        continue;
      }
      toShowIds.add(dataSet.id);
      targets.add(
        TargetFocus(
          // チュートリアルの背景色
          color: const Color.fromARGB(255, 195, 226, 240),
          identify: dataSet.id,
          keyTarget: dataSet.key,
          alignSkip: Alignment.topRight,
          enableOverlayTab: true,
          shape: dataSet.shape.shape,
          contents: [
            TargetContent(
              align: dataSet.align.contentAlign,
              builder: (context, _) => DefaultTextStyle(
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 21,
                ),
                child: dataSet.builder(context),
              ),
            ),
          ],
        ),
      );
    }

    if (toShowIds.isEmpty) {
      return;
    }

    final tutorialCoachMark = TutorialCoachMark(
      textSkip: '$packageName:skip'.tr(),
      textStyleSkip: TextStyle(color: Colors.red[300]),
      targets: targets,
      colorShadow: Colors.grey,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
    );

    Future.delayed(const Duration(milliseconds: 300), () async {
      if (buildContext.mounted) {
        tutorialCoachMark.show(context: buildContext);
        for (final id in toShowIds) {
          await prefs.setBool('$packageName:$id', true);
        }
        const key = '$packageName:showed_ids';
        await prefs.setStringList(
          key,
          <String>{...toShowIds, ...(prefs.getStringList(key) ?? [])}.toList(),
        );
      }
    });
  }
}
