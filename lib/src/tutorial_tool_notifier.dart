import 'package:colaxy_tutorial/colaxy_tutorial.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TutorialToolNotifier extends StatefulWidget {
  final String title;
  final Widget child;

  const TutorialToolNotifier({
    required this.title,
    required this.child,
    super.key,
  });

  @override
  State<TutorialToolNotifier> createState() => _TutorialToolNotifierState();
}

class _TutorialToolNotifierState extends State<TutorialToolNotifier> {
  bool dontShowAgain = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: widget.child,
      actions: [
        Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: Checkbox(
                value: dontShowAgain,
                onChanged: (value) {
                  setState(() {
                    dontShowAgain = value ?? false;
                  });
                },
              ),
            ),
            Text('$packageName:dont_show_again'.tr()),
          ],
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(dontShowAgain),
          child: Text(
            '$packageName:understood'.tr(),
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
