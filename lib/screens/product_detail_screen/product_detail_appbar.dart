import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/screens/cart_screen/cart_screen.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:badges/badges.dart' as badges;

AppBar productDetailAppbar(
    BuildContext context, void Function() toggleTheme, StateSetter setState) {
  return AppBar(
    scrolledUnderElevation: 0,
    leadingWidth: 14.w,
    toolbarHeight: MediaQuery.of(context).size.height / 18,
    // backgroundColor: colors.themebluecolor,
    automaticallyImplyLeading: false,

    elevation: 0,
    centerTitle: true,
    leading: TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Container(
        height: 5.h,
        width: 5.h,
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
          padding: EdgeInsets.all(0.7.h),
          child: Image.asset(
            "assets/png/back.png",
            color: SpUtil.getBool(SpConstUtil.appTheme)!
                ? colors.whitecolor
                : colors.blackcolor,
          ),
        ),
      ),
    ),
    title: text(
      "Product Details",
      fontSize: 13.sp,
      fontWeight: FontWeight.bold,
      color: SpUtil.getBool(SpConstUtil.appTheme)!
          ? colors.whitecolor
          : colors.blackcolor,
    ),
    actions: [
      // Row(
      //   children: [
      //     text("${SpUtil.getDouble(SpConstUtil.totalqty)}"),
      //     TextButton(
      //       onPressed: () async {
      //         await Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => CartScreenn(
      //                       allcartDataids:
      //                           SpUtil.getString(SpConstUtil.cartID)!,
      //                       title: '',
      //                       toggleTheme: toggleTheme,
      //                     )));
      //         setState(() {});
      //       },
      //       child: Stack(
      //         children: [
      //           Container(
      //             height: 4.h,
      //             width: 4.h,
      //             decoration: BoxDecoration(
      //               shape: BoxShape.circle,
      //               border: Border.all(color: Colors.transparent),
      //             ),
      //             child: Padding(
      //               padding: EdgeInsets.all(0.2.h),
      //               child: Image.asset(
      //                 "assets/png/grocery-store.png",
      //                 color: SpUtil.getBool(SpConstUtil.appTheme)!
      //                     ? colors.whitecolor
      //                     : colors.blackcolor,
      //               ),
      //             ),
      //           ),
      //           Positioned(
      //             right: 0,
      //             child: Container(
      //               height: 15,
      //               width: 15,
      //               decoration: BoxDecoration(
      //                   shape: BoxShape.circle, color: colors.bluecolor),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // )
      TextButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CartScreenn(
                        allcartDataids: SpUtil.getString(SpConstUtil.cartID)!,
                        title: '',
                        toggleTheme: toggleTheme,
                      )));
          setState(() {});
        },
        child: SpUtil.getDouble(SpConstUtil.totalqty) == 0.0
            ? Image.asset(
                "assets/png/grocery-store.png",
                color: SpUtil.getBool(SpConstUtil.appTheme)!
                    ? colors.whitecolor
                    : colors.blackcolor,
              )
            : badges.Badge(
                position: badges.BadgePosition.topEnd(
                  top: -16,
                  end: -5,
                ),
                badgeAnimation: const badges.BadgeAnimation.rotation(
                  animationDuration: Duration(seconds: 1),
                  colorChangeAnimationDuration: Duration(seconds: 1),
                  loopAnimation: false,
                  curve: Curves.fastOutSlowIn,
                  colorChangeAnimationCurve: Curves.easeInCubic,
                ),
                badgeContent: text(
                    "${SpUtil.getDouble(SpConstUtil.totalqty)!.toInt()}",
                    color: colors.whitecolor,
                    fontSize: 22),
                child: Image.asset(
                  "assets/png/grocery-store.png",
                  color: SpUtil.getBool(SpConstUtil.appTheme)!
                      ? colors.whitecolor
                      : colors.blackcolor,
                ),
              ),
      )
    ],
  );
}
