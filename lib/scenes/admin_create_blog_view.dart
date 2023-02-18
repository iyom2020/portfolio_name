import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio_name/component/markdown/markdown_view.dart';
import 'package:portfolio_name/component/popup/default_alert_dialog.dart';
import 'package:portfolio_name/component/tag/tag_view.dart';
import 'package:portfolio_name/util/image_util.dart';
import 'package:portfolio_name/util/time_convert.dart';
import 'package:universal_html/html.dart' as html;

class AdminCreateBlogView extends StatefulWidget {
  const AdminCreateBlogView({Key? key}) : super(key: key);

  @override
  State<AdminCreateBlogView> createState() => _AdminCreateBlogViewState();
}

class _AdminCreateBlogViewState extends State<AdminCreateBlogView> {
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final FocusNode _focusNode1 = FocusNode();

  // 入力した情報
  String title = '';
  Uint8List? infoImage;
  List<String> tags = [];
  String addTagWord = "";
  String blogInfoText = "";

  @override
  void initState() {
    super.initState();

    webComposeEvent([_focusNode1]);
  }

  void webComposeEvent( List<FocusNode> focusNodeList,){
    if( !kIsWeb ) return;

    html.window.document.addEventListener("compositionstart", (event){
      focusNodeList.forEach((_focusNode) {
        if(!_focusNode.hasFocus) return;
        _focusNode.skipTraversal = true;
      });
    });
    html.window.document.addEventListener("compositionend", (event){
      focusNodeList.forEach((_focusNode) {
        if(!_focusNode.skipTraversal) return;
        _focusNode.skipTraversal = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool addTag = false;
    bool isView = false;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          const Text(
            "BLOG 新規作成",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sectionText("タイトル"),
                TextFormField(
                  controller: _controller1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: "タイトル",
                    hintStyle:
                    const TextStyle(fontSize: 12, color: Colors.grey),
                    fillColor: Colors.black26,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black26,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black26,
                        width: 1.0,
                      ),
                    ),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      title = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sectionText("サムネイル"),
                      InkWell(
                        onTap: () async {
                          Uint8List? image = await ImageUtil().getPictureFile();
                          if (image != null) {
                            setState(() {
                              infoImage = image;
                            });
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: (infoImage == null)
                              ? const Center(
                              child: Icon(
                                Icons.add_photo_alternate_outlined,
                                size: 80,
                                color: Colors.black26,
                              ))
                              : Image.memory(infoImage!),
                        ),
                      ),
                    ],
                  ),
                );
              }),
          const SizedBox(
            height: 30,
          ),
          StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sectionText("タグ"),
                      Wrap(
                        children: (() {
                          List<Widget> selectedTags = [];
                          tags.forEach((tagName) {
                            selectedTags.add(Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    tags.remove(tagName);
                                  });
                                },
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: TagView(tagName, null),
                                    ),
                                    const Icon(
                                      Icons.highlight_off,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ));
                          });
                          selectedTags.add(
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    addTag = !addTag;
                                  });
                                },
                                child: (addTag)
                                    ? const Icon(
                                  Icons.remove_circle,
                                  color: Colors.white,
                                  size: 30,
                                )
                                    : const Icon(
                                  Icons.add_circle,
                                  color: Colors.white,
                                  size: 30,
                                )),
                          );
                          return selectedTags;
                        }()),
                      ),
                      (addTag)
                          ?

                      /// タグの追加欄
                      Row(
                        children: [
                          Container(
                            width:
                            MediaQuery.of(context).size.width / 2 - 110,
                            child: TextFormField(
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                hintText: "タグ名",
                                hintStyle: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                                fillColor: Colors.black26,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black26,
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black26,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  addTagWord = value;
                                });
                              },
                            ),
                          ),

                          /// 追加ボタン
                          Container(
                            width: 100,
                            height: 50,
                            margin: const EdgeInsets.only(left: 10),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  if (addTagWord != "") {
                                    tags.add(addTagWord);
                                    addTagWord = "";
                                  }
                                  addTag = !addTag;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: (isView)
                                      ? Colors.black26
                                      : Colors.black54,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      Text(
                                        "追加",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                          : Container(),
                    ],
                  ),
                );
              }),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sectionText("本文"),
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isView = false;
                                    });
                                  },
                                  child: Container(
                                    width: 80,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: (isView)
                                          ? Colors.black26
                                          : Colors.black54,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "編集",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isView = true;
                                    });
                                  },
                                  child: Container(
                                    width: 80,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: (!isView)
                                          ? Colors.black26
                                          : Colors.black54,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "プレビュ",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          (!isView)
                              ? TextFormField(
                            focusNode: _focusNode1,
                            controller: _controller2,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            keyboardType: TextInputType.multiline,
                            minLines: 6,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: "内容紹介",
                              hintStyle: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                              fillColor: Colors.black26,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.black26,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.black26,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            onChanged: (String value) {
                              setState(() {
                                blogInfoText = value;
                              });
                            },
                          )
                              :

                          /// Markdownに対応させる（やる気があれば）（優先度 低）
                          Container(
                            width: double.infinity,
                            height: 250,
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: MarkdownView(data: blogInfoText),
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          addImageView(),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              setState(() {
                registerDB(title, infoImage, tags, blogInfoText);
              });
            },
            child: Container(
              width: 80,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "作成",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    letterSpacing: 3,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Text sectionText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 28,
      ),
    );
  }

  Future<void> registerDB(String title, Uint8List? infoImage, List<String> tags, String blogInfoText) async {
    if (title == "") {
      showDialog<void>(
        context: context,
        builder: (_) {
          return const DefaultAlertDialog(
            title: 'タイトルが未記入です',
            content: 'この項目は必須です',
            textCancel: '戻る',
          );
        },
      );
      return;
    }
    if (infoImage == null) {
      showDialog<void>(
        context: context,
        builder: (_) {
          return const DefaultAlertDialog(
            title: 'サムネイルが設定されていません',
            content: 'この項目は必須です',
            textCancel: '戻る',
          );
        },
      );
      return;
    }
    if (blogInfoText == "") {
      showDialog<void>(
        context: context,
        builder: (_) {
          return const DefaultAlertDialog(
            title: '本文が未記入です',
            content: 'この項目は必須です',
            textCancel: '戻る',
          );
        },
      );
      return;
    }

    final time = Timestamp.fromDate(DateTime.now());
    final blogId = TimeConvert(time);
    final dbInstance = FirebaseFirestore.instance;

    await ImageUtil().imgUpload('blogs/$blogId/mainImage', infoImage);

    final document = <String, dynamic>{
      'blogTitle': title,
      'blogImage': 'blogs/$blogId/mainImage',
      'blogTags': tags,
      'blogInfoText': blogInfoText,
      'createdAt': time,
    };
    await dbInstance.collection('blogs').doc(blogId).set(document);

    showDialog<void>(
      context: context,
      builder: (_) {
        return const DefaultAlertDialog(
          title: '登録が完了しました',
          content: '',
          textCancel: 'OK',
        );
      },
    );
    setState(() {
      _controller1.clear();
      _controller2.clear();
      this.title = '';
      this.infoImage = null;
      this.tags = [];
      addTagWord = "";
      this.blogInfoText = "";
    });
  }

  Widget addImageView(){
    List<String> imageUrl = [];
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  "画像のリンク取得",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10,),
              ListView.separated(
                shrinkWrap: true,
                itemCount: imageUrl.length + 1,
                itemBuilder: (BuildContext context, int index){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          Uint8List? image = await ImageUtil().getPictureFile();
                          if (image != null) {
                            final time = Timestamp.fromDate(DateTime.now());
                            final imgId = TimeConvert(time);
                            await ImageUtil().imgUpload('blogs/$imgId.jpg', image);
                            (index == imageUrl.length) ?
                            imageUrl.add(await ImageUtil().imgDownloadPath('blogs/$imgId.jpg')) :
                            imageUrl[index] = await ImageUtil().imgDownloadPath('blogs/$imgId.jpg');
                            setState(() {
                              // infoImage = image;
                            });
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 6,
                          height: MediaQuery.of(context).size.width / 9,
                          decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: (index == imageUrl.length)
                              ? const Center(
                              child: Icon(
                                Icons.add_photo_alternate_outlined,
                                size: 50,
                                color: Colors.black26,
                              ))
                              : Image.network(imageUrl[index]),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width/3 - 10,
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                              child: SelectableText(
                                (index == imageUrl.length) ? "" : '![](${imageUrl[index]})',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              final data = (index == imageUrl.length) ? const ClipboardData(text: "") : ClipboardData(text: '![](${imageUrl[index]})');
                              Clipboard.setData(data);
                            },
                            tooltip: 'クリップボードにコピー',
                            icon: const Icon(
                              Icons.content_copy_outlined,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index){
                  return const SizedBox(height: 10);
                },
              ),
            ],
          ),
        );
      }
    );
  }
}
