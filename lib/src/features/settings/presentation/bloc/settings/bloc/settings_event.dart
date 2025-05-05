part of 'settings_bloc.dart';

abstract class SettingsEvent {}

class InitializeSettings extends SettingsEvent {
  final AppSettings settings;

  InitializeSettings(this.settings);
}
