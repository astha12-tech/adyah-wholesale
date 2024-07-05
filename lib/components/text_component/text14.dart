import 'package:flutter/material.dart';

Widget text14(
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
      fontFamily: "Roboto",
      fontSize: 14,
      fontWeight: fontWeight,
    ),
    maxLines: maxLine,
    textAlign: textAlign,
    overflow: overflow,
  );
}

Text text14new(text,
    {TextAlign? textAlign,
    Color? color,
    FontWeight? fontWeight,
    int? maxLines,
    TextDecoration? decoration,
    double? decorationThickness,
    TextOverflow? textOverflow,
    double? height}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    style: TextStyle(
        color: color ?? Colors.white,
        fontSize: 14,
        fontWeight: fontWeight,
        overflow: textOverflow ?? TextOverflow.ellipsis,
        decoration: decoration,
        decorationThickness: decorationThickness,
        height: height,
        fontFamily: "OpenSans"),
  );
}
