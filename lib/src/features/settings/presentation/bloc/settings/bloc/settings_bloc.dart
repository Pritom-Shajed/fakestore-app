import 'dart:async';

import 'package:auth/src/injector.dart';
import 'package:auth/src/core/configs/constants.dart';
import 'package:auth/src/core/utils/extensions/extensions.dart';
import 'package:auth/src/core/utils/logger/logger_helper.dart';
import 'package:auth/src/features/settings/data/models/settings_model.dart';
import 'package:auth/src/features/settings/data/repositories/hive_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  late StreamSubscription _settingsSubscription;
  final AppSettings settings;

  SettingsBloc(this.settings) : super(SettingsState(settings: settings)) {
    on<InitializeSettings>(_onInitializeSettings);

    // Listen to Hive settings stream updates
    _settingsSubscription =
        Boxes.appSettings.watch(key: appName.toCamelWord).listen((event) {
      add(InitializeSettings(event.value as AppSettings));
    });
  }

  Future<void> _onInitializeSettings(
      InitializeSettings event, Emitter<SettingsState> emit) async {
    log.i('First Time Run. Initializing...');
    await event.settings.saveData();
    emit(state.copyWith(settings: event.settings));
  }

  @override
  Future<void> close() {
    _settingsSubscription.cancel();
    return super.close();
  }
}
