import 'package:auth/src/injector.dart';
import 'package:auth/src/core/configs/constants.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/logger/logger_helper.dart';
import '../../domain/repositories/settings_repository.dart';
import '../models/settings_model.dart';
import 'hive_box.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  @override
  Future<void> init() async {
    if (Boxes.appSettings.isEmpty) await _appSettingsInit();
    if (sl.isRegistered<AppSettings>()) sl.unregister<AppSettings>();
    sl.registerSingleton<AppSettings>(
        Boxes.appSettings.get(appName.toCamelWord) ?? AppSettings());
    log.i(
        'App Initiated with appSettings: ${sl<AppSettings>().firstRunDateTime}');
    _listenForAppConfig();
  }

  Future<void> _appSettingsInit() async {
    final appSettings = AppSettings();
    log.i('App Settings Initiated at ${appSettings.firstRunDateTime}');
    await appSettings.saveData();
  }

  void _listenForAppConfig() =>
      Boxes.appSettings.watch(key: appName.toCamelWord).listen(
        (_) {
          if (sl.isRegistered<AppSettings>()) sl.unregister<AppSettings>();
          sl.registerSingleton<AppSettings>(
              Boxes.appSettings.get(appName.toCamelWord) ?? AppSettings());
        },
      );
}
