import 'package:auth/src/core/configs/get_platform.dart';
import 'package:auth/src/core/network/api_client.dart';
import 'package:auth/src/features/auth/data/repository/auth.dart';
import 'package:auth/src/features/auth/data/source/remote/auth/auth_remote_service.dart';
import 'package:auth/src/features/auth/domain/repository/auth.dart';
import 'package:auth/src/features/auth/domain/usecase/signin.dart';
import 'package:auth/src/features/auth/domain/usecase/signout.dart';
import 'package:auth/src/features/home/data/repositories/home_repository.dart';
import 'package:auth/src/features/home/data/source/remote/home_remote_service.dart';
import 'package:auth/src/features/home/domain/repositories/home_repository.dart';
import 'package:auth/src/features/home/domain/usecase/fetch_categories_usecase.dart';
import 'package:auth/src/features/home/domain/usecase/fetch_products_usecase.dart';
import 'package:auth/src/features/home/presentation/bloc/bloc/home_bloc.dart';
import 'package:auth/src/features/product_details/data/repositories/product_details_repository.dart';
import 'package:auth/src/features/product_details/data/sources/remote/product_details_remote_service.dart';
import 'package:auth/src/features/product_details/domain/repositories/product_details_repository.dart';
import 'package:auth/src/features/product_details/domain/usecase/fetch_product_details_usecase.dart';
import 'package:auth/src/features/product_details/presentation/bloc/product_details_bloc.dart';
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
  sl.registerSingleton<HomeRemoteService>(HomeRemoteServiceImpl(sl()));
  sl.registerSingleton<ProductDetailsRemoteService>(ProductDetailsRemoteServiceImpl(sl()));

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));
  sl.registerSingleton<HomeRepository>(HomeRepositoryImpl(sl()));
  sl.registerSingleton<ProductDetailsRepository>(ProductDetailsRepositoryImpl(sl()));

  // Usecases
  sl.registerSingleton<SignoutUseCase>(SignoutUseCase(sl()));
  sl.registerSingleton<SigninUseCase>(SigninUseCase(sl()));
  sl.registerSingleton<FetchCategoriesUsecase>(FetchCategoriesUsecase(sl()));
  sl.registerSingleton<FetchProductsUsecase>(FetchProductsUsecase(sl()));
  sl.registerSingleton<FetchProductDetailsUsecase>(FetchProductDetailsUsecase(sl()));

  // Blocs
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl()));
  sl.registerFactory<LocaleBloc>(() => LocaleBloc(sl()));
  sl.registerFactory<PerformanceOverlayBloc>(() => PerformanceOverlayBloc(sl()));
  sl.registerFactory<ThemeBloc>(() => ThemeBloc(sl()));
  sl.registerFactory<UrlConfigBloc>(() => UrlConfigBloc(sl()));
  sl.registerFactory<SettingsBloc>(() => SettingsBloc(sl()));
  sl.registerFactory<HomeBloc>(() => HomeBloc(sl(), sl()));
  sl.registerFactory<ProductDetailsBloc>(() => ProductDetailsBloc(sl()));
}
