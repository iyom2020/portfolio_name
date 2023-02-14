import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_name/interface/work.dart';

class WorkNotifier extends StateNotifier<List<Work>> {
  WorkNotifier() : super([]) {
    // これは初期化処理１度だけ実行されます
    // ここでFirestoreの情報を取得
    _readFirebaseDocument();
  }

  // Firebaseの読み込みを行う関数
  // 対象Documentはworks
  void _readFirebaseDocument() {
    List<Work> list = [];
    final store = FirebaseFirestore.instance;
    final snapshot = store.collection("works").orderBy('createdAt').snapshots();
    snapshot.listen((querySnapshot) {
      state = [];
      list = [];
      querySnapshot.docs.forEach((QueryDocumentSnapshot documentSnapshot) {
        list.add(Work(
          createdAt: documentSnapshot.get("createdAt") as Timestamp,
          name: documentSnapshot.get("workName")!,
          imagePath: documentSnapshot.get("workImage")!,
          tags: documentSnapshot.get("workTags").cast<String>(),
          stacks: documentSnapshot.get("workStacks").cast<String>(),
          text: documentSnapshot.get("workInfoText")!,
        ));
        state = [...list];
      });
    });
  }
}