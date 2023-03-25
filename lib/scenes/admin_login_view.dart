import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_name/provider/login_info_provider.dart';

class AdminLoginView extends ConsumerStatefulWidget {
  const AdminLoginView({Key? key}) : super(key: key);

  @override
  ConsumerState<AdminLoginView> createState() => _AdminLoginViewState();
}

class _AdminLoginViewState extends ConsumerState<AdminLoginView> {
  // メッセージ表示用
  String infoText = '';
  // 入力したメールアドレス・パスワード
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          color: Colors.white70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.height / 3 * 2,
            padding: EdgeInsets.all(22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "管理者アカウントで\nログインしてください",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 25,
                ),
                // メールアドレス入力
                TextFormField(
                  decoration: InputDecoration(labelText: 'メールアドレス'),
                  onChanged: (String value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                // パスワード入力
                TextFormField(
                  decoration: InputDecoration(labelText: 'パスワード'),
                  obscureText: true,
                  onChanged: (String value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  // メッセージ表示
                  child: Text(infoText),
                ),
                Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // ログイン登録ボタン
                  child: OutlinedButton(
                    child: const Text(
                      'ログイン',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        letterSpacing: 4,
                      ),
                    ),
                    onPressed: () async {
                      try {
                        // メール/パスワードでログイン
                        final FirebaseAuth auth = FirebaseAuth.instance;
                        final result = await auth.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        // ログインに成功した場合
                        ref.watch(loginInfoProvider.notifier).state = true;
                        if (!mounted) return;
                        context.go("/top");
                      }

                      /// サインインに失敗した場合のエラー処理
                      on FirebaseAuthException catch (e) {
                        /// メールアドレスが無効の場合
                        if (e.code == 'invalid-email') {
                          print('メールアドレスが無効です');
                        }

                        /// ユーザーが存在しない場合
                        else if (e.code == 'user-not-found') {
                          print('ユーザーが存在しません');
                        }

                        /// パスワードが間違っている場合
                        else if (e.code == 'wrong-password') {
                          print('パスワードが間違っています');
                        }

                        /// その他エラー
                        else {
                          print('サインインエラー');
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
