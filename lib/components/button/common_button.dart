import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget commonButtonWidget(void Function()? onTap, String buttonName) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: SpUtil.getBool(SpConstUtil.appTheme)!
              ? colors.whitecolor
              : colors.themebluecolor,
          borderRadius: BorderRadius.circular(2.h)),
      child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(1.4.h),
            child: text(buttonName,
                color: SpUtil.getBool(SpConstUtil.appTheme)!
                    ? colors.blackcolor
                    : colors.whitecolor,
                fontSize: 10.sp),
          )),
    ),
  );
}
