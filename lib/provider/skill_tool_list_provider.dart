import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_name/interface/skill.dart';

final skillToolListProvider = StateProvider<List<Skill>>((ref) {
  List<Skill> skillList = [
    Skill(
        icon: Image.asset('assets/firebase-logo.png'),
        name: "Firebase",
        rank: 3,
        text: "アプリ制作時に使うDB、OAuthとして重宝しています。\n"
            "本サイトもFirebase Hostingでデプロイしています。\n"
            "ネイティブアプリ(Android/iOS)やWebアプリはもちろん、Chrome拡張の開発経験もあります。"),
    Skill(
        icon: Image.asset('assets/git-logo.png'),
        name: "Git",
        rank: 4,
        text: "人並みには使えます。\n"
            "基本的にGUIツールよりコマンドの方が使いやすいなと思っています。"),
    Skill(
        icon: Image.asset('assets/github-logo.png'),
        name: "GitHub",
        rank: 4,
        text: "共同開発時のツールとしてひと通りは使えます。\n"
            "issue管理やブランチ運用、コンフリクト解消など。\n"
            "あとはGitHub Actionsをもっと活用できれば★5ですね。"),
    Skill(
        icon: Image.asset('assets/studioone-logo.png'),
        name: "Studio One",
        rank: 2,
        text: "DAWソフトです。\n"
            "趣味程度で、たまにDTMをすることがあります。"),
  ];

  return skillList;
});
