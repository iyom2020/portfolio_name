import 'package:cloud_firestore/cloud_firestore.dart';

String TimeConvert(Timestamp timestamp) {
  DateTime dt = timestamp.toDate();
  String str =
      "${dt.year}${dt.month}${dt.day}${dt.hour}${dt.minute}${dt.second}${dt.millisecond}${dt.microsecond}";
  return str;
}
