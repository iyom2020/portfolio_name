import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_name/component/popup/default_alert_dialog.dart';
import 'package:portfolio_name/component/popup/snack_bar_factory.dart';
import 'package:portfolio_name/provider/login_info_provider.dart';
import 'package:portfolio_name/scenes/admin_top_view.dart';

class AdminTopGestureDetector {
  final String title;
  final int index;
  final double widthSize;
  final Color? titleColor;
  final GestureTapCallback? onTap;

  AdminTopGestureDetector({
    required this.title,
    required this.index,
    required this.widthSize,
    this.titleColor,
    this.onTap,
  });

  GestureDetector create(BuildContext context, WidgetRef ref) {
    final chooseIndex = ref.watch(adminTopIndexProvider.notifier);
    Color selectColor(WidgetRef ref, int index) {
      if (chooseIndex.state == index) {
        return const Color.fromRGBO(204, 204, 204, 0.7);
      } else {
        return const Color.fromRGBO(242, 246, 247, 1);
      }
    }

    return GestureDetector(
      child: Container(
        width: widthSize,
        height: 50,
        decoration: BoxDecoration(
            color: selectColor(ref, index),
            border: const Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 2,
              ),
            )),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: (titleColor != null) ? titleColor : Colors.black,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onTap: () {
        onTap;
        if (title == 'ログアウト') {
          showDialog<void>(
            context: context,
            builder: (_) {
              return DefaultAlertDialog(
                title: '本当によろしいですか？',
                content: 'ログアウトします。この操作は取り消せません。',
                textCancel: '戻る',
                textConfirm: 'ログアウト',
                onConfirm: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    // ログアウトに成功した場合
                    ref.watch(loginInfoProvider.notifier).state = false;
                    // if (!mounted) return;
                    context.go("/top");
                  } catch (e) {
                    SnackBarFactory.showSnackBarTop(
                        'エラーが発生しました\nGoogleサインアウト時にエラーが発生しました。もう一度お試し下さい。');
                    debugPrint(
                        'エラーが発生しました: Googleサインアウト時にエラーが発生しました。もう一度お試し下さい。');
                  }
                },
              );
            },
          );
        } else {
          ref.watch(adminTopIndexProvider.notifier).state = index;
        }
      },
    );
  }
}
