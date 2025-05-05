import 'package:auth/src/injector.dart';
import 'package:auth/src/core/configs/environment.dart';
import 'package:auth/src/features/settings/data/models/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'url_config_event.dart';
part 'url_config_state.dart';

class UrlConfigBloc extends Bloc<UrlConfigEvent, UrlConfigState> {
  final AppSettings settings;

  UrlConfigBloc(this.settings) :
        super(UrlConfigState(
          baseUrlController: TextEditingController(
            text: sl<AppSettings>().isProduction
                ? Environment.prodBaseUrl
                : Environment.devBaseUrl,
          ),
          baseUrls: [Environment.prodBaseUrl, Environment.devBaseUrl],
          headers: ['Production', 'Development'],
          currUrlIndex: sl<AppSettings>().isProduction ? 0 : 1,
          isProduction: sl<AppSettings>().isProduction,
        )) {
    on<ToggleUrl>(_onToggleUrl);
    on<SubmitUrlConfig>(_onSubmit);
  }

  void _onToggleUrl(ToggleUrl event, Emitter<UrlConfigState> emit) {
    final newBaseUrl = state.baseUrls[event.index];

    state.baseUrlController.text = newBaseUrl;

    settings.isProduction = event.index == 0;

    emit(state.copyWith(
      currUrlIndex: event.index,
      isProduction: event.index == 0,
    ));
  }

  Future<void> _onSubmit(
      SubmitUrlConfig event, Emitter<UrlConfigState> emit) async {
    await settings.save();
  }
}
