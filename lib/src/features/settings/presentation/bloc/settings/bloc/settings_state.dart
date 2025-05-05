part of 'settings_bloc.dart';

class SettingsState {
  final AppSettings settings;

  SettingsState({required this.settings});

  SettingsState copyWith({AppSettings? settings}) {
    return SettingsState(settings: settings ?? this.settings);
  }
}
