import 'package:auth/src/core/configs/get_platform.dart';
import 'package:auth/src/core/network/api_client.dart';
import 'package:auth/src/features/auth/data/repository/auth.dart';
import 'package:auth/src/features/auth/data/source/remote/auth/auth_remote_service.dart';
import 'package:auth/src/features/auth/domain/repository/auth.dart';
import 'package:auth/src/features/auth/domain/usecase/signin.dart';
import 'package:auth/src/features/auth/domain/usecase/signout.dart';
import 'package:auth/src/features/home/bloc/bloc/home_bloc.dart';
import 'package:auth/src/features/settings/data/models/settings_model.dart';
import 'package:auth/src/features/settings/data/repositories/hive_repository_impl.dart';
import 'package:auth/src/features/settings/presentation/bloc/locale/locale_bloc.dart';
import 'package:auth/src/features/settings/presentation/bloc/performance_overlay/bloc/performance_overlay_bloc.dart';
import 'package:auth/src/features/settings/presentation/bloc/settings/bloc/settings_bloc.dart';
import 'package:auth/src/features/settings/presentation/bloc/theme/bloc/theme_bloc.dart';
import 'package:auth/src/features/settings/presentation/bloc/url_config/bloc/url_config_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initialize() async {
  // app initializations
  sl.registerSingleton<PT>(PlatformInfo.getCurrentPlatformType());
  sl.registerSingleton<AppDir>(AppDir());
  sl.registerSingleton<AppSettings>(AppSettings());

  // API Client
  sl.registerSingleton<ApiClient>(ApiClient());

  // Services
  sl.registerSingleton<AuthRemoteService>(AuthRemoteServiceImpl(sl()));

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));

  // Usecases
  sl.registerSingleton<SignoutUseCase>(SignoutUseCase(sl()));

  sl.registerSingleton<SigninUseCase>(SigninUseCase(sl()));

  // Blocs
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl()));
  sl.registerFactory<LocaleBloc>(() => LocaleBloc(sl()));
  sl.registerFactory<PerformanceOverlayBloc>(
      () => PerformanceOverlayBloc(sl()));
  sl.registerFactory<ThemeBloc>(() => ThemeBloc(sl()));
  sl.registerFactory<UrlConfigBloc>(() => UrlConfigBloc(sl()));
  sl.registerFactory<SettingsBloc>(() => SettingsBloc(sl()));
  sl.registerFactory<HomeBloc>(() => HomeBloc());
}
