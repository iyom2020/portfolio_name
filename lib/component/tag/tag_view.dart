import 'package:flutter/material.dart';

Widget TagView(String tagName, Color? tagColor) {
  Color _tagColor = (tagColor != null) ? tagColor : Colors.indigo;
  double widthNum = 14 * (tagName.length) + 20;
  return Container(
    padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
    width: widthNum,
    decoration: BoxDecoration(
      color: _tagColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: Text(
        tagName,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    ),
  );
}
