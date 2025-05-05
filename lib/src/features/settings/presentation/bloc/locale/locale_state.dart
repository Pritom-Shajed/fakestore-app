part of 'locale_bloc.dart';

class LocaleState {
  final LocaleProfile locale;

  LocaleState({required this.locale});

  LocaleState copyWith({LocaleProfile? locale}) {
    return LocaleState(locale: locale ?? this.locale);
  }
}
