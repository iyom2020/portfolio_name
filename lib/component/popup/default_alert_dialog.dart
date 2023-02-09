import 'package:flutter/material.dart';

class DefaultAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String textCancel;
  final String? textConfirm;
  final GestureTapCallback? onConfirm;

  const DefaultAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.textCancel,
    this.textConfirm,
    this.onConfirm,
  });
  @override
  Widget build(BuildContext context) {
    return DefaultAlertDialogView(item: this);
  }
}

class DefaultAlertDialogView extends StatelessWidget {
  final DefaultAlertDialog item;
  const DefaultAlertDialogView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(item.title),
      content: Text(item.content),
      actions: _createElevatedButton(context),
    );
  }

  List<ElevatedButton> _createElevatedButton(BuildContext context) {
    List<ElevatedButton> elevatedButtonList = [
      ElevatedButton(
        onPressed: () => Navigator.pop(context),
        child: Text(item.textCancel),
      ),
    ];
    if (item.textConfirm != null) {
      elevatedButtonList.add(
        ElevatedButton(
          onPressed: item.onConfirm == null
              ? null
              : () {
                  item.onConfirm!();
                  Navigator.pop(context);
                },
          child: Text(item.textConfirm!),
        ),
      );
    }
    return elevatedButtonList;
  }
}
