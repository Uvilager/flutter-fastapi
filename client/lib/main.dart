import 'package:client/core/router/app_router.dart';
import 'package:client/core/theme/theme.dart';
import 'package:client/features/auth/repository/auth_local_repository.dart';
import 'package:client/features/auth/view/pages/signin_page.dart';
import 'package:flutter/material.dart';

import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _EagerInitialization(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.darkThemeMode,
        routerConfig: ref.watch(goRouterProvider),
      ),
    );
  }
}

class _EagerInitialization extends ConsumerWidget {
  const _EagerInitialization({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final init = ref.watch(initSharedPrefsProvider);
    if (init.isLoading) {
      return const CircularProgressIndicator();
    } else if (init.hasError) {
      return const Text('Oopsy!');
    }
    return child;
  }
}
