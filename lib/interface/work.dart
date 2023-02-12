import 'package:cloud_firestore/cloud_firestore.dart';

class Work {
  final Timestamp createdAt;
  final String name;
  final String imagePath;
  final List<String> tags;
  final List<String> stacks;
  final String text;
  const Work({
    required this.createdAt,
    required this.name,
    required this.imagePath,
    required this.tags,
    required this.stacks,
    required this.text,
  });
}