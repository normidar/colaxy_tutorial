import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

sealed class TutorialShape {
  const TutorialShape(this.shape);

  static TutorialShape get circle => const _TutorialShapeCircle();

  static TutorialShape get rRect => const _TutorialShapeRRect();

  final ShapeLightFocus shape;
}

class _TutorialShapeCircle extends TutorialShape {
  const _TutorialShapeCircle() : super(ShapeLightFocus.Circle);
}

class _TutorialShapeRRect extends TutorialShape {
  const _TutorialShapeRRect() : super(ShapeLightFocus.RRect);
}
