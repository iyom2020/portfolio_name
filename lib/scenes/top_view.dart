import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_name/component/markdown/markdown_view.dart';
import 'package:portfolio_name/component/tag/tag_view.dart';
import 'package:portfolio_name/interface/skill.dart';
import 'package:portfolio_name/interface/work.dart';
import 'package:portfolio_name/provider/login_info_provider.dart';
import 'package:portfolio_name/provider/skill_language_list_provider.dart';
import 'package:portfolio_name/provider/skill_tool_list_provider.dart';
import 'package:portfolio_name/provider/work_state_provider.dart';
import 'package:portfolio_name/util/image_util.dart';
import 'package:url_launcher/url_launcher.dart';

class TopView extends ConsumerStatefulWidget {
  const TopView({Key? key}) : super(key: key);

  @override
  ConsumerState<TopView> createState() => _TopViewState();
}

class _TopViewState extends ConsumerState<TopView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final List<Skill> _languageState = ref.watch(skillLanguageListProvider);
  late final List<Skill> _toolState = ref.watch(skillToolListProvider);
  late Skill _selectedSkill = _languageState[0];
  late final List<Work> _workState = ref.watch(workStateProvider);
  late int _selectedId = 0;
  late Work _selectedWork = _workState[0];
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        shadowColor: Colors.white.withOpacity(0),
        actions: <Widget>[
          // カスタムしたボタン
          InkWell(
            onTap: () => _scaffoldKey.currentState!.openEndDrawer(),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                const Icon(
                  Icons.menu,
                  size: 50,
                ),
              ],
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                context.go("/blog");
              },
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ),
                    )),
                child: const Center(
                  child: Text(
                    "BLOG PAGE",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async{
                final Uri _url = Uri.parse('https://docs.google.com/forms/d/e/1FAIpQLSc84sNiDeRzaKkcrlCQmQiL4oqB6RVYIWiXbr9NZR9ZFr-7zg/viewform?usp=sf_link');
                if (!await launchUrl(_url)) {
                  throw Exception('$_url は開けません');
                }
              },
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ),
                    )),
                child: const Center(
                  child: Text(
                    "CONTACT",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            (ref.watch(loginInfoProvider.notifier).state)
                ? InkWell(
                    onTap: () {
                      context.go("/admin");
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          // color: selectColor(ref, index),
                          border: const Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                      )),
                      child: Center(
                        child: Text(
                          "管理者画面",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _top(),
          SizedBox(
            height: MediaQuery.of(context).size.width / 10,
          ),
          _about(),
          SizedBox(
            height: MediaQuery.of(context).size.width / 10,
          ),
          _award(),
          SizedBox(
            height: MediaQuery.of(context).size.width / 10,
          ),
          _skill(),
          SizedBox(
            height: MediaQuery.of(context).size.width / 10,
          ),
          _works(),
          SizedBox(
            height: MediaQuery.of(context).size.width / 10,
          ),
          _blog(),
          SizedBox(
            height: MediaQuery.of(context).size.width / 10,
          ),
          _contact(),
          SizedBox(
            height: MediaQuery.of(context).size.width / 10,
          ),
        ],
      ),
    );
  }

  /// TOP
  Widget _top() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Opacity(
              opacity: 0.5,
              child: NetworkImageBuilder(
                  ImageUtil().imgDownloadPath("general/top.jpg"))),
        ),
        Text(
          "KOSHIRO's portfolio",
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width / 15,
            letterSpacing: MediaQuery.of(context).size.width / 65,
          ),
        ),
      ],
    );
  }

  /// ABOUT
  Widget _about() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// ABOUT画像
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 3,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width / 12),
                    child: NetworkImageBuilder(
                        ImageUtil().imgDownloadPath("general/about.jpg"))),
              ),
              Text(
                "ABOUT",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width / 18,
                  letterSpacing: MediaQuery.of(context).size.width / 70,
                ),
              ),
            ],
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width / 10,
          ),

          /// 自己紹介文
          Container(
            width: MediaQuery.of(context).size.width / 5 * 2,
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyText1,
                children: [
                  TextSpan(
                    text: "小代翔大",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: (MediaQuery.of(context).size.width / 40 < 32)
                          ? 32
                          : MediaQuery.of(context).size.width / 40,
                      letterSpacing: MediaQuery.of(context).size.width / 70,
                    ),
                  ),
                  TextSpan(
                    text: "(Koshiro Shota)\n",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: (MediaQuery.of(context).size.width / 45 < 26)
                          ? 26
                          : MediaQuery.of(context).size.width / 45,
                    ),
                  ),
                  const TextSpan(
                    text: "Flutterエンジニア\n\n",
                    style: TextStyle(fontSize: 18),
                  ),
                  const TextSpan(
                    text: "Flutterに魅了されたエンジニアです。\n"
                        "近畿大学理工学部情報学科に在籍。2023年4月より4年生となります。\n\n"
                        "プログラミングとは中学3年生の頃からの付き合い。\n"
                        "初めてのプログラミング言語はHSP(Hot Soup Processor)でした。\n\n"
                        "AR/XRに強く興味があり、今は関連技術の習得に必死です。",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// AWARD
  Widget _award() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// 受賞歴
          Container(
            width: MediaQuery.of(context).size.width / 3,
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyText1,
                children: [
                  TextSpan(
                    text: "受賞歴\n",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: (MediaQuery.of(context).size.width / 40 < 32)
                          ? 32
                          : MediaQuery.of(context).size.width / 40,
                      letterSpacing: MediaQuery.of(context).size.width / 70,
                    ),
                  ),
                  const TextSpan(
                    text: "\n"
                        "パソコン甲子園 2017 新人賞\n"
                        "日本情報オリンピック 第17回 2017 敢闘賞\n"
                        "JPHACKS 2022 Finalist / エヌ・ティ・ティレゾナント賞\n"
                        "技育CAMP vol.9 2022 努力賞\n",
                    style: TextStyle(height: 2),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width / 10,
          ),

          /// AWARD画像
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width / 12),
                ),
                width: MediaQuery.of(context).size.width / 5 * 2,
                child: Opacity(
                  opacity: 0.5,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width / 12),
                      child: NetworkImageBuilder(
                          ImageUtil().imgDownloadPath("general/award.jpg"))),
                ),
              ),
              Text(
                "AWARD",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width / 18,
                  letterSpacing: MediaQuery.of(context).size.width / 70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// SKILL
  Widget _skill() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// SKILL画像
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width / 12),
                  ),
                  width: MediaQuery.of(context).size.width / 3,
                  child: Opacity(
                    opacity: 0.5,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width / 12),
                        child: NetworkImageBuilder(
                            ImageUtil().imgDownloadPath("general/skill.jpg"))),
                  ),
                ),
                Text(
                  "SKILL",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width / 18,
                    letterSpacing: MediaQuery.of(context).size.width / 70,
                  ),
                ),
              ],
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width / 10,
            ),

            /// SKILL一覧
            Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 300,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 5 * 2,
                    height: MediaQuery.of(context).size.width / 4,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            "言語/フレームワーク",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  (MediaQuery.of(context).size.width / 40 < 32)
                                      ? 32
                                      : MediaQuery.of(context).size.width / 40,
                            ),
                          ),
                          SizedBox(
                            height: ((MediaQuery.of(context).size.width/5*2) *
                                11/(((MediaQuery.of(context).size.width/5*2)/150).toInt() *10)+15) *
                                (_toolState.length/((MediaQuery.of(context).size.width/5*2)/150).toInt()).ceil(),
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                // 横1行あたりに表示するWidgetの数
                                crossAxisCount:
                                    ((MediaQuery.of(context).size.width / 5 * 2) /
                                            150)
                                        .toInt(),
                                // Widget間のスペース（左右）
                                mainAxisSpacing: 15,
                                // Widget間のスペース（上下）
                                // crossAxisSpacing: 15,
                                childAspectRatio: 10/11,
                              ),
                              padding: const EdgeInsets.all(4),
                              itemCount: _languageState.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: 100,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _selectedSkill = _languageState[index];
                                      });
                                    },
                                    child: _skillIcon(_languageState[index]),
                                  ),
                                );
                              },
                            ),
                          ),
                          Text(
                            "ツール/その他",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  (MediaQuery.of(context).size.width / 40 < 32)
                                      ? 32
                                      : MediaQuery.of(context).size.width / 40,
                            ),
                          ),
                          SizedBox(
                            height: ((MediaQuery.of(context).size.width/5*2) *
                                11/(((MediaQuery.of(context).size.width/5*2)/150).toInt() *10)+15) *
                                (_toolState.length/((MediaQuery.of(context).size.width/5*2)/150).toInt()).ceil(),
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                // 横1行あたりに表示するWidgetの数
                                crossAxisCount:
                                    ((MediaQuery.of(context).size.width / 5 * 2) /
                                            150)
                                        .toInt(),
                                // Widget間のスペース（左右）
                                mainAxisSpacing: 15,
                                // Widget間のスペース（上下）
                                // crossAxisSpacing: 15,
                                childAspectRatio: 10/11
                              ),
                              padding: const EdgeInsets.all(4),
                              itemCount: _toolState.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  // width: 100,
                                  height: 500,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _selectedSkill = _toolState[index];
                                      });
                                    },
                                    child: _skillIcon(_toolState[index]),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                /// SKILL詳細
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 200,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 5 * 2,
                    // height: 200,
                    child: Card(
                      color: Colors.black26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// アイコン
                          Container(
                              margin: EdgeInsets.all(15),
                              child: _skillIcon(_selectedSkill)),

                          /// コメント
                          Container(
                              width:
                                  MediaQuery.of(context).size.width / 5 * 2 - 155,
                              margin: const EdgeInsets.only(right: 15),
                              child: Text(
                                _selectedSkill.text,
                                style: Theme.of(context).textTheme.bodyText1,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _skillIcon(Skill skill) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// ロゴ
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(50),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: skill.icon,
          ),
        ),

        /// ランクの★表記
        () {
          /// TODO RichTextを使って★と☆のサイズを変える
          String rankStar = "";
          for (int i = 0; i < skill.rank; i++) {
            rankStar += "★";
          }
          for (int i = skill.rank; i < 5; i++) {
            rankStar += "☆";
          }
          return Text(
            rankStar,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          );
        }(),

        /// フレームワーク/言語名
        Text(
          skill.name,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }


  /// WORKS
  Widget _works() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
        return Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              /// WORKS画像
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width / 12),
                    ),
                    width: MediaQuery.of(context).size.width / 3 * 2,
                    child: Opacity(
                      opacity: 0.5,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width / 8),
                          child: NetworkImageBuilder(
                              ImageUtil().imgDownloadPath("general/works.jpg"))),
                    ),
                  ),
                  Text(
                    "WORKS",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width / 18,
                      letterSpacing: MediaQuery.of(context).size.width / 70,
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: MediaQuery.of(context).size.width / 15,
              ),

              (ref.watch(workStateProvider).isNotEmpty) ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: (){
                      setState(() {
                        if(_selectedId > 0){
                          _selectedId--;
                          _selectedWork = _workState[_selectedId];
                        }
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width / 4,
                      child: Icon(
                        Icons.arrow_left_outlined,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// サムネイル
                      Container(
                        width: MediaQuery.of(context).size.width / 5*2,
                        // height: MediaQuery.of(context).size.width / 3,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: NetworkImageBuilder(ImageUtil().imgDownloadPath(_selectedWork.imagePath))),
                      ),

                      SizedBox(
                        width: MediaQuery.of(context).size.width / 20,
                      ),

                      /// WORK詳細
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.width / 4,
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _selectedWork.name,
                                style: GoogleFonts.notoSansJavanese(
                                  textStyle: const TextStyle(
                                    height: 1.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  color: Colors.white,
                                  fontSize:
                                  (MediaQuery.of(context).size.width / 40 < 32)
                                      ? 32
                                      : (MediaQuery.of(context).size.width / 40 > 48) ? 48 : MediaQuery.of(context).size.width / 40,
                                ),
                              ),

                              /// 作品タグ表示
                              Wrap(
                                  children: (){
                                    List<Widget> list = [];
                                    _selectedWork.tags.forEach((tag) {
                                      list.add(Padding(
                                        padding: const EdgeInsets.only(bottom: 5,right: 5),
                                        child: TagView(tag, null),
                                      ));
                                    });
                                    return list;
                                  }()
                              ),

                              /// 作品タグ表示
                              Wrap(
                                  children: (){
                                    List<Widget> list = [];
                                    _selectedWork.stacks.forEach((stack) {
                                      list.add(Padding(
                                        padding: const EdgeInsets.only(bottom: 5,right: 5),
                                        child: TagView(stack, Colors.indigoAccent),
                                      ));
                                    });
                                    return list;
                                  }()
                              ),

                              const SizedBox(height: 20,),

                              MarkdownView(data: _selectedWork.text,),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: (){
                      setState(() {
                        if(_selectedId < _workState.length-1){
                          _selectedId++;
                          _selectedWork = _workState[_selectedId];
                        }
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width / 4,
                      child: Icon(
                        Icons.arrow_right_outlined,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ):Container(),

              // const SizedBox(height: 20,),

              SizedBox(
                height: 400,
                width: MediaQuery.of(context).size.width / 15 * 11,
                child: GridView.builder(
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 6/5,
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
                          _selectedId = index;
                          _selectedWork = _workState[index];
                        });
                      },
                      // child: SizedBox(height: 500,child: _workIcon(_workState[index])),
                      child: Center(child: _workIcon(_workState[index])),
                    );
                  },
                ),
              ),

            ],
          ),
        );
      }
    );
  }

  Widget _workIcon(Work work) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// サムネイル
          SizedBox(
            width: 180,
            height: 120,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 180,
                  maxHeight: 120,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: NetworkImageBuilder(ImageUtil().imgDownloadPath(work.imagePath)),
                ),
              ),
            ),
          ),

          /// 作品名
          Text(
            work.name,
            style: const TextStyle(color: Colors.white,fontSize: 16),
          ),

          // const SizedBox(height: 4,),
          //
          // /// 作品タグ表示
          // Wrap(
          //   children: (){
          //     List<Widget> list = [];
          //     work.tags.forEach((tag) {
          //       list.add(Padding(
          //         padding: const EdgeInsets.only(bottom: 5,right: 5),
          //         child: TagView(tag, null),
          //       ));
          //     });
          //     return list;
          //   }()
          // ),
          //
          // const SizedBox(height: 4,),
          //
          // /// 作品タグ表示
          // Wrap(
          //     children: (){
          //       List<Widget> list = [];
          //       work.stacks.forEach((stack) {
          //         list.add(Padding(
          //           padding: const EdgeInsets.only(bottom: 5,right: 5),
          //           child: TagView(stack, Colors.indigoAccent),
          //         ));
          //       });
          //       return list;
          //     }()
          // )
        ],
      ),
    );
  }

  /// BLOG
  Widget _blog() {
    Color hoverColor = Colors.black26;
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// BLOG画像
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width / 12),
                ),
                width: MediaQuery.of(context).size.width / 3,
                child: Opacity(
                  opacity: 0.5,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width / 12),
                      child: NetworkImageBuilder(
                          ImageUtil().imgDownloadPath("general/blog.jpg"))),
                ),
              ),
              Text(
                "BLOG",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width / 18,
                  letterSpacing: MediaQuery.of(context).size.width / 70,
                ),
              ),
            ],
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width / 10,
          ),

          /// 説明文
          Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                  "他愛のない日常をお送りします。\n"
                  "不定期更新ですが、長く暖かい目で待って下さいませ。",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    height: 3,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),

              StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return InkWell(
                      onTap: () {
                        context.go("/blog");
                      },
                      onHover: (isHover){
                        setState((){
                          if(isHover){
                            hoverColor = Colors.black54;
                          }else{
                            hoverColor = Colors.black26;
                          }
                        });
                      },
                      child: Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                          color: hoverColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "ブログページはこちら",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              letterSpacing: 3,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// CONTACT
  Widget _contact() {
    Color hoverColor = Colors.black26;
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// 説明文
          Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                  "ご連絡はこちらよりお待ちしております。\n"
                      "どんな内容でも構いません。お気軽にどうぞ。"
                      ,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    height: 3,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),

              StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    final Uri _url = Uri.parse('https://docs.google.com/forms/d/e/1FAIpQLSc84sNiDeRzaKkcrlCQmQiL4oqB6RVYIWiXbr9NZR9ZFr-7zg/viewform?usp=sf_link');
                    return InkWell(
                      onTap: ()async{
                        if (!await launchUrl(_url)) {
                          throw Exception('$_url は開けません');
                        }
                      },
                      onHover: (isHover){
                        setState((){
                          if(isHover){
                            hoverColor = Colors.black54;
                          }else{
                            hoverColor = Colors.black26;
                          }
                        });
                      },
                      child: Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                          color: hoverColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "お問い合わせ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              letterSpacing: 3,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ],
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width / 10,
          ),

          /// CONTACT画像
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width / 12),
                ),
                width: MediaQuery.of(context).size.width / 3,
                child: Opacity(
                  opacity: 0.5,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width / 12),
                      child: NetworkImageBuilder(
                          ImageUtil().imgDownloadPath("general/contact.jpg"))),
                ),
              ),
              Text(
                "CONTACT",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width / 18,
                  letterSpacing: MediaQuery.of(context).size.width / 80,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
