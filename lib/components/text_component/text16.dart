import 'package:flutter/material.dart';

Widget text16(String text, Color color, FontWeight fontWeight,
    {int? maxLine, TextAlign? textAlign, TextOverflow? overflow}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: 16,
      fontFamily: "OpenSans",
      fontWeight: fontWeight,
    ),
    maxLines: maxLine,
    textAlign: textAlign,
    overflow: overflow,
  );
}
