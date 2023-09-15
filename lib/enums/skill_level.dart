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
        return 'beginner';
      case SkillLevel.intermediate:
        return 'intermediate';
      case SkillLevel.advanced:
        return 'advanced';
    }
  }
}
