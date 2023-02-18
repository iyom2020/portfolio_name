import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

/// H6
class CustomHorizontalRuleBuilder extends MarkdownElementBuilder {
  @override
  Widget visitText(md.Text text, TextStyle? preferredStyle) {
    return HR(text: text.text);
  }
}
class HR extends StatelessWidget {
  final String text;

  const HR({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white60,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}