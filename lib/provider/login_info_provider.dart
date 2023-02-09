import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// true = ログイン済み
final loginInfoProvider =
    StateProvider<bool>((ref) => FirebaseAuth.instance.currentUser != null);
