import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_name/firebase_options.dart';
import 'package:portfolio_name/route/router_provider.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

Future<void> main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerDelegate: ref.watch(routerProvider).routerDelegate,
      routeInformationParser: ref.watch(routerProvider).routeInformationParser,
      routeInformationProvider:
          ref.watch(routerProvider).routeInformationProvider,
      title: "KOSHIRO's portfolio",
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color.fromRGBO(65, 65, 65, 1),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color.fromRGBO(242, 246, 247, 1),
        ),
        backgroundColor: const Color.fromRGBO(65, 65, 65, 1),
        dialogBackgroundColor: const Color.fromRGBO(242, 246, 247, 1),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
