// ignore_for_file: must_be_immutable

import 'package:adyah_wholesale/bloc/category_bloc.dart';
import 'package:adyah_wholesale/components/appbar/appbar_widget.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/shimmer_widget/caegory_shimmer.dart';
import 'package:adyah_wholesale/components/text_component/text14.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/global/global.dart';
import 'package:adyah_wholesale/model/category_model.dart';
import 'package:adyah_wholesale/screens/products_screen/product_screen.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CategoryScreen extends StatefulWidget {
  void Function() toggleTheme;

  CategoryScreen({super.key, required this.toggleTheme});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int index = 0;
  int? selected;
  int? subselected;
  @override
  Widget build(BuildContext context) {
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);

    return Scaffold(
        appBar: appbar(context, "C A T E G O R Y"), body: categoryWidget(pl));
  }

  StreamBuilder<CategoryModel> categoryWidget(ProgressLoader pl) {
    return StreamBuilder<CategoryModel>(
        stream: categoryBloc.categoryStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                text14new(snapshot.error,
                    color: Colors.blue, fontWeight: FontWeight.bold),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () async {
                          await pl.show();
                          await categoryBloc
                              .categoryBloc(pl)
                              .catchError((error) async {
                            if (pl.isShowing()) {
                              await pl.hide();
                            }
                          });
                          await pl.hide();
                        },
                        child: text14("Retry", FontWeight.bold)),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasData) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  for (int i = 0; i < snapshot.data!.data!.length; i++)
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.all(1.5.h),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: SpUtil.getBool(SpConstUtil.appTheme)!
                                        ? colors.greyColor.withOpacity(0.3)
                                        : colors.blackcolor.withOpacity(0.3))),
                            child: ExpansionTile(
                              trailing:
                                  snapshot.data!.data![i].children!.isEmpty
                                      ? Container(
                                          width: 24,
                                        )
                                      : Icon(
                                          Icons.add,
                                          size: 3.h,
                                        ),
                              key: Key('builder_${selected.toString()}_$i'),
                              initiallyExpanded: i == selected,
                              visualDensity: VisualDensity.standard,
                              onExpansionChanged: (value) {
                                if (value) {
                                  setState(() {
                                    selected = i;
                                  });
                                } else {
                                  selected = -1;
                                }
                                debugPrint("=== selected ====>$selected");
                              },
                              shape: InputBorder.none,
                              collapsedShape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              title: GestureDetector(
                                // onTap: () async {
                                //   commonData.alllmainProducts.clear();
                                //   await Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) => Products(
                                //                 title: snapshot
                                //                     .data!.data![i].name!,
                                //                 categoryID:
                                //                     snapshot.data!.data![i].id!,
                                //                 toggleTheme: widget.toggleTheme,
                                //               )));
                                //   setState(() {});
                                // },
                                onTap: () async {
                                  debugPrint("==== 1111 ====");
                                  setState(() {
                                    commonData.alllmainProducts.clear();
                                    commonData.isShow = false;
                                  });
                                  try {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Products(
                                          title: snapshot.data!.data![i].name!,
                                          categoryID:
                                              snapshot.data!.data![i].id!,
                                          toggleTheme: widget.toggleTheme,
                                        ),
                                      ),
                                    );

                                    if (result != null) {
                                      setState(() {
                                        commonData.alllmainProducts.clear();
                                        commonData.isShow = false;
                                        debugPrint(
                                            "====  commonData.isShow 1111 ====${commonData.isShow}");
                                      });
                                      setState(() {});
                                    }
                                  } catch (e) {
                                    // Handle any errors here
                                    debugPrint('Error during navigation: $e');
                                  }
                                },
                                child: Text(
                                  snapshot.data!.data![i].name!,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontFamily: "OpenSans",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              children: [
                                for (int j = 0;
                                    j <
                                        snapshot
                                            .data!.data![i].children!.length;
                                    j++)
                                  ExpansionTile(
                                    trailing: snapshot.data!.data![i]
                                            .children![j].children!.isEmpty
                                        ? Container(
                                            width: 24,
                                          )
                                        : Icon(
                                            Icons.add,
                                            size: 1.5.h,
                                          ),
                                    key: Key(
                                        'builder_${subselected.toString()}_$j'),
                                    initiallyExpanded: j == subselected,
                                    onExpansionChanged: (value) {
                                      if (value) {
                                        setState(() {
                                          subselected = j;
                                        });
                                      } else {
                                        subselected = -1;
                                      }
                                    },
                                    expandedAlignment: Alignment.centerLeft,
                                    backgroundColor:
                                        colors.greyColor.withOpacity(0.2),
                                    shape: InputBorder.none,
                                    title: GestureDetector(
                                      // onTap: () async {
                                      //   commonData.alllmainProducts.clear();
                                      //   await Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //           builder: (context) => Products(
                                      //                 title: snapshot
                                      //                     .data!
                                      //                     .data![i]
                                      //                     .children![j]
                                      //                     .name!,
                                      //                 categoryID: snapshot
                                      //                     .data!
                                      //                     .data![i]
                                      //                     .children![j]
                                      //                     .id!,
                                      //                 toggleTheme:
                                      //                     widget.toggleTheme,
                                      //               )));
                                      //   setState(() {});
                                      // },
                                      onTap: () async {
                                        debugPrint("==== 2222 ====");
                                        setState(() {
                                          commonData.alllmainProducts.clear();
                                          commonData.isShow = false;
                                        });
                                        try {
                                          final result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Products(
                                                title: snapshot.data!.data![i]
                                                    .children![j].name!,
                                                categoryID: snapshot.data!
                                                    .data![i].children![j].id!,
                                                toggleTheme: widget.toggleTheme,
                                              ),
                                            ),
                                          );

                                          if (result != null) {
                                            setState(() {
                                              commonData.alllmainProducts
                                                  .clear();
                                              commonData.isShow = false;
                                            });
                                            setState(() {});
                                          }
                                        } catch (e) {
                                          // Handle any errors here
                                          debugPrint(
                                              'Error during navigation: $e');
                                        }
                                      },
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/png/dot_icon.png",
                                              height: 2.h,
                                              width: 2.h,
                                            ),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                            Expanded(
                                              child: Text(
                                                  snapshot.data!.data![i]
                                                      .children![j].name!,
                                                  style: TextStyle(
                                                      fontSize: 10.sp,
                                                      // overflow: TextOverflow
                                                      //     .ellipsis,
                                                      fontFamily: "OpenSans")),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    children: [
                                      GestureDetector(
                                        // onTap: () async {
                                        //   commonData.alllmainProducts.clear();
                                        //   Navigator.push(
                                        //       context,
                                        //       MaterialPageRoute(
                                        //           builder: (context) =>
                                        //               Products(
                                        //                 title: snapshot
                                        //                     .data!
                                        //                     .data![i]
                                        //                     .children![j]
                                        //                     .name!,
                                        //                 categoryID: snapshot
                                        //                     .data!
                                        //                     .data![i]
                                        //                     .children![j]
                                        //                     .id!,
                                        //                 toggleTheme:
                                        //                     widget.toggleTheme,
                                        //               )));
                                        //   setState(() {});
                                        // },
                                        onTap: () async {
                                          debugPrint("==== 3333 ====");
                                          setState(() {
                                            commonData.alllmainProducts.clear();
                                            commonData.isShow = false;
                                          });
                                          try {
                                            final result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Products(
                                                  title: snapshot.data!.data![i]
                                                      .children![j].name!,
                                                  categoryID: snapshot
                                                      .data!
                                                      .data![i]
                                                      .children![j]
                                                      .id!,
                                                  toggleTheme:
                                                      widget.toggleTheme,
                                                ),
                                              ),
                                            );

                                            if (result != null) {
                                              setState(() {
                                                commonData.alllmainProducts
                                                    .clear();
                                                commonData.isShow = false;
                                              });
                                              setState(() {});
                                            }
                                          } catch (e) {
                                            // Handle any errors here
                                            debugPrint(
                                                'Error during navigation: $e');
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: snapshot
                                                  .data!
                                                  .data![i]
                                                  .children![j]
                                                  .children!
                                                  .isEmpty
                                              ? Container()
                                              : Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                      border: Border.all(
                                                          color: colors
                                                              .themebluecolor)),
                                                  child: Column(
                                                    children: [
                                                      for (int k = 0;
                                                          k <
                                                              snapshot
                                                                  .data!
                                                                  .data![i]
                                                                  .children![j]
                                                                  .children!
                                                                  .length;
                                                          k++)
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  1.5.h),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          2.h),
                                                              color: colors
                                                                  .themebluecolor,
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(1.5
                                                                          .h),
                                                              child:
                                                                  GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  debugPrint(
                                                                      "==== 5555 ====");
                                                                  setState(() {
                                                                    commonData
                                                                        .alllmainProducts
                                                                        .clear();
                                                                    commonData
                                                                            .isShow =
                                                                        false;
                                                                  });
                                                                  await Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => Products(
                                                                                title: snapshot.data!.data![i].children![j].children![k].name!,
                                                                                categoryID: snapshot.data!.data![i].children![j].children![k].id!,
                                                                                toggleTheme: widget.toggleTheme,
                                                                              )));
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    Image.asset(
                                                                      "assets/png/full-stop.png",
                                                                      height:
                                                                          2.h,
                                                                      width:
                                                                          2.h,
                                                                      color: colors
                                                                          .whitecolor,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          2.w,
                                                                    ),
                                                                    text(
                                                                      snapshot
                                                                          .data!
                                                                          .data![
                                                                              i]
                                                                          .children![
                                                                              j]
                                                                          .children![
                                                                              k]
                                                                          .name!,
                                                                      color: colors
                                                                          .whitecolor,
                                                                      fontSize:
                                                                          10.sp,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                    ],
                                                  )),
                                        ),
                                      ),
                                    ],
                                  )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                ],
              ),
            );
          } else {
            categoryBloc.categoryBloc(pl);
            return const Center(child: CategoryShimmerr());
          }
        });
  }
}
