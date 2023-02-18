import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

/// H5
class CustomHeader5Builder extends MarkdownElementBuilder {
  @override
  Widget visitText(md.Text text, TextStyle? preferredStyle) {
    return H5(text: text.text);
  }
}
class H5 extends StatelessWidget {
  final String text;

  const H5({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
          text: text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            letterSpacing: 1.5,
          )),
    );
  }
}