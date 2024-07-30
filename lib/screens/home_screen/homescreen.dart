// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:adyah_wholesale/api/api.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/text_component/fontweight.dart';
import 'package:adyah_wholesale/components/text_component/text15.dart';
import 'package:adyah_wholesale/components/text_component/text18.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/global/global.dart';
import 'package:adyah_wholesale/my_app.dart';
import 'package:adyah_wholesale/screens/authentication/login_screen.dart';
import 'package:adyah_wholesale/screens/bottom_navigation_bar.dart';
import 'package:adyah_wholesale/screens/brands/brands_screen.dart';
import 'package:adyah_wholesale/screens/home_screen/all_blog_screen.dart';
import 'package:adyah_wholesale/screens/home_screen/blog_widget.dart';
import 'package:adyah_wholesale/screens/home_screen/category_widget.dart';
import 'package:adyah_wholesale/screens/home_screen/featured_products_widget.dart';
import 'package:adyah_wholesale/screens/home_screen/home_app_bar.dart';
import 'package:adyah_wholesale/screens/home_screen/home_banner.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/product_detail_screen.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/product_detail_tablet.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  const HomeScreen({super.key, required this.toggleTheme});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Set<String> savedWords = <String>{};
  Future<void> scanBarcodeNormal(ProgressLoader pl) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);

      // Check if barcode scanning was successful and not cancelled
      if (barcodeScanRes != '-1' && barcodeScanRes != '-2') {
        await pl.show();
        var data = await apis.skuscannProductsApi(pl, barcodeScanRes);
        await pl.hide();

        if (data != null && data.data != null && data.data!.isNotEmpty) {
          SizerUtil.deviceType == DeviceType.mobile
              ? await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetail(
                      data: data.data![0],
                      productsMainCategoryModel: data,
                      screen: "scanner",
                      toggleTheme: widget.toggleTheme,
                    ),
                  ),
                )
              : await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailTabletScreen(
                            data: data.data![0],
                            productsMainCategoryModel: data,
                            screen: "scanner",
                            toggleTheme: widget.toggleTheme,
                          )));
          setState(() {});
        } else {
          apis.showToast("No product data found for scanned SKU");
        }
      } else {
        apis.showToast("Barcode scanning cancelled by user");
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {});
  }

  int currentIndex = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    commonData.allSalePricesfeature.clear();
    super.initState();
  }

  List textList = [
    'abs',
    'absddddddd',
    'absddd',
    'absd',
    'absddd',
    'absdd',
    'absd',
    'absdddddddddd',
    'abs',
    'absddd',
  ];
  @override
  Widget build(BuildContext context) {
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);
    int crossAxisCount = MediaQuery.of(context).size.width ~/ 180;
    final itemWidth = MediaQuery.of(context).size.width / crossAxisCount / 2.2;
    final itemHeight = MediaQuery.of(context).size.width / crossAxisCount / 2.2;

    return Scaffold(
      appBar: homeAppbar(
          context, pl, scanBarcodeNormal, scaffoldKey, widget.toggleTheme),
      key: scaffoldKey,
      drawer: homedrawer(context, pl),
      body: Column(
        children: [
          // homeAppbar(scaffoldKey, context),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  // Wrap(
                  //   spacing: 4,
                  //   children: [
                  //     for (int i = 0; i < 10; i++)
                  //       FilterChip(
                  //         padding: EdgeInsets.zero,
                  //         label: Text(textList[i]),
                  //         onSelected: (value) {},
                  //         selectedColor: Colors.green.shade500,
                  //         backgroundColor: Colors.grey.shade500,
                  //       )
                  //   ],
                  // ),
                  categoryWidget(pl, widget.toggleTheme, setState),
                  homeBanner(pl, (p0) {
                    setState(() {
                      currentIndex = p0;
                    });
                  }, currentIndex),
                  featuredProductsWidget(
                    pl,
                    crossAxisCount,
                    itemWidth,
                    itemHeight,
                    setState,
                    savedWords,
                    widget.toggleTheme,
                  ),
                  // latestProductsWidget(pl, widget.toggleTheme, setState),
                  blogWidget(pl),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Drawer homedrawer(BuildContext context, ProgressLoader pl) {
    return Drawer(
      // backgroundColor: colors.whitecolor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: colors.themebluecolor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const SizedBox(
                  width: 10,
                ),

                //  text("${SpUtil.getString(SpConstUtil.userName)}"),
                // text("${SpUtil.getString(SpConstUtil.userEmail)}"),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: text18(
                      "${SpUtil.getString(SpConstUtil.firstName)} ${SpUtil.getString(SpConstUtil.lastName)}",
                      fontWeight.bold,
                      color: SpUtil.getBool(SpConstUtil.appTheme)!
                          ? colors.whitecolor
                          : colors.whitecolor),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: text15("${SpUtil.getString(SpConstUtil.userEmail)}",
                      fontWeight.normal,
                      color: SpUtil.getBool(SpConstUtil.appTheme)!
                          ? colors.whitecolor
                          : colors.whitecolor),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  rowWidget("assets/png/home.png", "Home", () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavigationBarScreen(
                                  currentIndex: 0,
                                  toggleTheme: widget.toggleTheme,
                                )));
                    setState(() {});
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  rowWidget("assets/png/communication.png", "Blog", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AllBlogsScreen()));
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  rowWidget("assets/png/category.png", "Categories", () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavigationBarScreen(
                                  currentIndex: 2,
                                  toggleTheme: widget.toggleTheme,
                                )));
                    setState(() {});
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  rowWidget("assets/png/grocery-store.png", "Cart", () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavigationBarScreen(
                                  currentIndex: 3,
                                  toggleTheme: widget.toggleTheme,
                                )));
                    setState(() {});
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  rowWidget("assets/png/mechanical-gears-.png", "Settings",
                      () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavigationBarScreen(
                                  currentIndex: 4,
                                  toggleTheme: widget.toggleTheme,
                                )));
                    setState(() {});
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  rowWidget("assets/png/mechanical-gears-.png", "Brands",
                      () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BrandsScreen(
                                  toggleTheme: widget.toggleTheme,
                                )));
                    setState(() {});
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  rowWidget("assets/png/power-off.png", "Logout", () {
                    logoutshowdilog(context, () {});
                  }),
                  // const Divider(),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: text("BY CATEGORY",
                  //       fontSize: 15,
                  //       color: colors.blackcolor,
                  //       fontWeight: fontWeight.bold),
                  // ),
                  // StreamBuilder<ParentCategoryModel>(
                  //     stream: parentCategoryBloc.parentcategoryStream,
                  //     builder: (context, snapshot) {
                  //       if (snapshot.hasError) {
                  //         return Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             text14new(snapshot.error,
                  //                 color: Colors.blue,
                  //                 fontWeight: FontWeight.bold),
                  //             const SizedBox(
                  //               height: 10,
                  //             ),
                  //             Center(
                  //               child: SizedBox(
                  //                 height: 40,
                  //                 // width: 70,
                  //                 child: ElevatedButton(
                  //                     onPressed: () async {
                  //                       await pl.show();
                  //                       await parentCategoryBloc
                  //                           .parentcategoryBloc(pl)
                  //                           .catchError((error) async {
                  //                         if (pl.isShowing()) {
                  //                           await pl.hide();
                  //                         }
                  //                       });
                  //                       await pl.hide();
                  //                     },
                  //                     child: text14("Retry", Colors.black,
                  //                         FontWeight.bold)),
                  //               ),
                  //             ),
                  //           ],
                  //         );
                  //       } else if (snapshot.hasData) {
                  //         return Column(
                  //           children: [
                  //             for (int i = 0;
                  //                 i < snapshot.data!.data!.length;
                  //                 i++)
                  //               GestureDetector(
                  //                 onTap: () {
                  //                   Navigator.push(
                  //                       context,
                  //                       MaterialPageRoute(
                  //                           builder: (context) => Products(
                  //                                 title: snapshot
                  //                                     .data!.data![i].name!,
                  //                                 categoryID: snapshot.data!
                  //                                     .data![i].categoryId!,
                  //                               )));
                  //                 },
                  //                 child: Container(
                  //                   margin: const EdgeInsets.only(bottom: 5),
                  //                   width: double.infinity,
                  //                   height: 55,
                  //                   color: Colors.grey.withOpacity(0.4),
                  //                   child: Padding(
                  //                     padding: const EdgeInsets.all(14.0),
                  //                     child: Row(
                  //                       children: [
                  //                         text(snapshot.data!.data![i].name!,
                  //                             fontSize: 12,
                  //                             color: colors.blackcolor,
                  //                             fontWeight: fontWeight.bold),
                  //                         const Spacer(),
                  //                         Image.asset(
                  //                           "assets/png/next.png",
                  //                           height: 18,
                  //                           width: 18,
                  //                         )
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //           ],
                  //         );
                  //       } else {
                  //         parentCategoryBloc.parentcategoryBloc(pl);
                  //         return const Center(child: DrawerShimmer());
                  //       }
                  //     })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget rowWidget(String imagePath, String title, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Image.asset(
                imagePath,
                height: 20,
                width: 20,
                color: SpUtil.getBool(SpConstUtil.appTheme)!
                    ? colors.whitecolor
                    : colors.blackcolor,
              ),
              const SizedBox(
                width: 25,
              ),
              text(title, fontSize: 14, fontWeight: fontWeight.normal)
            ],
          ),
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

                                SpUtil.remove(SpConstUtil.priceList);
                                SpUtil.remove(SpConstUtil.companyID);

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
}
