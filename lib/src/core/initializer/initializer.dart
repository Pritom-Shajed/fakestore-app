import 'dart:async';
import 'package:auth/src/core/configs/environment.dart';
import 'package:auth/src/core/configs/get_platform.dart';
import 'package:auth/src/core/network/api_client.dart';
import 'package:auth/src/core/shared/error/app_error_view.dart';
import 'package:auth/src/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:auth/src/injector.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import '../../features/settings/data/repositories/hive_repository_impl.dart';
import '../utils/logger/logger_helper.dart';

class Initializer {
  Initializer._();

  static void init(VoidCallback runApp) {
    ErrorWidget.builder = (errorDetails) {
      return AppErrorView(
        message: errorDetails.exceptionAsString(),
      );
    };

    runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();
      FlutterError.onError = (details) {
        FlutterError.dumpErrorToConsole(details);
        log.i(details.stack.toString());
      };

      // Initialize Services
      await _initServices();

      runApp();
    }, (error, stack) {
      log.i('runZonedGuarded: ${error.toString()}');
    });
  }

  static Future<void> _initServices() async {
    try {
      _initScreenPreference();
      await dotenv.load(fileName: Environment.fileName);
      await initialize();
      log.i("Initializing Hive Repository...");
      await HiveRepositoryImpl().init();
      log.i("Hive Repository initialized successfully.");

      log.i("Initializing ApiClient...");
      await sl<ApiClient>().init();
      log.i("ApiClient Initialized...");

      log.i("Initializing Settings Repository...");
      await SettingsRepositoryImpl().init();
      log.i("Settings Repository initialized successfully.");

      if (sl<PT>().isWeb) setUrlStrategy(const PathUrlStrategy());
    } catch (err, stack) {
      log.e("Error during _initServices: $err");
      log.e(stack.toString());
      rethrow;
    }
  }

  static void _initScreenPreference() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
