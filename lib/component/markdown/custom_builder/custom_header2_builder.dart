import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

/// H2
class CustomHeader2Builder extends MarkdownElementBuilder {
  @override
  Widget visitText(md.Text text, TextStyle? preferredStyle) {
    return H2(text: text.text);
  }
}
class H2 extends StatelessWidget {
  final String text;

  const H2({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white60,
            width: 0.5,
          ),
        ),
      ),
      child: SelectableText.rich(
        TextSpan(
            text: text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
            )),
      ),
    );
  }
}