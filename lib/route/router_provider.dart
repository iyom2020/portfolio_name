import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_name/provider/login_info_provider.dart';
import 'package:portfolio_name/scenes/admin_list_work_view.dart';
import 'package:portfolio_name/scenes/admin_login_view.dart';
import 'package:portfolio_name/scenes/admin_top_view.dart';
import 'package:portfolio_name/scenes/blog_contents_view.dart';
import 'package:portfolio_name/scenes/blog_top_view.dart';
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
        GoRoute(
          path: '/blog',
          builder: (context, state) => const BlogTopView(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (BuildContext context, GoRouterState state) {
                final blogId = state.params['id'];
                // userId: int.parse(userId!),
                return BlogContentsView(
                  blogId:int.parse(blogId!),
                );
              },
            ),
          ]
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const AdminLoginView(),
        ),
        GoRoute(
          path: '/admin',
          builder: (context, state) => const AdminTopView(),
          routes: [
            GoRoute(
              path: 'list_work',
              builder: (context, state) => const AdminListWorkView(),
            ),
            GoRoute(
              path: '12',
              builder: (context, state) => const TopView(),
            ),
          ],
          redirect: (_, state) {
            final isLoggedIn = ref.read(loginInfoProvider);
            if (!isLoggedIn /* && state.subloc == "/admin"*/) {
              return "/login";
            }
            return null;
          },
        ),
      ],
      // redirect: (_,state) {
      //   final isLoggedIn = ref.read(loginInfoProvider);
      //   if (!isLoggedIn && state.subloc == "/admin") {
      //     return "/login";
      //   }
      //
      //   return null;
      // },
      // refreshListenable: ref.watch(loginInfoProvider),

      //遷移ページがないなどのエラーが発生した時に、このページに行く
      errorPageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Text(state.error.toString()),
          ),
        ),
      ),
    ));
