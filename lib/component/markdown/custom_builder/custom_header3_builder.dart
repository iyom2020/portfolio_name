import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

/// H3
class CustomHeader3Builder extends MarkdownElementBuilder {
  @override
  Widget visitText(md.Text text, TextStyle? preferredStyle) {
    return H3(text: text.text);
  }
}
class H3 extends StatelessWidget {
  final String text;

  const H3({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
          text: text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 21.5,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          )),
    );
  }
}