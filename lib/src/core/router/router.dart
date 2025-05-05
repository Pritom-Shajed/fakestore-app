import 'package:auth/src/core/configs/get_platform.dart';
import 'package:auth/src/core/network/api_client.dart';
import 'package:auth/src/core/router/app_routes.dart';
import 'package:auth/src/core/shared/maintenance_break/maintenance_break.dart';
import 'package:auth/src/core/shared/page_not_found/page_not_found.dart';
import 'package:auth/src/core/utils/logger/logger_helper.dart';
import 'package:auth/src/features/auth/presentation/view/signin_page.dart';
import 'package:auth/src/features/auth/presentation/view/signup_page.dart';
import 'package:auth/src/features/home/presentation/home_page.dart';
import 'package:auth/src/features/settings/presentation/view/settings_view.dart';
import 'package:auth/src/injector.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<String?> authRedirect(BuildContext context, GoRouterState state) async {
  final path = '/${state.fullPath?.split('/').last.toLowerCase()}';
  final loggedIn = sl<ApiClient>().isLoggedIn;

  // Maintenance Break
  if (AppRoutes.isMaintenanceBreak) {
    log.f('Redirecting to ${AppRoutes.maintenanceBreakRoute} from $path Reason: Maintenance Break.');
    return AppRoutes.maintenanceBreakRoute;
  }
  if (!AppRoutes.isMaintenanceBreak && path == AppRoutes.maintenanceBreakRoute) {
    log.f('Redirecting to ${AppRoutes.homeRoute} from $path Reason: Maintenance Break ended.');
    return AppRoutes.homeRoute;
  }

  // Auth
  if (!loggedIn && AppRoutes.allAuthRequiredRoutes.contains(path)) {
    log.f('Redirecting to ${AppRoutes.signinRoute} from $path Reason: Authentication.');
    return AppRoutes.signinRoute;
  }
  if (loggedIn && AppRoutes.authRelatedRoutes.contains(path)) {
    log.f('Redirecting to ${AppRoutes.homeRoute} from $path Reason: Already logged in.');
    return AppRoutes.homeRoute;
  }
  return null;
}

GoRouter goRouter = GoRouter(
  initialLocation: AppRoutes.homeRoute,
  errorBuilder: (_, __) => const KPageNotFound(error: '404 - Page not found!'),
  routes: [
    GoRoute(
      path: AppRoutes.signinRoute,
      name: SigninPage.name,
      builder: (_, __) => const SigninPage(),
    ),
    GoRoute(
      path: AppRoutes.settingsRoute,
      name: SettingsView.name,
      builder: (_, __) => const SettingsView(),
    ),
    GoRoute(
      path: AppRoutes.signupRoute,
      name: SignupPage.name,
      builder: (_, __) => const SignupPage(),
    ),
    GoRoute(
      path: AppRoutes.homeRoute,
      name: HomePage.name,
      builder: (_, __) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutes.maintenanceBreakRoute,
      name: MaintenanceBreak.name,
      builder: (_, __) => const MaintenanceBreak(),
    ),
  ],
  // redirect: authRedirect,
);

extension GoRouteExtension on BuildContext {
  Future goPush<T>(String route, {Object? extra}) async => sl<PT>().isWeb
      ? GoRouter.of(this).go(route, extra: extra)
      : await GoRouter.of(this).push(
          route,
          extra: extra,
        );

  Future goPushNamed<T>(
    String route, {
    Object? extra,
    Map<String, String> pathParams = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
  }) async =>
      sl<PT>().isWeb
          ? GoRouter.of(this).goNamed(route, extra: extra, pathParameters: pathParams, queryParameters: queryParams)
          : await GoRouter.of(this)
              .pushNamed(route, extra: extra, pathParameters: pathParams, queryParameters: queryParams);
}

extension GoRouterExtension on GoRouter {
  void clearStackAndNavigate(String location) {
    while (canPop()) {
      pop();
    }
    pushReplacement(location);
  }
}
