import 'package:cloud_firestore/cloud_firestore.dart';

class Blog {
  final Timestamp createdAt;
  final String title;
  final String imagePath;
  final List<String> tags;
  final String text;
  const Blog({
    required this.createdAt,
    required this.title,
    required this.imagePath,
    required this.tags,
    required this.text,
  });
}