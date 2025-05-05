part of 'theme_bloc.dart';

class ThemeState {
  final ThemeProfile theme;

  ThemeState({required this.theme});

  ThemeState copyWith({ThemeProfile? theme}) {
    return ThemeState(theme: theme ?? this.theme);
  }
}
