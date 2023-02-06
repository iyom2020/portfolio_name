import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopView extends ConsumerStatefulWidget {
  const TopView({Key? key}) : super(key: key);

  @override
  ConsumerState<TopView> createState() => _TopViewState();
}

class _TopViewState extends ConsumerState<TopView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("トップ画面だよ"),
      ),
    );
  }
}
