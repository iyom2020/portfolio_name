import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_name/component/popup/default_alert_dialog.dart';
import 'package:portfolio_name/component/tag/tag_view.dart';
import 'package:portfolio_name/interface/work.dart';
import 'package:portfolio_name/util/image_util.dart';
import 'package:portfolio_name/util/time_convert.dart';

class AdminEditWorkView extends ConsumerStatefulWidget {
  const AdminEditWorkView(this.work, {Key? key}) : super(key: key);
  final Work work;

  @override
  ConsumerState<AdminEditWorkView> createState() => _AdminEditWorkViewState();
}

class _AdminEditWorkViewState extends ConsumerState<AdminEditWorkView> {
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();

  // 入力した情報
  String name = '';
  Uint8List? infoImage;
  List<String> tags = [];
  String addTagWord = "";
  List<String> stacks = [];
  String addStackWord = "";
  String workInfoText = "";

  @override
  void initState() {
    name = widget.work.name;
    tags = widget.work.tags;
    stacks = widget.work.stacks;
    workInfoText = widget.work.text;
    _controller1.text = widget.work.name;
    _controller2.text = widget.work.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool addTag = false;
    bool addStack = false;
    bool isView = false;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          const Text(
            "WORK 編集",
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
                sectionText("制作物名"),
                TextFormField(
                  controller: _controller1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: "制作物名",
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
                      name = value;
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
                              ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: NetworkImageBuilder(ImageUtil().imgDownloadPath(widget.work.imagePath)),
                              )
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
                      sectionText("制作物タグ"),
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
                                hintText: "制作物タグ名",
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
          StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sectionText("技術スタック"),
                      Wrap(
                        children: (() {
                          List<Widget> selectedTags = [];
                          stacks.forEach((stackName) {
                            selectedTags.add(Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    stacks.remove(stackName);
                                  });
                                },
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: TagView(stackName, null),
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
                                    addStack = !addStack;
                                  });
                                },
                                child: (addStack)
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
                      (addStack)
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
                                hintText: "技術スタック名",
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
                                  addStackWord = value;
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
                                  if (addStackWord != "") {
                                    stacks.add(addStackWord);
                                    addStackWord = "";
                                  }
                                  addStack = !addStack;
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
                sectionText("内容紹介"),
                const SizedBox(height: 10,),
                const SelectableText(
                  "空白行の挿入には\n&nbsp;\nを使用すると上手くいく。",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10,),
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
                                workInfoText = value;
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
                            child: Markdown(data: workInfoText),
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
          InkWell(
            onTap: () {
              setState(() {
                registerDB(name, infoImage, tags, stacks, workInfoText);
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
                  "更新",
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
          InkWell(
            onTap: () {
              setState(() {
                deleteDB();
              });
            },
            child: Container(
              width: 80,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "削除",
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

  Future<void> registerDB(String name, Uint8List? infoImage, List<String> tags,
      List<String> stacks, String workInfoText) async {
    if (name == "") {
      showDialog<void>(
        context: context,
        builder: (_) {
          return const DefaultAlertDialog(
            title: '制作物名が未記入です',
            content: 'この項目は必須です',
            textCancel: '戻る',
          );
        },
      );
      return;
    }
    if (workInfoText == "") {
      showDialog<void>(
        context: context,
        builder: (_) {
          return const DefaultAlertDialog(
            title: '内容紹介が未記入です',
            content: 'この項目は必須です',
            textCancel: '戻る',
          );
        },
      );
      return;
    }

    final time = widget.work.createdAt;
    final workId = TimeConvert(time);
    final dbInstance = FirebaseFirestore.instance;

    if(infoImage != null) await ImageUtil().imgUpload('works/$workId/mainImage', infoImage);

    final document = <String, dynamic>{
      'workName': name,
      'workTags': tags,
      'workStacks': stacks,
      'workInfoText': workInfoText,
    };
    await dbInstance.collection('works').doc(workId).set(document,SetOptions(merge: true));

    showDialog<void>(
      context: context,
      builder: (_) {
        return const DefaultAlertDialog(
          title: '更新が完了しました',
          content: '',
          textCancel: 'OK',
        );
      },
    );
  }

  Future<void> deleteDB()async{
    String workId = TimeConvert(widget.work.createdAt);
    final dbInstance = FirebaseFirestore.instance;

    showDialog<void>(
      context: context,
      builder: (_) {
        return DefaultAlertDialog(
          title: '本当によろしいですか？',
          content: '削除します。この操作は取り消せません。',
          textCancel: '戻る',
          textConfirm: '削除する',
          onConfirm: () async {
            await dbInstance.collection('works').doc(workId).delete();
            await ImageUtil().deletePicture('works/$workId/mainImage');
            // setState(() {
              context.go("/top");
            // });
          },
        );
      },
    );
  }
}
