import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:portfolio_name/component/markdown/custom_builder/custom_header1_builder.dart';
import 'package:portfolio_name/component/markdown/custom_builder/custom_header2_builder.dart';
import 'package:portfolio_name/component/markdown/custom_builder/custom_header3_builder.dart';
import 'package:portfolio_name/component/markdown/custom_builder/custom_header4_builder.dart';
import 'package:portfolio_name/component/markdown/custom_builder/custom_header5_builder.dart';
import 'package:portfolio_name/component/markdown/custom_builder/custom_header6_builder.dart';
import 'package:portfolio_name/component/markdown/custom_builder/custom_pre_builder.dart';

class MarkdownView extends StatelessWidget {
  const MarkdownView({Key? key, required this.data}) : super(key: key);
  final String data;

  @override
  Widget build(BuildContext context) {
    return Markdown(
        data: data,
        selectable: true,
        styleSheet: MarkdownStyleSheet.fromTheme(ThemeData(
            textTheme: const TextTheme(
                bodyText2: TextStyle(
                    fontSize: 16,
                    color: Colors.white
                )
            ),

        )).copyWith(
          blockquoteDecoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Colors.grey,
                width: 3,
              ),
            ),
          ),
          tableBorder: TableBorder.all(color: Colors.white),
          horizontalRuleDecoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white60,
                width: 3,
              ),
            ),
          ),
          code: const TextStyle(
            backgroundColor: Colors.black,
            color: Colors.white,
            fontSize: 16,
          ),
          codeblockDecoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        builders: {
          'h1': CustomHeader1Builder(),
          'h2': CustomHeader2Builder(),
          'h3': CustomHeader3Builder(),
          'h4': CustomHeader4Builder(),
          'h5': CustomHeader5Builder(),
          'h6': CustomHeader6Builder(),
          'pre': CustomPreBuilder(),
        },
      imageBuilder: (uri, title, alt) {
        return Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/30,0,MediaQuery.of(context).size.width/30,0),
            child: Image.network(
              uri.toString(),
            ),
          ),
        );
      },
    );
  }
}

