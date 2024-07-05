import 'package:flutter/material.dart';

Text text18(String text, FontWeight fontWeight,
    {int? maxLine,
    TextAlign? textAlign,
    TextOverflow? overflow,
    Color? color}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: 18,
      fontFamily: "Roboto",
      fontWeight: fontWeight,
    ),
    maxLines: maxLine,
    textAlign: textAlign,
    overflow: overflow,
  );
}
