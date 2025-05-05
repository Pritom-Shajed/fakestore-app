part of 'url_config_bloc.dart';

abstract class UrlConfigEvent {}

class ToggleUrl extends UrlConfigEvent {
  final int index;
  ToggleUrl(this.index);
}

class SubmitUrlConfig extends UrlConfigEvent {}
