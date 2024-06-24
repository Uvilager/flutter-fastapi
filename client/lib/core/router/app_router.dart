import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:client/features/home/view/pages/home_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

import 'package:client/features/auth/view/pages/signin_page.dart';
import 'package:client/features/auth/view/pages/signup_page.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  final user = ref.watch(authViewModelProvider);
  return GoRouter(
    redirect: (context, state) {
      if (user != null && user.value != null) {
        return '/home';
      } else {
        return null;
      }
    },
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SigninPage(),
        routes: [
          GoRoute(
            path: 'register',
            builder: (context, state) => const SignupPage(),
          ),
        ],
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
