import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:portfolio_name/component/markdown/markdown_view.dart';
import 'package:portfolio_name/component/tag/tag_view.dart';
import 'package:portfolio_name/interface/blog.dart';
import 'package:portfolio_name/provider/blog_state_provider.dart';
import 'package:portfolio_name/util/image_util.dart';

class BlogContentsView extends ConsumerStatefulWidget {
  final int blog_id;
  // const BlogContentsView(this.blog_id, {Key? key}) : super(key: key);
  const BlogContentsView({
    super.key,
    required this.blog_id,
  });

  @override
  ConsumerState<BlogContentsView> createState() => _BlogContentsViewState();
}

class _BlogContentsViewState extends ConsumerState<BlogContentsView> {
  late final List<Blog> _blogState = ref.watch(blogStateProvider);
  @override
  Widget build(BuildContext context) {
    // final List<Blog> _blogState = ref.watch(blogStateProvider);
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
      body: _body()
    );
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
                _blogState[widget.blog_id].title,
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
                      DateFormat('yyyy-MM-dd').format(_blogState[widget.blog_id].createdAt.toDate()),
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.grey),
                    ),

                    /// タグ表示
                    Wrap(
                        children: (){
                          List<Widget> list = [];
                          _blogState[widget.blog_id].tags.forEach((tag) {
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
                  child: NetworkImageBuilder(ImageUtil().imgDownloadPath(_blogState[widget.blog_id].imagePath))
              ),

              const SizedBox(height:20),

              SizedBox(
                width: MediaQuery.of(context).size.width / 3 * 2,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                    child: MarkdownView(data: _blogState[widget.blog_id].text),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
