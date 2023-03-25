import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_name/interface/blog.dart';

class BlogNotifier extends StateNotifier<List<Blog>> {
  BlogNotifier() : super([]) {
    // これは初期化処理１度だけ実行されます
    // ここでFirestoreの情報を取得
    _readFirebaseDocument();
  }

  // Firebaseの読み込みを行う関数
  // 対象Documentはworks
  void _readFirebaseDocument() {
    List<Blog> list = [];
    final store = FirebaseFirestore.instance;
    final snapshot = store.collection("blogs").orderBy('createdAt', descending: true).snapshots();
    snapshot.listen((querySnapshot) {
      state = [];
      list = [];
      querySnapshot.docs.forEach((QueryDocumentSnapshot documentSnapshot) {
        list.add(Blog(
          createdAt: documentSnapshot.get("createdAt") as Timestamp,
          title: documentSnapshot.get("blogTitle")!,
          imagePath: documentSnapshot.get("blogImage")!,
          tags: documentSnapshot.get("blogTags").cast<String>(),
          text: documentSnapshot.get("blogInfoText")!,
        ));
        state = [...list];
      });
    });
  }
}