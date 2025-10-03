typedef DecideShowingConfigCondition = bool Function({
  int buildNumber,
  String version,
});

sealed class DecideShowingConfig {
  static DecideShowingConfigChooseByUserJustOnce get chooseByUserJustOnce =>
      DecideShowingConfigChooseByUserJustOnce();

  static DecideShowingConfigJustOnce get justOnce =>
      DecideShowingConfigJustOnce();

  static DecideShowingConfigByCondition byCondition({
    required DecideShowingConfigCondition condition,
  }) =>
      DecideShowingConfigByCondition(condition: condition);
}

class DecideShowingConfigByCondition extends DecideShowingConfig {
  DecideShowingConfigByCondition({
    required this.condition,
  });

  final DecideShowingConfigCondition condition;
}

class DecideShowingConfigChooseByUserJustOnce extends DecideShowingConfig {}

class DecideShowingConfigJustOnce extends DecideShowingConfig {}
