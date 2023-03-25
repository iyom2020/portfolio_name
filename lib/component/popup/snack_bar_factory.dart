import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

///
/// SnackBarのファクトリ
///
class SnackBarFactory {
  /// 画面上部にスナックバーを表示する
  static void showSnackBarTop(
    String message, {
    Color backgroundColor = const Color.fromRGBO(127, 201, 237, 1.0),
    Duration duration = const Duration(seconds: 3),
  }) {
    BotToast.showCustomNotification(
      toastBuilder: (_) {
        return Container(
          constraints: const BoxConstraints(minWidth: double.infinity),
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            message,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                height: 1),
          ),
        );
      },
      animationDuration: const Duration(milliseconds: 200),
      duration: duration,
    );
  }

  /// 画面上部にアラート用スナックバーを表示する
  static void showAlertSnackBarTop(String message) =>
      showSnackBarTop(message, backgroundColor: Colors.red);

  /// ローディングを表示
  static void showLoading() {
    BotToast.showCustomLoading(
      toastBuilder: (_) {
        return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(
              color: Colors.green,
            ));
      },
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.5),
      backButtonBehavior: BackButtonBehavior.ignore,
    );
  }

  /// ローディングを非表示
  static void hideLoading() {
    BotToast.closeAllLoading();
  }
}
