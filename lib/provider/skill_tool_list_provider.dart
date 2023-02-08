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
            "ネイティブアプリ(Android/iOS)やWebアプリはもちろん、Chrome拡張の開発経験もあります。"),
    Skill(
        icon: Image.asset('assets/git-logo.png'),
        name: "Git",
        rank: 4,
        text: "大学で1年の頃から学びました。\n"
            "Javaを通してオブジェクト指向設計やデザインパターンについて学習しました。"),
    Skill(
        icon: Image.asset('assets/github-logo.png'),
        name: "GitHub",
        rank: 4,
        text: "ハッカソンにて自然言語処理を行うために学び始めました。\n"
            "このときに制作したのが「しらべるん」です。\n"
            "今後は競プロなどにも活かしていきたいと考えています。"),
    Skill(
        icon: Image.asset('assets/studioone-logo.png'),
        name: "Studio One",
        rank: 2,
        text: "DAWソフトです。\n"
            "趣味程度で、たまにDTMをすることがあります。"),
  ];

  return skillList;
});