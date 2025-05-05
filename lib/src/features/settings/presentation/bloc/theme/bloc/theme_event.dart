part of 'theme_bloc.dart';

abstract class ThemeEvent {}

class ChangeTheme extends ThemeEvent {
  final ThemeProfile theme;
  
  ChangeTheme(this.theme);
}
