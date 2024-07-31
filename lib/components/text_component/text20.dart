import 'package:flutter/material.dart';

Widget text20(String text, Color color, FontWeight fontWeight,
    {int? maxLine,
    TextAlign? textAlign,
    TextOverflow? overflow,
    TextDecoration? textDecoration}) {
  return Text(
    text,
    style: TextStyle(
      decoration: textDecoration,
      color: color,
      fontSize: 20,
      fontFamily: "OpenSans",
      fontWeight: fontWeight,
    ),
    maxLines: maxLine,
    textAlign: textAlign,
    overflow: overflow,
  );
}
