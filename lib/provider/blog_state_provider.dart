import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_name/interface/blog.dart';
import 'package:portfolio_name/provider/blog_notifier.dart';

final blogStateProvider = StateNotifierProvider<BlogNotifier, List<Blog>>((ref) => BlogNotifier());