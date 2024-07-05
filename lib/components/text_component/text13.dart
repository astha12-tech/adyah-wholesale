import 'package:flutter/material.dart';

Widget text13(
  String text,
  FontWeight fontWeight, {
  int? maxLine,
  TextAlign? textAlign,
  TextOverflow? overflow,
  Color? color,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: 13,
      fontFamily: "OpenSans",
      fontWeight: fontWeight,
    ),
    maxLines: maxLine,
    textAlign: textAlign,
    overflow: overflow,
  );
}
