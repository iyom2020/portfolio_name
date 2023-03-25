import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_name/component/tag/tag_view.dart';
import 'package:portfolio_name/interface/work.dart';
import 'package:portfolio_name/provider/work_state_provider.dart';
import 'package:portfolio_name/scenes/admin_edit_work_view.dart';
import 'package:portfolio_name/util/image_util.dart';

final editWorkProvider = StateProvider<Work?>((ref) => null);

class AdminListWorkView extends ConsumerStatefulWidget {
  const AdminListWorkView({Key? key}) : super(key: key);

  @override
  ConsumerState<AdminListWorkView> createState() => _AdminListWorkViewState();
}

class _AdminListWorkViewState extends ConsumerState<AdminListWorkView> {
  late List<Work> _workState = ref.watch(workStateProvider);
  late Work _selectedWork = _workState[0];
  bool isList = true;

  @override
  Widget build(BuildContext context) {
    return (isList) ? _workListView() : _workEditView();
  }

  Widget _workEditView(){
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: (){
              setState(() {
                _workState = ref.watch(workStateProvider);
                isList = true;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: double.infinity - 60),
              child: SizedBox(width:50, height:50, child: Icon(Icons.arrow_back_outlined,size: 50,color: Colors.white,)),
            ),
          ),
          AdminEditWorkView(_selectedWork),
        ],
      ),
    );
  }

  Widget _workListView(){
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.infinity / 15 * 11,
      child: GridView.builder(
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.7,
          // 横1行あたりに表示するWidgetの数
          crossAxisCount:
          ((MediaQuery.of(context).size.width / 15 * 11) /
              200)
              .toInt(),
          // Widget間のスペース（左右）
          mainAxisSpacing: 15,
          // Widget間のスペース（上下）
          crossAxisSpacing: 15,
        ),
        padding: const EdgeInsets.all(4),
        itemCount: ref.watch(workStateProvider).length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                print("WORKを押したよ");
                _selectedWork = _workState[index];
                isList = false;
              });
            },
            child: SizedBox(height: 500,child: _workIcon(_workState[index])),
          );
        },
      ),
    );
  }

  Widget _workIcon(Work work) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// サムネイル
          Container(
            width: 180,
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: NetworkImageBuilder(ImageUtil().imgDownloadPath(work.imagePath)),
            ),
          ),

          /// フレームワーク/言語名
          Text(
            work.name,
            style: const TextStyle(color: Colors.white,fontSize: 16),
          ),

          const SizedBox(height: 4,),

          /// 作品タグ表示
          Wrap(
              children: (){
                List<Widget> list = [];
                work.tags.forEach((tag) {
                  list.add(Padding(
                    padding: const EdgeInsets.only(bottom: 5,right: 5),
                    child: TagView(tag, null),
                  ));
                });
                return list;
              }()
          ),

          const SizedBox(height: 4,),

          /// 作品タグ表示
          Wrap(
              children: (){
                List<Widget> list = [];
                work.stacks.forEach((stack) {
                  list.add(Padding(
                    padding: const EdgeInsets.only(bottom: 5,right: 5),
                    child: TagView(stack, Colors.indigoAccent),
                  ));
                });
                return list;
              }()
          )
        ],
      ),
    );
  }
}
