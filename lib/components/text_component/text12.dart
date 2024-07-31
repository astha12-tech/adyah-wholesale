import 'package:flutter/material.dart';

Widget text12(
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
      fontFamily: "OpenSans",
      fontSize: 12,
      fontWeight: fontWeight,
    ),
    maxLines: maxLine,
    textAlign: textAlign,
    overflow: overflow,
  );
}
