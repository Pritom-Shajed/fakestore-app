part of 'theme_model.dart';

extension ThemeProfileExtension on ThemeProfile {
  String get label {
    switch (this) {
      case ThemeProfile.system:
        return 'System Default';
      case ThemeProfile.light:
        return 'Light';
      case ThemeProfile.dark:
        return 'Dark';
    }
  }

  String get icon {
    switch (this) {
      case ThemeProfile.system:
        return 'assets/svgs/system.svg';
      case ThemeProfile.light:
        return 'assets/svgs/light.svg';
      case ThemeProfile.dark:
        return 'assets/svgs/dark.svg';
    }
  }

  bool get isSystem => this == ThemeProfile.system;
  bool get isLight => this == ThemeProfile.light;
  bool get isDark => this == ThemeProfile.dark;

  bool get isNotSystem => !isSystem;
  bool get isNotLight => !isLight;
  bool get isNotDark => !isDark;
}
