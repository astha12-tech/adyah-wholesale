import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';

class SPIcon extends StatelessWidget {
  const SPIcon(
      {super.key,
      required this.assetname,
      required this.index,
      required this.currentIndex});
  final String assetname;
  final int index;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/png/$assetname",
      height: 25,
      width: 25,
      color: index == currentIndex
          ? SpUtil.getBool(SpConstUtil.appTheme)!
              ? colors.whitecolor
              : colors.themebluecolor
          : SpUtil.getBool(SpConstUtil.appTheme)!
              ? colors.whitecolor.withOpacity(0.4)
              : Colors.black,
    );
  }
}
