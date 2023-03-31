import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:portfolio_name/component/markdown/markdown_view.dart';
import 'package:portfolio_name/component/tag/tag_view.dart';
import 'package:portfolio_name/interface/blog.dart';
import 'package:portfolio_name/provider/blog_state_provider.dart';
import 'package:portfolio_name/util/image_util.dart';
import 'package:portfolio_name/util/time_convert.dart';

class BlogContentsView extends ConsumerStatefulWidget {
  final int blogId;
  // const BlogContentsView(this.blog_id, {Key? key}) : super(key: key);
  const BlogContentsView({
    super.key,
    required this.blogId,
  });

  @override
  ConsumerState<BlogContentsView> createState() => _BlogContentsViewState();
}

class _BlogContentsViewState extends ConsumerState<BlogContentsView> {
  late List<Blog> _blogState;
  late Blog selectedBlog;
  @override
  Widget build(BuildContext context) {
    _blogState = ref.watch(blogStateProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        shadowColor: Colors.white.withOpacity(0),
        leading: IconButton(
          onPressed: () {
            context.go("/blog");
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      /// TODO 404対応する
      body: (existBlog(widget.blogId)) ? _body() : null,
    );
  }

  bool existBlog(int blogId){
    bool check = false;
    _blogState.forEach((blog) {
      if(TimeConvert(blog.createdAt) == blogId.toString()){
        check = true;
        selectedBlog = blog;
      }
    });
    return check;
  }

  Widget _body(){
    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 3 * 2,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height:20),
              Text(
                selectedBlog.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize:
                  (MediaQuery.of(context).size.width / 25 < 32)
                      ? 32
                      : MediaQuery.of(context).size.width / 25,
                  letterSpacing: MediaQuery.of(context).size.width / 80,
                ),
              ),
              const SizedBox(height:8),

              SizedBox(
                width: MediaQuery.of(context).size.width / 3 * 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('yyyy-MM-dd').format(selectedBlog.createdAt.toDate()),
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.grey),
                    ),

                    /// タグ表示
                    Wrap(
                        children: (){
                          List<Widget> list = [];
                          selectedBlog.tags.forEach((tag) {
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

              const SizedBox(height:20),

              /// サムネイル
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: NetworkImageBuilder(ImageUtil().imgDownloadPath(selectedBlog.imagePath))
              ),

              const SizedBox(height:20),

              SizedBox(
                width: MediaQuery.of(context).size.width / 3 * 2,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                    child: MarkdownView(data: selectedBlog.text),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
