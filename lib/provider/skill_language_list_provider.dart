import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_name/interface/skill.dart';

final skillLanguageListProvider = StateProvider<List<Skill>>((ref) {
  List<Skill> skillList = [
    Skill(
        icon: Image.asset('assets/flutter-logo.png'),
        name: "Flutter(Dart)",
        rank: 4,
        text: "最もよく使用しているフレームワーク(言語)です。\n"
            "ネイティブアプリ(Android/iOS)やWebアプリはもちろん、Chrome拡張の開発経験もあります。"),
    Skill(
        icon: Image.asset('assets/java-logo.png'),
        name: "Java",
        rank: 4,
        text: "大学で1年の頃から学びました。\n"
            "Javaを通してオブジェクト指向設計やデザインパターンについて学習しました。"),
    Skill(
        icon: Image.asset('assets/python-logo.png'),
        name: "Python",
        rank: 2,
        text: "ハッカソンにて自然言語処理を行うために学び始めました。\n"
            "このときに制作したのが「しらべるん」です。\n"
            "今後は競プロなどにも活かしていきたいと考えています。"),
    Skill(
        icon: Image.asset('assets/cp-logo.png'),
        name: "C++",
        rank: 1,
        text: "中学3年生～高校1年生の頃、C++で競プロに取り組んでいました。\n"
            "最近はあまり触っていないため忘れてきている気がします。"),
  ];

  return skillList;
});
