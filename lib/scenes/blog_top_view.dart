import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:portfolio_name/component/tag/tag_view.dart';
import 'package:portfolio_name/interface/blog.dart';
import 'package:portfolio_name/provider/blog_state_provider.dart';
import 'package:portfolio_name/util/image_util.dart';
import 'package:portfolio_name/util/time_convert.dart';

class BlogTopView extends ConsumerStatefulWidget {
  const BlogTopView({Key? key}) : super(key: key);

  @override
  ConsumerState<BlogTopView> createState() => _BlogTopViewState();
}

class _BlogTopViewState extends ConsumerState<BlogTopView> {

  @override
  Widget build(BuildContext context) {
    final List<Blog> _blogState = ref.watch(blogStateProvider);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.width / 15,
        backgroundColor: Colors.white.withOpacity(0),
        shadowColor: Colors.white.withOpacity(0),
        leading: IconButton(
          onPressed: () {
            context.go("/top");
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        title: Text(
          "BLOG一覧",
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width / 20,
            letterSpacing: MediaQuery.of(context).size.width / 70,
          ),),
      ),
      body: ListView.builder(
        itemCount: _blogState.length,
        itemBuilder: (BuildContext context, int index){
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: InkWell(
              onTap: (){
                final blogId = TimeConvert(_blogState[index].createdAt);
                context.go("/blog/$blogId");
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

                        // SizedBox(height: 20,),

                        // Text(_blogState[index].text,style: Theme.of(context).textTheme.bodyText1,)

                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
