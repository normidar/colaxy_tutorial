import 'package:flutter/material.dart';
import 'package:colaxy_tutorial/colaxy_tutorial.dart';

class TutorialDataSet {
  final String id;

  final GlobalKey key;

  final TutorialAlign align;

  final TutorialShape shape;

  final Widget Function(BuildContext context) builder;

  TutorialDataSet({
    required this.id,
    required this.key,
    required this.align,
    required this.shape,
    required this.builder,
  });
}
