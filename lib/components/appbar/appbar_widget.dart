import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

AppBar appbar(BuildContext context, String title) {
  return AppBar(
    scrolledUnderElevation: 0,
    toolbarHeight: MediaQuery.of(context).size.height / 18,
    automaticallyImplyLeading: false,
    centerTitle: true,
    // backgroundColor:
    //     SpUtil.getBool(SpConstUtil.appTheme)! ? colors.whitecolor : colors.themebluecolor,
    title: text(title,
        fontSize: 13.sp,
        fontWeight: FontWeight.bold,
        color: SpUtil.getBool(SpConstUtil.appTheme)!
            ? colors.whitecolor
            : colors.blackcolor),
  );
}
