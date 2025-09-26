import 'package:colaxy_tutorial/colaxy_tutorial.dart';
import 'package:flutter/material.dart';

class TutorialDataSet {
  TutorialDataSet({
    required this.id,
    required this.key,
    required this.align,
    required this.shape,
    required this.builder,
  });

  final String id;

  final GlobalKey key;

  final TutorialAlign align;

  final TutorialShape shape;

  final Widget Function(BuildContext context) builder;
}
