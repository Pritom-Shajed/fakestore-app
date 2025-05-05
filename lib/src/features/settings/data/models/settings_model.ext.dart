part of 'settings_model.dart';

extension SettingExtension on AppSettings {
  AppSettings copyWith({
    bool? firstRun,
    bool? isProduction,
    String? dateFormat,
    String? timeFormat,
    String? fontFamily,
    ThemeProfile? theme,
    LocaleProfile? locale,
    DateTime? firstRunDateTime,
    bool? performanceOverlayEnable,
  }) =>
      AppSettings()
        ..performanceOverlayEnable =
            performanceOverlayEnable ?? this.performanceOverlayEnable
        ..firstRunDateTime = firstRunDateTime ?? this.firstRunDateTime
        ..isProduction = isProduction ?? this.isProduction
        ..fontFamily = fontFamily ?? this.fontFamily
        ..firstRun = firstRun ?? this.firstRun
        ..locale = locale ?? this.locale
        ..theme = theme ?? this.theme;
}
