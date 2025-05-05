part of 'locale_model.dart';

extension LocaleProfileExtension on LocaleProfile {
  Locale get locale {
    switch (this) {
      case LocaleProfile.english:
        return enLocale;
      case LocaleProfile.bengali:
        return bnLocale;
    }
  }

  String get label {
    switch (this) {
      case LocaleProfile.english:
        return 'English';
      case LocaleProfile.bengali:
        return 'বাংলা';
    }
  }
}
