import 'package:easy_localization/easy_localization.dart';

enum SkillLevel {
  beginner,
  intermediate,
  advanced,
}

extension SkillLevelExtension on SkillLevel {
  static SkillLevel parseSkillLevel(String levelString) {
    switch (levelString) {
      case 'beginner':
        return SkillLevel.beginner;
      case 'intermediate':
        return SkillLevel.intermediate;
      case 'advanced':
        return SkillLevel.advanced;
      default:
        throw ArgumentError('Nieprawidłowy poziom zaawansowania: $levelString');
    }
  }

  String skillLevelToString() {
    switch (this) {
      case SkillLevel.beginner:
        return 'skillLevel.beginner'.tr();
      case SkillLevel.intermediate:
        return 'skillLevel.intermediate'.tr();
      case SkillLevel.advanced:
        return 'skillLevel.advanced'.tr();
    }
  }
}
