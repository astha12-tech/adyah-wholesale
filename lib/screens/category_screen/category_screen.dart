// ignore_for_file: avoid_print, must_be_immutable

import 'package:adyah_wholesale/bloc/category_bloc.dart';
import 'package:adyah_wholesale/components/appbar/appbar_widget.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/shimmer_widget/caegory_shimmer.dart';
import 'package:adyah_wholesale/components/text_component/text14.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/model/category_model.dart';
import 'package:adyah_wholesale/screens/products_screen/new_one_product_screen.dart';
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
  List<bool> isExpanded = [];
  int? selected;
  int? subselected;
  @override
  Widget build(BuildContext context) {
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);

    return Scaffold(
        appBar: appbar(context, "Category"), body: categoryWidget(pl));
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
                    // width: 70,
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
            isExpanded = List.filled(snapshot.data!.data!.length, false);
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
                        // snapshot.data!.data![i].children!.isEmpty
                        //     ? GestureDetector(
                        //         onTap: () {
                        //           Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (context) => Products(
                        //                         title: snapshot
                        //                             .data!.data![i].name!,
                        //                         categoryID: snapshot
                        //                             .data!.data![i].id!,
                        //                       )));
                        //         },
                        //         child: Padding(
                        //           padding: EdgeInsets.all(1.5.h),
                        //           child: Container(
                        //             width: double.infinity,
                        //             // height: 60,
                        //             decoration: BoxDecoration(
                        //                 borderRadius:
                        //                     BorderRadius.circular(10),
                        //                 // color: colors.blackcolor,
                        //                 border: Border.all(
                        //                     color: SpUtil.getBool(
                        //                             SpConstUtil.appTheme)!
                        //                         ? colors.greyColor
                        //                             .withOpacity(0.3)
                        //                         : colors.blackcolor
                        //                             .withOpacity(0.3))),
                        //             child: Align(
                        //               alignment: Alignment.centerLeft,
                        //               child: Padding(
                        //                 padding: EdgeInsets.only(left: 1.h),
                        //                 child: Text(
                        //                   snapshot.data!.data![i].name!,
                        //                   style: TextStyle(
                        //                     fontSize: 11.sp,
                        //                     fontFamily: "OpenSans",
                        //                     fontWeight: FontWeight.bold,
                        //                   ),
                        //                   textAlign: TextAlign.center,
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       )
                        //     :
                        Padding(
                          padding: EdgeInsets.all(1.5.h),
                          child: Container(
                            width: double.infinity,
                            // height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // color: colors.blackcolor,
                                border: Border.all(
                                    color: SpUtil.getBool(SpConstUtil.appTheme)!
                                        ? colors.greyColor.withOpacity(0.3)
                                        : colors.blackcolor.withOpacity(0.3))),
                            child: ExpansionTile(
                              // expansionAnimationStyle: AnimationStyle(
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
                              // collapsedBackgroundColor:
                              //     colors.themebluecolor,
                              // backgroundColor: colors.themebluecolor,
                              // expandedAlignment: Alignment.,
                              // iconColor: colors.whitecolor,
                              // collapsedIconColor: colors.whitecolor,
                              title: GestureDetector(
                                onTap: () async {
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Products(
                                                title: snapshot
                                                    .data!.data![i].name!,
                                                categoryID:
                                                    snapshot.data!.data![i].id!,
                                                toggleTheme: widget.toggleTheme,
                                              )));
                                  setState(() {});
                                },
                                child: Text(
                                  snapshot.data!.data![i].name!,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontFamily: "OpenSans",
                                    fontWeight: FontWeight.bold,
                                  ),
                                  // textAlign: TextAlign.center,
                                ),
                              ),
                              children: [
                                for (int j = 0;
                                    j <
                                        snapshot
                                            .data!.data![i].children!.length;
                                    j++)
                                  // snapshot.data!.data![i].children![j]
                                  //         .children!.isEmpty
                                  //     ? Padding(
                                  //         padding: EdgeInsets.all(1.5.h),
                                  //         child: GestureDetector(
                                  //           onTap: () {
                                  //             Navigator.push(
                                  //                 context,
                                  //                 MaterialPageRoute(
                                  //                     builder: (context) =>
                                  //                         Products(
                                  //                           title: snapshot
                                  //                               .data!
                                  //                               .data![i]
                                  //                               .children![
                                  //                                   j]
                                  //                               .name!,
                                  //                           categoryID:
                                  //                               snapshot
                                  //                                   .data!
                                  //                                   .data![
                                  //                                       i]
                                  //                                   .children![
                                  //                                       j]
                                  //                                   .id!,
                                  //                         )));
                                  //           },
                                  //           child: Row(
                                  //             children: [
                                  //               Image.asset(
                                  //                 "assets/png/dot_icon.png",
                                  //                 height: 2.h,
                                  //                 width: 2.h,
                                  //               ),
                                  //               SizedBox(
                                  //                 width: 4.w,
                                  //               ),
                                  //               text(
                                  //                 snapshot.data!.data![i]
                                  //                     .children![j].name!,
                                  //                 fontSize: 10.sp,
                                  //               ),
                                  //             ],
                                  //           ),
                                  //         ),
                                  //       )
                                  //     :
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
                                    // iconColor:
                                    //     colors.whitecolor,
                                    // collapsedIconColor:
                                    //     colors.whitecolor,
                                    // backgroundColor:
                                    //     colors.themebluecolor,

                                    backgroundColor:
                                        colors.greyColor.withOpacity(0.2),

                                    shape: InputBorder.none,
                                    title: GestureDetector(
                                      onTap: () async {
                                        await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Products(
                                                      title: snapshot
                                                          .data!
                                                          .data![i]
                                                          .children![j]
                                                          .name!,
                                                      categoryID: snapshot
                                                          .data!
                                                          .data![i]
                                                          .children![j]
                                                          .id!,
                                                      toggleTheme:
                                                          widget.toggleTheme,
                                                    )));
                                        setState(() {});
                                      },
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/png/dot_icon.png",
                                              height: 2.h,
                                              width: 2.h,
                                              // color: colors
                                              //     .whitecolor,
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
                                        onTap: () async {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Products(
                                                        title: snapshot
                                                            .data!
                                                            .data![i]
                                                            .children![j]
                                                            .name!,
                                                        categoryID: snapshot
                                                            .data!
                                                            .data![i]
                                                            .children![j]
                                                            .id!,
                                                        toggleTheme:
                                                            widget.toggleTheme,
                                                      )));
                                          setState(() {});
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
                        // GestureDetector(
                        //   onTap: () async {
                        //     setState(() {
                        //       isExpanded[i] = !isExpanded[i];
                        //       index = i;
                        //     });
                        //     // var response = await apis.subcategoryListApi();
                        //     // if (response!.data!.isNotEmpty) {
                        //     //   await Navigator.push(
                        //     //       // ignore: use_build_context_synchronously
                        //     //       context,
                        //     //       MaterialPageRoute(
                        //     //           builder: (context) =>
                        //     //               CategoryDetailSCreen(
                        //     //                 categoryID:
                        //     //                     snapshot.data!.data![i].id!,
                        //     //               )));
                        //     // } else {
                        //     //   await Navigator.push(
                        //     //       // ignore: use_build_context_synchronously
                        //     //       context,
                        //     //       MaterialPageRoute(
                        //     //           builder: (context) =>
                        //     //               CategoryProductsScreen(
                        //     //                 categoryModel: snapshot.data,
                        //     //                 index: i,
                        //     //                 categoryId:
                        //     //                     snapshot.data!.data![i].id!,
                        //     //               )));
                        //     // }
                        //   },
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(14.0),
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(10),
                        //           color: colors.whitecolor.withOpacity(0.2),
                        //           image: const DecorationImage(
                        //               image: AssetImage(
                        //                   // "assets/png/no_image.jpg"
                        //                   "assets/png/slider_5th_image.jpg"),
                        //               fit: BoxFit.cover,
                        //               opacity: 0.5)),
                        //       child: Center(
                        //           child: Padding(
                        //         padding: const EdgeInsets.all(40.0),
                        //         child: Text(
                        //           snapshot.data!.data![i].name!,
                        //           style: const TextStyle(
                        //               fontSize: 18,
                        //               fontFamily: "OpenSans",
                        //               fontWeight: FontWeight.bold),
                        //           textAlign: TextAlign.center,
                        //         ),
                        //       )),
                        //     ),
                        //   ),
                        // ),
                        // if (isExpanded[
                        //     i]) // Show additional content when expanded
                        //   const ExpansionTile(
                        //     title: Text('Additional Content'),
                        //     children: <Widget>[
                        //       // Additional content goes here
                        //     ],
                        //   ),
                      ],
                    ),
                ],
              ),
            );

            // GridView.count(
            //   crossAxisCount: 2,
            //   crossAxisSpacing: 10,
            //   mainAxisSpacing: 10,
            //   physics: const BouncingScrollPhysics(),
            //   children: snapshot.data!.data!.map((item) {
            //     int index = snapshot.data!.data!.indexOf(item);
            //     return GestureDetector(
            //       onTap: () async {
            //         var response = await apis.subcategoryListApi(item.id!);
            //         if (response!.data!.isNotEmpty) {
            //           await Navigator.push(
            //               // ignore: use_build_context_synchronously
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => CategoryDetailSCreen(
            //                         parentID: item.id!,
            //                         categoryID: item.id!,
            //                       )));
            //         } else {
            //           await Navigator.push(
            //               // ignore: use_build_context_synchronously
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => CategoryProductsScreen(
            //                         categoryModel: snapshot.data,
            //                         index: index,
            //                         categoryId: item.id!,
            //                       )));
            //         }
            //       },
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Card(
            //             elevation: 12,
            //             child: Container(
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10),
            //                 color: Color(
            //                         (math.Random().nextDouble() * 0xFFFFFF)
            //                             .toInt())
            //                     .withOpacity(0.2),
            //                 image: item.imageUrl == null ||
            //                         item.imageUrl!.isEmpty
            //                     ? const DecorationImage(
            //                         image: AssetImage(
            //                             // "assets/png/no_image.jpg"
            //                             "assets/png/slider_3rd_image.jpg"),
            //                         fit: BoxFit.cover,
            //                         opacity: 0.2)
            //                     : DecorationImage(
            //                         image: NetworkImage(item.imageUrl!),
            //                         fit: BoxFit.cover,
            //                       ),
            //               ),
            //               child: Center(
            //                   child: Padding(
            //                 padding: const EdgeInsets.all(4.0),
            //                 child: Text(
            //                   item.name!,
            //                   style: const TextStyle(
            //                       fontSize: 18,
            //                       fontFamily: "OpenSans",
            //                       fontWeight: FontWeight.bold),
            //                   textAlign: TextAlign.center,
            //                 ),
            //               )),
            //             )),
            //       ),
            //     );
            //   }).toList(),
            // );
          } else {
            categoryBloc.categoryBloc(pl);
            return const Center(child: CategoryShimmerr());
          }
        });
  }
}
