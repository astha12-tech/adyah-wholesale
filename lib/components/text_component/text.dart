import 'package:flutter/material.dart';

Text text(
  String text, {
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
}) =>
    Text(
      text,
      style: TextStyle(
        fontFamily: "OpenSans",
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color,
      ),
    );
