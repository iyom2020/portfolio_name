import 'package:flutter/material.dart';

Widget TagView(String tagName, Color? tagColor) {
  Color _tagColor = (tagColor != null) ? tagColor : Colors.indigo;
  return Container(
    padding: EdgeInsets.only(top: 5, bottom: 5, left: 7, right: 7),
    decoration: BoxDecoration(
      color: _tagColor,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(5,0,5,0),
      child: Text(
        tagName,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    ),
  );
}
