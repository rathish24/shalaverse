import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/class_scheduling/presentation/schedule_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/navigation/main_navigation_shell.dart';

/// Optional initial location flag passed via command line `--dart-define=INITIAL_ROUTE=...`
/// Defaults to `/login` for full standard startup flow.
const String initialRoute = String.fromEnvironment(
  'INITIAL_ROUTE',
  defaultValue: RouteNames.login,
);

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: initialRoute,
  routes: [
    // 1. Auth route (Outside bottom navigation shell)
    GoRoute(
      path: RouteNames.login,
      builder: (context, state) => const LoginScreen(),
    ),

    // 2. Stateful Shell Route (Houses Bottom Navigation Bar)
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainNavigationShell(navigationShell: navigationShell);
      },
      branches: [
        // Tab 0: Home
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.home,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),

        // Tab 1: Schedule
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.schedule,
              builder: (context, state) => const ScheduleScreen(),
            ),
          ],
        ),

        // Tab 2: Profile
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.profile,
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
