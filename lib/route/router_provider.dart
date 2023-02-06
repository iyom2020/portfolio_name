import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_name/scenes/top_view.dart';

final routerProvider = Provider((ref) => GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const TopView(),
        ),
        GoRoute(
          path: '/top',
          builder: (context, state) => const TopView(),
        ),
      ],
      // redirect: (state) {
      //
      //   return null;
      // },
    ));
