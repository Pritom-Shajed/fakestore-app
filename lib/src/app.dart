import 'package:auth/main.dart';
import 'package:auth/src/core/configs/constants.dart';
import 'package:auth/src/core/configs/size.dart';
import 'package:auth/src/core/utils/extensions/extensions.dart';
import 'package:auth/src/core/utils/logger/logger_helper.dart';
import 'package:auth/src/core/utils/theme/dark/dark_theme.dart';
import 'package:auth/src/core/utils/theme/light/light_theme.dart';
import 'package:auth/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:auth/src/features/home/bloc/bloc/home_bloc.dart';
import 'package:auth/src/features/home/presentation/home_page.dart';
import 'package:auth/src/features/settings/data/models/locale/locale_model.dart';
import 'package:auth/src/features/settings/data/models/theme/theme_model.dart';
import 'package:auth/src/features/settings/presentation/bloc/locale/locale_bloc.dart';
import 'package:auth/src/features/settings/presentation/bloc/performance_overlay/bloc/performance_overlay_bloc.dart';
import 'package:auth/src/features/settings/presentation/bloc/settings/bloc/settings_bloc.dart';
import 'package:auth/src/features/settings/presentation/bloc/theme/bloc/theme_bloc.dart';
import 'package:auth/src/features/settings/presentation/bloc/url_config/bloc/url_config_bloc.dart';
import 'package:auth/src/localization/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'core/router/router.dart';
import 'injector.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    configEasyLoading(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthBloc>()),
        BlocProvider(create: (context) => sl<LocaleBloc>()),
        BlocProvider(create: (context) => sl<PerformanceOverlayBloc>()),
        BlocProvider(create: (context) => sl<ThemeBloc>()),
        BlocProvider(create: (context) => sl<UrlConfigBloc>()),
        BlocProvider(create: (context) => sl<SettingsBloc>()),
        BlocProvider(create: (context) => sl<HomeBloc>()),
      ],
      child: Builder(builder: (context) {
        return MaterialApp.router(
          key: ValueKey(context.watch<LocaleBloc>().state.locale.locale),
          title: appName,
          theme: themeData(context),
          routerConfig: goRouter,
          onGenerateTitle: onGenerateTitle,
          debugShowCheckedModeBanner: false,
          restorationScopeId: appName.toCamelWord,
          locale: context.watch<LocaleBloc>().state.locale.locale,
          localizationsDelegates: localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          showPerformanceOverlay:
              context.watch<PerformanceOverlayBloc>().state.isEnabled,
          builder: EasyLoading.init(builder: (ctx, child) {
            t = AppLocalizations.of(ctx)!;
            topBarSize = ctx.padding.top;
            bottomViewPadding = ctx.padding.bottom;
            log.i(
                'App build. Height: ${ctx.height} px, Width: ${ctx.width} px');
            return MediaQuery(
              data: ctx.mq.copyWith(
                devicePixelRatio: 1.0,
                textScaler: const TextScaler.linear(1.0),
              ),
              child: child ?? const HomePage(),
            );
          }),
        );
      }),
    );
  }
}

ThemeData themeData(BuildContext context) {
  final themeState = context.watch<ThemeBloc>().state;

  final theme = themeState.theme.isSystem
      ? (context.isLightTheme ? lightTheme : darkTheme)
      : themeState.theme.isDark
          ? darkTheme
          : lightTheme;

  SystemChrome.setSystemUIOverlayStyle(
    themeState.theme.isSystem
        ? (context.isLightTheme ? lightUiConfig : darkUiConfig)
        : themeState.theme.isDark
            ? darkUiConfig
            : lightUiConfig,
  );

  return theme;
}
