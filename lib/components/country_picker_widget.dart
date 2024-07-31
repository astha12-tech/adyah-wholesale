import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

typedef StateSetterCallback = void Function(
    String? countryCode, String? countryName);
GestureDetector countryPickerWidget(
    BuildContext context,
    StateSetterCallback setStateCallback,
    String? countryCode,
    String? countryName) {
  return GestureDetector(
    onTap: () {
      showCountryPicker(
          context: context,
          showPhoneCode: true,
          onSelect: (Country country) {
            setStateCallback(
                country.countryCode, country.displayName.split('(')[0].trim());
          });
    },
    child: Container(
      height: 7.h,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.h),
          color: SpUtil.getBool(SpConstUtil.appTheme)!
              ? colors.whitecolor.withOpacity(0.1)
              : colors.themebluecolor.withOpacity(0.1)),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 2.h, right: 2.h),
          child: Row(
            children: [
              Text(
                countryName ?? "Choose a Country",
                style: TextStyle(
                    color: countryName != null
                        ? SpUtil.getBool(SpConstUtil.appTheme)!
                            ? colors.whitecolor
                            : colors.blackcolor
                        : SpUtil.getBool(SpConstUtil.appTheme)!
                            ? colors.whitecolor.withOpacity(0.6)
                            : colors.blackcolor.withOpacity(0.6),
                    fontWeight: countryName != null
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: 11.sp,
                    fontFamily: "OpenSans"),
              ),
              const Spacer(),
              Image.asset(
                "assets/png/down_arrow.png",
                height: 3.h,
                width: 3.h,
                color: SpUtil.getBool(SpConstUtil.appTheme)!
                    ? colors.whitecolor
                    : colors.blackcolor,
              )
            ],
          ),
        ),
      ),
    ),
  );
}
