import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_name/component/button/admin_top_gesture_detector.dart';
import 'package:portfolio_name/scenes/admin_create_blog_view.dart';
import 'package:portfolio_name/scenes/admin_create_work_view.dart';
import 'package:portfolio_name/scenes/admin_list_work_view.dart';

final adminTopIndexProvider = StateProvider<int>((ref) => 0);

class AdminTopView extends ConsumerWidget {
  const AdminTopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        leading: IconButton(
          onPressed: () {
            context.go("/top");
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text("管理者画面"),
      ),
      body: _bodyWidget(context, ref),
    );
  }

  Widget _bodyWidget(BuildContext context, WidgetRef ref) {
    final chooseIndex = ref.watch(adminTopIndexProvider);
    return Row(
      children: [
        Container(
            width: MediaQuery.of(context).size.width / 4,
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
            ),
            child: Column(
              children: [
                AdminTopGestureDetector(
                  title: 'WORK 新規作成',
                  index: 0,
                  widthSize: MediaQuery.of(context).size.width / 3,
                ).create(context, ref),
                AdminTopGestureDetector(
                  title: 'WORK 変更',
                  index: 1,
                  widthSize: MediaQuery.of(context).size.width / 3,
                ).create(context, ref),
                AdminTopGestureDetector(
                  title: 'BLOG 新規作成',
                  index: 2,
                  widthSize: MediaQuery.of(context).size.width / 3,
                ).create(context, ref),
                AdminTopGestureDetector(
                  title: 'ログアウト',
                  index: 3,
                  widthSize: MediaQuery.of(context).size.width / 3,
                  titleColor: Colors.red,
                ).create(context, ref),
              ],
            )),
        Container(
          width: (MediaQuery.of(context).size.width / 4) * 3,
          child: (() {
            if (chooseIndex == 0) {
              return const AdminCreateWorkView();
            }
            if (chooseIndex == 1) {
              return const AdminListWorkView();
            }
            if (chooseIndex == 2) {
              return const AdminCreateBlogView();
            }
            return Container();
          }()),
        ),
      ],
    );
  }
}
