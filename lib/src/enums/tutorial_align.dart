import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

sealed class TutorialAlign {
  static TutorialAlign get bottom => const _TutorialAlignBottom();

  static TutorialAlign get left => const _TutorialAlignLeft();

  static TutorialAlign get right => const _TutorialAlignRight();

  static TutorialAlign get top => const _TutorialAlignTop();

  final ContentAlign _contentAlign;

  const TutorialAlign._({required ContentAlign contentAlign})
      : _contentAlign = contentAlign;

  /// このパッケージしか使わない
  ContentAlign get contentAlign => _contentAlign;
}

class _TutorialAlignBottom extends TutorialAlign {
  const _TutorialAlignBottom() : super._(contentAlign: ContentAlign.bottom);
}

class _TutorialAlignLeft extends TutorialAlign {
  const _TutorialAlignLeft() : super._(contentAlign: ContentAlign.left);
}

class _TutorialAlignRight extends TutorialAlign {
  const _TutorialAlignRight() : super._(contentAlign: ContentAlign.right);
}

class _TutorialAlignTop extends TutorialAlign {
  const _TutorialAlignTop() : super._(contentAlign: ContentAlign.top);
}
