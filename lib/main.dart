import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_name/route/router_provider.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: "KOSHIRO's portfolio",
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color.fromRGBO(242, 246, 247, 1),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color.fromRGBO(242, 246, 247, 1),
        ),
        backgroundColor: const Color.fromRGBO(242, 246, 247, 1),
        dialogBackgroundColor: const Color.fromRGBO(242, 246, 247, 1),
      ),
      routerDelegate: ref.watch(routerProvider).routerDelegate,
      routeInformationParser: ref.watch(routerProvider).routeInformationParser,
    );
  }
}
