import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_name/interface/work.dart';
import 'package:portfolio_name/provider/work_notifier.dart';

final workStateProvider = StateNotifierProvider<WorkNotifier, List<Work>>((ref) => WorkNotifier());