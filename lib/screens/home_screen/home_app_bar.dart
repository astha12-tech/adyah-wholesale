import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/screens/home_screen/search_screen.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

AppBar homeAppbar(
    BuildContext context,
    ProgressLoader pl,
    Future<void> Function(ProgressLoader pl) scanBarcodeNormal,
    GlobalKey<ScaffoldState> scaffoldKey,
    void Function() toggleTheme) {
  return AppBar(
    forceMaterialTransparency: true,
    scrolledUnderElevation: 0,
    leadingWidth: 14.w,
    toolbarHeight: MediaQuery.of(context).size.height / 18,
    elevation: 0,
    leading: TextButton(
      onPressed: () {
        scaffoldKey.currentState!.openDrawer();
      },
      child: Container(
        height: 4.h,
        width: 4.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors.kSecondaryColor.withOpacity(0.2),
        ),
        child: Padding(
          padding: EdgeInsets.all(0.65.h),
          child: Image.asset(
            "assets/png/menus.png",
            color: SpUtil.getBool(SpConstUtil.appTheme)!
                ? colors.whitecolor
                : colors.blackcolor,
          ),
        ),
      ),
    ),
    // GestureDetector(
    //     onTap: () {

    //     },
    //     child: Padding(
    //       padding: const EdgeInsets.all(5.0),
    //       child: Container(
    //         height: 4.2.h,
    //         width: 4.2.h,
    //         decoration: BoxDecoration(
    //           shape: BoxShape.circle,
    //           color: colors.kSecondaryColor.withOpacity(0.2),
    //         ),
    //         child: Padding(
    //           padding: EdgeInsets.all(0.99.h),
    //           child: Image.asset(
    //             "assets/png/menus.png",
    //             color: SpUtil.getBool(SpConstUtil.appTheme)!
    //                 ? colors.whitecolor
    //                 : colors.blackcolor,
    //           ),
    //         ),
    //       ),
    //     )),
    centerTitle: true,
    title: text('H O M E',
        fontSize: 13.sp,
        fontWeight: FontWeight.bold,
        color: SpUtil.getBool(SpConstUtil.appTheme)!
            ? colors.whitecolor
            : colors.blackcolor),
    actions: [
      Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SearchScreen(toggleTheme: toggleTheme)));
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                height: 4.2.h,
                width: 4.2.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // border: Border.all(
                  //   color: SpUtil.getBool(SpConstUtil.appTheme)!
                  //       ? colors.whitecolor
                  //       : colors.blackcolor,
                  // ),
                  color: colors.kSecondaryColor.withOpacity(0.2),
                ),
                child: Padding(
                  padding: EdgeInsets.all(0.99.h),
                  child: Image.asset("assets/png/search.png",
                      color: SpUtil.getBool(SpConstUtil.appTheme)!
                          ? colors.whitecolor
                          : colors.blackcolor),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              scanBarcodeNormal(pl);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 2.h),
              child: Container(
                height: 4.2.h,
                width: 4.2.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // border: Border.all(
                  //   color: SpUtil.getBool(SpConstUtil.appTheme)!
                  //       ? colors.whitecolor
                  //       : colors.blackcolor,
                  // ),
                  color: colors.kSecondaryColor.withOpacity(0.2),
                ),
                child: Padding(
                  padding: EdgeInsets.all(0.99.h),
                  child: Image.asset("assets/png/qr-code-scan.png",
                      height: MediaQuery.of(context).size.height / 33,
                      width: MediaQuery.of(context).size.height / 33,
                      fit: BoxFit.cover,
                      color: SpUtil.getBool(SpConstUtil.appTheme)!
                          ? colors.whitecolor
                          : colors.blackcolor),
                ),
              ),
            ),
          ),
        ],
      )
    ],
  );
}
