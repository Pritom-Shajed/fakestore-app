part of 'locale_bloc.dart';

abstract class LocaleEvent {}

class ChangeLocale extends LocaleEvent {
  final LocaleProfile locale;

  ChangeLocale(this.locale);
}
