import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:portfolio_name/component/tag/tag_view.dart';
import 'package:portfolio_name/interface/blog.dart';
import 'package:portfolio_name/interface/work.dart';
import 'package:portfolio_name/provider/blog_state_provider.dart';
import 'package:portfolio_name/scenes/admin_edit_blog_view.dart';
import 'package:portfolio_name/util/image_util.dart';

final editBlogProvider = StateProvider<Blog?>((ref) => null);

class AdminListBlogView extends ConsumerStatefulWidget {
  const AdminListBlogView({Key? key}) : super(key: key);

  @override
  ConsumerState<AdminListBlogView> createState() => _AdminListBlogViewState();
}

class _AdminListBlogViewState extends ConsumerState<AdminListBlogView> {
  late List<Blog> _blogState;
  late Blog _selectedBlog = _blogState[0];
  bool isList = true;

  @override
  Widget build(BuildContext context) {
    _blogState = ref.watch(blogStateProvider);
    return (isList) ? _blogListView() : _blogEditView();
  }

  Widget _blogEditView(){
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: (){
              setState(() {
                _blogState = ref.watch(blogStateProvider);
                isList = true;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: double.infinity - 60),
              child: SizedBox(width:50, height:50, child: Icon(Icons.arrow_back_outlined,size: 50,color: Colors.white,)),
            ),
          ),
          AdminEditBlogView(_selectedBlog),
        ],
      ),
    );
  }

  Widget _blogListView(){
    return ListView.builder(
        itemCount: _blogState.length,
        itemBuilder: (BuildContext context, int index){
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: InkWell(
              onTap: (){
                setState(() {
                  print("BLOGを押したよ");
                  _selectedBlog = _blogState[index];
                  isList = false;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// サムネイル
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.width / 5,
                      maxWidth: MediaQuery.of(context).size.width / 3,
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: NetworkImageBuilder(ImageUtil().imgDownloadPath(_blogState[index].imagePath))),
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.width / 20,
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _blogState[index].title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:
                            (MediaQuery.of(context).size.width / 40 < 32)
                                ? 32
                                : MediaQuery.of(context).size.width / 40,
                            letterSpacing: MediaQuery.of(context).size.width / 80,
                          ),
                        ),

                        Text(
                          DateFormat('yyyy-MM-dd').format(_blogState[index].createdAt.toDate()),
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.grey),
                        ),

                        /// タグ表示
                        Wrap(
                            children: (){
                              List<Widget> list = [];
                              _blogState[index].tags.forEach((tag) {
                                list.add(Padding(
                                  padding: const EdgeInsets.only(bottom: 5,right: 5),
                                  child: TagView(tag, null),
                                ));
                              });
                              return list;
                            }()
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
