// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:adyah_wholesale/bloc/search_products_bloc.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/text_component/text14.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/global/global.dart';
import 'package:adyah_wholesale/model/products_category_model.dart'
    as productscategorymodel;
import 'package:adyah_wholesale/screens/product_detail_screen/product_detail_screen.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/product_detail_tablet.dart';
import 'package:adyah_wholesale/components/shimmer_widget/search_product_shimmer.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SearchScreen extends StatefulWidget {
  void Function() toggleTheme;
  SearchScreen({super.key, required this.toggleTheme});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String search = "";
  int val = 0;
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);
    return Scaffold(
      // backgroundColor: colors.whitecolor.withOpacity(0.97),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // border: Border.all(
                      //     color: SpUtil.getBool(SpConstUtil.appTheme)!
                      //         ? colors.whitecolor
                      //         : colors.blackcolor),
                      color: colors.kSecondaryColor.withOpacity(0.2),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(0.45.h),
                      child: Image.asset("assets/png/left.png",
                          color: SpUtil.getBool(SpConstUtil.appTheme)!
                              ? colors.whitecolor
                              : colors.blackcolor),
                    ),
                  ),
                ),
                Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        cursorColor: SpUtil.getBool(SpConstUtil.appTheme)!
                            ? colors.whitecolor
                            : colors.blackcolor,
                        style: TextStyle(
                            color: SpUtil.getBool(SpConstUtil.appTheme)!
                                ? colors.whitecolor
                                : colors.blackcolor),
                        autofocus: true,
                        onFieldSubmitted: (value) async {
                          debugPrint("==== value =====>$value");
                          setState(() {
                            search = value;
                          });
                          searchProductBloc.searchproductsBloc(pl, search);
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: colors.kSecondaryColor.withOpacity(0.1),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          border: searchOutlineInputBorder,
                          focusedBorder: searchOutlineInputBorder,
                          enabledBorder: searchOutlineInputBorder,
                          hintText: "Search product",
                          prefixIcon: const Icon(Icons.search),
                        ),
                      ),
                    )),
              ],
            ),
          ),
          search.isEmpty
              ? text("")
              : StreamBuilder<productscategorymodel.ProductsMainCategoryModel>(
                  stream: searchProductBloc.searchproductStream,
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
                                    await searchProductBloc
                                        .searchproductsBloc(pl, search)
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
                      return snapshot.data!.data!.isEmpty
                          ? Center(
                              child: text("No Data"),
                            )
                          : NotificationListener(
                              onNotification: (ScrollNotification scrollInfo) {
                                setState(() {
                                  val = 0;
                                });
                                // ignore: prefer_typing_uninitialized_variables
                                var data;
                                _scrollController.addListener(() {
                                  setState(() {
                                    commonData.isShow = true;
                                  });
                                  if (_scrollController.position.atEdge) {
                                    if (_scrollController.position.pixels !=
                                        0) {
                                      if (val == 0) {
                                        setState(() {
                                          val++;

                                          currentPage++;
                                          searchProductBloc.paginatedData(
                                              pl, currentPage, search);
                                        });
                                      }
                                    }
                                  }
                                });
                                setState(() {});

                                return data != null;
                              },
                              child: Expanded(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  controller: _scrollController,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                32),
                                        child: text("Results",
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                52,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      for (int i = 0;
                                          i < snapshot.data!.data!.length;
                                          i++)
                                        GestureDetector(
                                          onTap: () async {
                                            SizerUtil.deviceType ==
                                                    DeviceType.mobile
                                                ? await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProductDetail(
                                                              screen: "",
                                                              data: snapshot
                                                                  .data!
                                                                  .data![i],
                                                              productsMainCategoryModel:
                                                                  snapshot
                                                                      .data!,
                                                              toggleTheme: widget
                                                                  .toggleTheme,
                                                            )))
                                                : await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProductDetailTabletScreen(
                                                              screen: "",
                                                              data: snapshot
                                                                  .data!
                                                                  .data![i],
                                                              productsMainCategoryModel:
                                                                  snapshot
                                                                      .data!,
                                                              toggleTheme: widget
                                                                  .toggleTheme,
                                                            )));
                                            setState(() {});
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    62,
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    62,
                                                top: 5,
                                                bottom: 5),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            11,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            11,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: snapshot
                                                                  .data!
                                                                  .data![i]
                                                                  .images!
                                                                  .isNotEmpty
                                                              ?
                                                              // Image.network(
                                                              //     snapshot
                                                              //         .data!
                                                              //         .data![i]
                                                              //         .primaryImage!
                                                              //         .urlStandard!,
                                                              //     height: 70,
                                                              //     width: 70,
                                                              // )
                                                              CachedNetworkImage(
                                                                  progressIndicatorBuilder:
                                                                      (context,
                                                                              url,
                                                                              downloadProgress) =>
                                                                          Center(
                                                                    child:
                                                                        CupertinoActivityIndicator(
                                                                      radius:
                                                                          1.4.h,
                                                                    ),
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      const Icon(
                                                                          Icons
                                                                              .error),
                                                                  imageUrl: snapshot
                                                                      .data!
                                                                      .data![i]
                                                                      .primaryImage!
                                                                      .urlStandard!,
                                                                  height: 70,
                                                                  width: 70,
                                                                )
                                                              : Image.asset(
                                                                  "assets/png/no_image.png",
                                                                  height: 70,
                                                                  width: 70,
                                                                ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            text(
                                                                "${snapshot.data!.data![i].name}",
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    65,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      text(
                                                          "\$${snapshot.data!.data![i].price}",
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              42,
                                                          color: Colors.green),
                                                    ],
                                                  ),
                                                  const Divider()
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      commonData.isShow == true
                                          ? Center(
                                              child: CupertinoActivityIndicator(
                                                radius: 1.4.h,
                                              ),
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ),
                            );
                    } else {
                      searchProductBloc.searchproductsBloc(pl, search);
                      return const Expanded(
                          child: Center(child: SearchShimmer()));
                    }
                  })
        ],
      ),
    );
  }

  final searchOutlineInputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide.none,
  );
}
