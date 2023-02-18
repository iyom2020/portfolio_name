import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

/// Pre
class CustomPreBuilder extends MarkdownElementBuilder {
  @override
  Widget visitText(md.Text text, TextStyle? preferredStyle) {
    return Pre(text: text.text);
  }

}

class Pre extends StatelessWidget {
  final String text;

  const Pre({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
            child: SelectableText(
              text,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(
                  fontSize: 16,
                  color: Colors.white,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            final data = ClipboardData(text: text);
            Clipboard.setData(data);
          },
          tooltip: 'クリップボードにコピー',
          icon: const Icon(
            Icons.content_copy_outlined,
            size: 20,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}