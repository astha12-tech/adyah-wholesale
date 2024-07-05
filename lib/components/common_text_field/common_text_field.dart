// ignore_for_file: avoid_print

import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/text_component/fontweight.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

TextFormField commonTextformField(
    String hintText,
    TextEditingController controller,
    String? Function(String?)? validator,
    bool validate,
    TextInputType? keyboardType,
    bool obscureText,
    {bool? editMode}) {
  return TextFormField(
    enabled: editMode,
    obscureText: obscureText,
    keyboardType: keyboardType,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: validator,
    controller: controller,
    style: TextStyle(
        color: editMode == false
            ? SpUtil.getBool(SpConstUtil.appTheme)!
                ? colors.whitecolor.withOpacity(0.4)
                : colors.blackcolor.withOpacity(0.4)
            : SpUtil.getBool(SpConstUtil.appTheme)!
                ? colors.whitecolor
                : colors.blackcolor,
        fontWeight: editMode == false ? fontWeight.normal : FontWeight.w600,
        fontSize: 11.sp,
        fontFamily: "OpenSans"),
    decoration: InputDecoration(
        errorStyle: TextStyle(
          fontSize: 11.sp,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.h),
            borderSide: BorderSide.none),
        fillColor: SpUtil.getBool(SpConstUtil.appTheme)!
            ? colors.whitecolor.withOpacity(0.1)
            : colors.themebluecolor.withOpacity(0.1),
        filled: true,
        // disabledBorder: editMode == false ? disbaleenabled : focused,
        // enabledBorder: validate ? success : enabled,
        // errorBorder: error,
        // focusedErrorBorder: error,
        // focusedBorder: validate ? success : focused,
        hintStyle: TextStyle(
            color: editMode == false
                ? SpUtil.getBool(SpConstUtil.appTheme)!
                    ? colors.whitecolor.withOpacity(0.4)
                    : colors.blackcolor.withOpacity(0.4)
                : SpUtil.getBool(SpConstUtil.appTheme)!
                    ? colors.whitecolor.withOpacity(0.6)
                    : colors.blackcolor.withOpacity(0.6),
            fontWeight: FontWeight.normal,
            fontSize: 11.sp,
            fontFamily: "OpenSans"),
        contentPadding: EdgeInsets.only(left: 2.h, top: 2.h, bottom: 2.h),
        hintText: hintText),
  );
}

OutlineInputBorder border = OutlineInputBorder(
  borderRadius: Radiuses.r8,
  borderSide: BorderSide(
    color: colors.strokeGrey,
    width: 0.8,
  ),
);

OutlineInputBorder enabled = OutlineInputBorder(
  borderRadius: Radiuses.r8,
  borderSide: BorderSide(
    color: colors.strokeGrey,
    width: 0.8,
  ),
);
OutlineInputBorder disbaleenabled = OutlineInputBorder(
  borderRadius: Radiuses.r8,
  borderSide: BorderSide(
    color: colors.strokeGrey,
    width: 0.8,
  ),
);

OutlineInputBorder error = OutlineInputBorder(
  borderRadius: Radiuses.r8,
  borderSide: BorderSide(
    color: colors.red,
    width: 0.8,
  ),
);

OutlineInputBorder success = OutlineInputBorder(
  borderRadius: Radiuses.r8,
  borderSide: BorderSide(
    color: colors.greenDark,
    width: 0.8,
  ),
);

OutlineInputBorder focused = OutlineInputBorder(
  borderRadius: Radiuses.r8,
  borderSide: BorderSide(
    color: colors.blueLight,
    width: 0.8,
  ),
);

class Radiuses {
  Radiuses._();

  static const r8 = BorderRadius.all(Radius.circular(8));
}
