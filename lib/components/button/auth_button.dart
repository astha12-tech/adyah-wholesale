import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

GestureDetector authenticationTextSpan(BuildContext context, String title,
    String textAuth, void Function()? onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontFamily: "OpenSans",
              fontSize: 11.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            width: 2.w,
          ),
          text(textAuth,
              fontSize: 11.sp,
              color: SpUtil.getBool(SpConstUtil.appTheme)!
                  ? colors.blueLight
                  : colors.themebluecolor,
              fontWeight: FontWeight.bold)
        ],
      ),
    ),
  );
}
