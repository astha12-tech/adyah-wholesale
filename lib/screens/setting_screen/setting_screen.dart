// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:adyah_wholesale/api/api.dart';
import 'package:adyah_wholesale/components/appbar/appbar_widget.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/model/get_customer_model.dart';
import 'package:adyah_wholesale/my_app.dart';
import 'package:adyah_wholesale/screens/authentication/login_screen.dart';
import 'package:adyah_wholesale/screens/bottom_navigation_bar.dart';
import 'package:adyah_wholesale/screens/setting_screen/about_us_screen.dart';
import 'package:adyah_wholesale/screens/setting_screen/update_profile_screen.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:sizer/sizer.dart';
import '../../components/text_component/text.dart';

class SettingScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  const SettingScreen({super.key, required this.toggleTheme});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);

    debugPrint(
        "======= isDarkMode =========>>${SpUtil.getBool(SpConstUtil.appTheme)}");

    return Scaffold(
      // backgroundColor: colors.whitecolor,
      appBar: appbar(context, "S E T T I N G S"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                GetCustomerModel? getCustomerModel;
                await pl.show();
                getCustomerModel = await apis.getCustomerApi(pl);
                await pl.hide();
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateProfileScreen(
                              getCustomerModel: getCustomerModel!,
                            )));
                setState(() {});
              },
              child: Container(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 2.w, top: 2.w, right: 4.w, bottom: 1.w),
                  child: Row(
                    children: [
                      Image.asset("assets/png/update-user.png",
                          height: MediaQuery.of(context).size.height / 34,
                          width: MediaQuery.of(context).size.height / 34,
                          color: SpUtil.getBool(SpConstUtil.appTheme)!
                              ? colors.whitecolor
                              : colors.blackcolor),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text(
                              "${SpUtil.getString(SpConstUtil.firstName)} ${SpUtil.getString(SpConstUtil.lastName)}",
                              fontSize:
                                  MediaQuery.of(context).size.height / 64),
                          text("${SpUtil.getString(SpConstUtil.userEmail)}",
                              fontSize:
                                  MediaQuery.of(context).size.height / 64),
                        ],
                      ),
                      const Spacer(),
                      Icon(
                        Icons.edit,
                        size: MediaQuery.of(context).size.height / 53,
                        color: SpUtil.getBool(SpConstUtil.appTheme)!
                            ? colors.whitecolor
                            : colors.blackcolor.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            rawWidget("assets/png/power-off.png", "Logout", () {
              logoutshowdilog(context, widget.toggleTheme);
            }),

            Padding(
              padding: EdgeInsets.only(left: 2.w, bottom: 2.w, top: 3.w),
              child: text("General Setting",
                  fontSize: MediaQuery.of(context).size.height / 52,
                  fontWeight: FontWeight.bold),
            ),
            // Padding(
            //   padding:
            //       EdgeInsets.only(left: 2.w, top: 1.w, right: 4.w, bottom: 2.w),
            //   child: Row(
            //     children: [
            //       Image.asset("assets/png/lock.png",
            //           height: MediaQuery.of(context).size.height / 34,
            //           width: MediaQuery.of(context).size.height / 34,
            //           color: SpUtil.getBool(SpConstUtil.appTheme)!
            //               ? colors.whitecolor
            //               : colors.blackcolor),
            //       const SizedBox(
            //         width: 20,
            //       ),
            //       Column(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           text("Lock screen and security",
            //               fontSize: MediaQuery.of(context).size.height / 64),
            //           text("Fingerprints, Touch ID",
            //               fontSize: MediaQuery.of(context).size.height / 64),
            //         ],
            //       ),
            //       const Spacer(),
            //       Image.asset("assets/png/next.png",
            //           height: MediaQuery.of(context).size.height / 53,
            //           width: MediaQuery.of(context).size.height / 53,
            //           color: SpUtil.getBool(SpConstUtil.appTheme)!
            //               ? colors.whitecolor
            //               : colors.blackcolor)
            //     ],
            //   ),
            // ),
            // const Padding(
            //   padding: EdgeInsets.only(left: 14, right: 14),
            //   child: Divider(),
            // ),
            rawWidget("assets/png/heart.png", "My Wishlist", () {}),
            const Padding(
              padding: EdgeInsets.only(left: 14, right: 14),
              child: Divider(),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 2.w, top: 1.w, right: 4.w, bottom: 2.w),
              child: Row(
                children: [
                  Image.asset("assets/png/ringing.png",
                      height: MediaQuery.of(context).size.height / 34,
                      width: MediaQuery.of(context).size.height / 34,
                      color: SpUtil.getBool(SpConstUtil.appTheme)!
                          ? colors.whitecolor
                          : colors.blackcolor),
                  const SizedBox(
                    width: 20,
                  ),
                  text("Notifications",
                      fontSize: MediaQuery.of(context).size.height / 64),
                  const Spacer(),
                  Image.asset("assets/png/next.png",
                      height: MediaQuery.of(context).size.height / 53,
                      width: MediaQuery.of(context).size.height / 53,
                      color: SpUtil.getBool(SpConstUtil.appTheme)!
                          ? colors.whitecolor
                          : colors.blackcolor)
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 14, right: 14),
              child: Divider(),
            ),
            // Padding(
            //   padding:
            //       EdgeInsets.only(left: 2.w, top: 1.w, right: 4.w, bottom: 2.w),
            //   child: Row(
            //     children: [
            //       Image.asset("assets/png/global.png",
            //           height: MediaQuery.of(context).size.height / 34,
            //           width: MediaQuery.of(context).size.height / 34,
            //           color: SpUtil.getBool(SpConstUtil.appTheme)!
            //               ? colors.whitecolor
            //               : colors.blackcolor),
            //       const SizedBox(
            //         width: 20,
            //       ),
            //       text("Languages",
            //           fontSize: MediaQuery.of(context).size.height / 64),
            //       const Spacer(),
            //       Image.asset("assets/png/next.png",
            //           height: MediaQuery.of(context).size.height / 53,
            //           width: MediaQuery.of(context).size.height / 53,
            //           color: SpUtil.getBool(SpConstUtil.appTheme)!
            //               ? colors.whitecolor
            //               : colors.blackcolor)
            //     ],
            //   ),
            // ),
            // const Padding(
            //   padding: EdgeInsets.only(left: 14, right: 14),
            //   child: Divider(),
            // ),
            // Padding(
            //   padding:
            //       EdgeInsets.only(left: 2.w, top: 1.w, right: 4.w, bottom: 2.w),
            //   child: Row(
            //     children: [
            //       Image.asset(
            //         "assets/png/exchange.png",
            //         height: MediaQuery.of(context).size.height / 34,
            //         width: MediaQuery.of(context).size.height / 34,
            //       ),
            //       const SizedBox(
            //         width: 20,
            //       ),
            //       text("Currencies",
            //           fontSize: MediaQuery.of(context).size.height / 64),
            //       const Spacer(),
            //       Image.asset(
            //         "assets/png/next.png",
            //         height: MediaQuery.of(context).size.height / 53,
            //         width: MediaQuery.of(context).size.height / 53,
            //       )
            //     ],
            //   ),
            // ),
            // const Padding(
            //   padding: EdgeInsets.only(left: 14, right: 14),
            //   child: Divider(),
            // ),
            GestureDetector(
              onTap: widget.toggleTheme,
              child: Container(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 2.w, top: 1.w, right: 4.w, bottom: 2.w),
                  child: Row(
                    children: [
                      Image.asset("assets/png/appearance.png",
                          height: MediaQuery.of(context).size.height / 34,
                          width: MediaQuery.of(context).size.height / 34,
                          color: SpUtil.getBool(SpConstUtil.appTheme)!
                              ? colors.whitecolor
                              : colors.blackcolor),
                      const SizedBox(
                        width: 20,
                      ),
                      text("Appearance",
                          fontSize: MediaQuery.of(context).size.height / 64),
                      const Spacer(),
                      Image.asset("assets/png/next.png",
                          height: MediaQuery.of(context).size.height / 53,
                          width: MediaQuery.of(context).size.height / 53,
                          color: SpUtil.getBool(SpConstUtil.appTheme)!
                              ? colors.whitecolor
                              : colors.blackcolor)
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 14, right: 14),
              child: Divider(),
            ),
            rawWidget("assets/png/clock.png", "Order History", () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomNavigationBarScreen(
                            toggleTheme: widget.toggleTheme,
                            currentIndex: 1,
                          )));
              setState(() {});
            }),
            const Padding(
              padding: EdgeInsets.only(left: 14, right: 14),
              child: Divider(),
            ),
            rawWidget("assets/png/star.png", "Rate the app", () {
              LaunchReview.launch(
                  androidAppId: "com.iyaffle.rangoli", iOSAppId: "585027354");
            }),
            const Padding(
              padding: EdgeInsets.only(left: 14, right: 14),
              child: Divider(),
            ),
            rawWidget("assets/png/insurance.png", "Privacy and Term", () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (coontext) => WebviewScreen(
                            name: "Privacy and Term",
                            url: "https://adyahwholesale.com/privacy-policy/",
                          )));
            }),
            // const Padding(
            //   padding: EdgeInsets.only(left: 14, right: 14),
            //   child: Divider(),
            // ),
            // rawWidget("assets/png/info.png", "Languages", () {
            //   // appLanguage.changeLanguage(const Locale("ne"));
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const LaunguageScreen()));
            // }),
            const Padding(
              padding: EdgeInsets.only(left: 14, right: 14),
              child: Divider(),
            ),
            rawWidget("assets/png/info.png", "About Us", () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (coontext) => WebviewScreen(
                            name: "About Us",
                            url: "https://adyahwholesale.com/about-us",
                          )));
            }),
            const Padding(
              padding: EdgeInsets.only(left: 14, right: 14),
              child: Divider(),
            ),
            GestureDetector(
              onTap: () {
                accountDeleteDialog(pl, context,
                    SpUtil.getBool(SpConstUtil.appTheme)!, widget.toggleTheme);
              },
              child: Container(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/png/social-media.png",
                        height: MediaQuery.of(context).size.height / 34,
                        width: MediaQuery.of(context).size.height / 34,
                        color: colors.originalred,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      text("Delete Account",
                          color: colors.originalred,
                          fontSize: MediaQuery.of(context).size.height / 64),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Future<Object?> logoutshowdilog(
      BuildContext context, void Function() toggleTheme) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                  // title: Text("Test"),
                  content: const Text(
                    'Are you sure you want to logout?',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: "OpenSans"),
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 40,
                              // width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: colors.themebluecolor)),
                              child: Center(
                                  child: text("NO",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: colors.themebluecolor)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              setState(() {
                                SpUtil.remove(SpConstUtil.customerID);
                                SpUtil.remove(SpConstUtil.cartID);
                                SpUtil.remove(SpConstUtil.firstName);
                                SpUtil.remove(SpConstUtil.lastName);
                                SpUtil.remove(SpConstUtil.countryCode);
                                SpUtil.remove(SpConstUtil.postalCode);
                                SpUtil.remove(SpConstUtil.country);
                                SpUtil.remove(SpConstUtil.city);
                                SpUtil.remove(SpConstUtil.country);
                                SpUtil.remove(SpConstUtil.address1);
                                SpUtil.remove(SpConstUtil.userEmail);
                                SpUtil.remove(SpConstUtil.userEmail);
                                SpUtil.remove(SpConstUtil.company);
                                SpUtil.remove(SpConstUtil.stateOrProvince);
                                SpUtil.remove(SpConstUtil.phone);
                                SpUtil.remove(SpConstUtil.address2);
                                // SpUtil.remove(SpConstUtil.storeHashValue);
                                // SpUtil.remove(SpConstUtil.accessToken);
                                // SpUtil.remove(SpConstUtil.clientSecret);
                                // SpUtil.remove(SpConstUtil.clientId);
                                SpUtil.remove(SpConstUtil.priceList);
                                SpUtil.remove(SpConstUtil.companyID);
                                // SpUtil.remove(SpConstUtil.authTokenV3);
                                // SpUtil.remove(SpConstUtil.authTokenV2);
                                SpUtil.remove(SpConstUtil.priceListID);
                                SpUtil.remove(SpConstUtil.totalqty);
                                SpUtil.remove(SpConstUtil.orderID);
                              });

                              // Navigator.pop(context);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        LoginScreen(toggleTheme: toggleTheme),
                                  ),
                                  (route) => false);
                            },
                            child: Container(
                              height: 40,
                              // width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: colors.themebluecolor),
                              child: Center(
                                  child: text("YES",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: colors.whitecolor)),
                            ),
                          ),
                        )
                      ],
                    )
                  ]),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }

  Future<Object?> accountDeleteDialog(ProgressLoader pl, BuildContext context,
      bool isDarkMode, VoidCallback toggleTheme) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                  // title: Text("Test"),
                  content: const Text(
                    'Are you sure you want to delete account?',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: "OpenSans"),
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 40,
                              // width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: colors.themebluecolor)),
                              child: Center(
                                  child: text("NO",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: colors.themebluecolor)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              pl.show();
                              apis.deleteCustomerApi(
                                  pl, context, isDarkMode, toggleTheme);
                              pl.hide();
                            },
                            child: Container(
                              height: 40,
                              // width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: colors.themebluecolor),
                              child: Center(
                                  child: text("YES",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: colors.whitecolor)),
                            ),
                          ),
                        )
                      ],
                    )
                  ]),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }

  Widget rawWidget(String imagepath, String title, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding:
              EdgeInsets.only(left: 2.w, top: 2.w, right: 4.w, bottom: 2.w),
          child: Row(
            children: [
              Image.asset(imagepath,
                  height: MediaQuery.of(context).size.height / 34,
                  width: MediaQuery.of(context).size.height / 34,
                  color: SpUtil.getBool(SpConstUtil.appTheme)!
                      ? colors.whitecolor
                      : colors.blackcolor),
              const SizedBox(
                width: 20,
              ),
              text(title, fontSize: MediaQuery.of(context).size.height / 64),
              const Spacer(),
              Image.asset("assets/png/next.png",
                  height: MediaQuery.of(context).size.height / 53,
                  width: MediaQuery.of(context).size.height / 53,
                  color: SpUtil.getBool(SpConstUtil.appTheme)!
                      ? colors.whitecolor
                      : colors.blackcolor)
            ],
          ),
        ),
      ),
    );
  }
}
