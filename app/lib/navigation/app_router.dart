import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:helping_nexus/ui/welcome_screen.dart';

import '../manager/app_state_manager.dart';
import '../ui/auth/login/login_screen.dart';
import '../ui/dashboard_screen.dart';
import '../ui/splash_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final routerProvider = Provider.autoDispose<GoRouter>((ref) {
final appStateManager = ref.watch(appStateProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: false,
    initialLocation: '/',
    routes: [
      GoRoute(
          name: 'splash',
          path: '/',
          builder: (context, state) => const SplashScreen()
      ),
      GoRoute(
          name: 'welcome',
          path: '/welcome',
          builder: (context, state) => const WelcomeScreen()
      ),
      GoRoute(
          name: 'login',
          path: '/login',
          builder: (context, state) => const LoginScreen()
      ),
      GoRoute(
        name: 'dashboard',
        path: '/dashboard',
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const DashboardScreen(),
        ),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {

      final inSplash = state.fullPath == '/';

      final inWelcome = state.fullPath == '/welcome';
      const welcomeLoc = '/welcome';

      final inLogin = state.fullPath == '/login';

      const dashboardLoc = '/dashboard';

      final loggedIn = appStateManager.isLoggedIn;

      final noLoggedInRoutes = [
        inSplash,
        inWelcome,
        inLogin
      ];

      // redirect to the welcome page if the user is not logged in or to the
      //  dashboard if the user is logged in
      if (appStateManager.isInitialized) {
        if (inSplash) {

          return welcomeLoc;
        }

        if (!loggedIn) {

          if (noLoggedInRoutes.every((element) => !element) ) {
            return welcomeLoc;
          }
        } else {

          if (noLoggedInRoutes.any((element) => element)){
            return dashboardLoc;
          }
        }

      }

      return null;
    },
  );
});