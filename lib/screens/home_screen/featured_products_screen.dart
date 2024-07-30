// ignore_for_file: unnecessary_null_comparison, must_be_immutable

import 'package:adyah_wholesale/api/urls.dart';
import 'package:adyah_wholesale/bloc/all_featured_product_bloc.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/text_component/text14.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/global/global.dart';

import 'package:adyah_wholesale/model/all_featured_products_model.dart'
    as allfeaturedproductsmodel;
import 'package:adyah_wholesale/screens/product_detail_screen/product_detail_screen.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/product_detail_tablet.dart';
import 'package:adyah_wholesale/components/shimmer_widget/products_shimmer.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';

class FeaturedProductsScreen extends StatefulWidget {
  void Function() toggleTheme;
  FeaturedProductsScreen({super.key, required this.toggleTheme});

  @override
  State<FeaturedProductsScreen> createState() => _FeaturedProductsScreenState();
}

class _FeaturedProductsScreenState extends State<FeaturedProductsScreen> {
  int val = 0;
  final ScrollController _scrollController = ScrollController();
  Set<String> savedWords = <String>{};
  List<int> ids = [];
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = MediaQuery.of(context).size.width ~/ 180;
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
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
                      padding: EdgeInsets.all(0.45.h),
                      child: Image.asset(
                        "assets/png/left.png",
                        color: SpUtil.getBool(SpConstUtil.appTheme)!
                            ? colors.whitecolor
                            : colors.blackcolor,
                      ),
                    ),
                  ),
                ),

                text(
                  "Featured Products",
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: SpUtil.getBool(SpConstUtil.appTheme)!
                      ? colors.whitecolor
                      : colors.blackcolor,
                ),

                // ),
                // )
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<allfeaturedproductsmodel.FeaturedProductModel>(
                stream: allFeaturedProductBloc.featuredproductStream,
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
                                  await allFeaturedProductBloc
                                      .featuredproductsBloc(
                                    pl,
                                    '${urls.v3baseUrl}catalog/products?is_visible=true&include=images,primary_image,primary_image,variants,options&sort=id&direction=desc&is_featured=1&page=$currentPage',
                                  )
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
                            child: text14("No data found", FontWeight.bold))
                        : NotificationListener(
                            onNotification: (notification) {
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
                                  if (_scrollController.position.pixels != 0) {
                                    if (val == 0) {
                                      setState(() {
                                        val++;

                                        currentPage++;
                                        allFeaturedProductBloc.paginatedData(
                                          pl,
                                          currentPage,
                                          '${urls.v3baseUrl}${urls.catalogproducts}?is_visible=true&include=images,primary_image,primary_image,variants,options&sort=id&direction=desc&is_featured=1&page=$currentPage',
                                        );
                                      });
                                    }
                                  }
                                }
                              });
                              setState(() {});
                              return data != null;
                            },
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  MasonryGridView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: snapshot.data!.data!.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: crossAxisCount),
                                      itemBuilder: (context, index) {
                                        String storeLike =
                                            snapshot.data!.data![index].name!;
                                        bool isSaved =
                                            savedWords.contains(storeLike);

                                        return GestureDetector(
                                          onTap: () async {
                                            SizerUtil.deviceType ==
                                                    DeviceType.mobile
                                                ? await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProductDetail(
                                                              data: snapshot
                                                                  .data!
                                                                  .data![index],
                                                              productsMainCategoryModel:
                                                                  snapshot
                                                                      .data!,
                                                              screen: "",
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
                                                                  .data![index],
                                                              productsMainCategoryModel:
                                                                  snapshot
                                                                      .data!,
                                                              toggleTheme: widget
                                                                  .toggleTheme,
                                                            )));
                                            setState(() {});
                                          },
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Card(
                                                elevation: 3,
                                                surfaceTintColor: Colors.white,
                                                // surfaceTintColor:
                                                //     colors.whitecolor,
                                                // color: colors.whitecolor,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          ClipRRect(
                                                              borderRadius: const BorderRadius
                                                                  .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5)),
                                                              child:
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
                                                                    const Icon(Icons
                                                                        .error),
                                                                imageUrl: snapshot
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .primaryImage!
                                                                    .urlStandard!,
                                                                height: 150,
                                                                width: double
                                                                    .infinity,
                                                                fit:
                                                                    BoxFit.fill,
                                                              )),
                                                          Positioned(
                                                            right: 0,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  if (isSaved) {
                                                                    savedWords
                                                                        .remove(
                                                                            storeLike);
                                                                  } else {
                                                                    savedWords.add(
                                                                        storeLike);
                                                                  }
                                                                });
                                                              },
                                                              child: Container(
                                                                height: 35,
                                                                width: 35,
                                                                decoration: BoxDecoration(
                                                                    color: colors
                                                                        .whitecolor
                                                                        .withOpacity(
                                                                            0.7),
                                                                    shape: BoxShape
                                                                        .circle),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: isSaved
                                                                      ? Image
                                                                          .asset(
                                                                          "assets/png/fill_herat.png",
                                                                          color:
                                                                              Colors.red,
                                                                        )
                                                                      : Image.asset(
                                                                          "assets/png/heart.png"),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10,
                                                                right: 10,
                                                                top: 10),
                                                        child: SizedBox(
                                                          height:
                                                              36, // Adjust the height based on your preference
                                                          child: Text(
                                                            snapshot
                                                                .data!
                                                                .data![index]
                                                                .name!,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 10,
                                                              // color: colors
                                                              //     .blackcolor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontFamily:
                                                                  "OpenSans",
                                                            ),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ),
                                                      SpUtil.getString(SpConstUtil
                                                                  .priceList) ==
                                                              ""
                                                          ? Container()
                                                          : Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                CachedNetworkImage(
                                                                    height: 20,
                                                                    width: 20,
                                                                    imageUrl:
                                                                        "https://cdn11.bigcommerce.com//s-gl91ar6pf7//images//stencil//original//image-manager//vip.png"),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                text(
                                                                  SpUtil.getString(
                                                                      SpConstUtil
                                                                          .priceList)!,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ],
                                                            ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      SpUtil.getInt(SpConstUtil
                                                                  .priceListID) ==
                                                              0
                                                          ? text(
                                                              "\$${snapshot.data!.data![index].price}",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15,
                                                            )
                                                          : commonData.allSalePrices[
                                                                      index] ==
                                                                  0.0
                                                              ? text(
                                                                  "\$${snapshot.data!.data![index].price}",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15,
                                                                )
                                                              : Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    text(
                                                                      "\$${commonData.allSalePrices[index]}",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text(
                                                                      "\$${snapshot.data!.data![index].price}",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "OpenSans",
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          color: SpUtil.getBool(SpConstUtil.appTheme)!
                                                                              ? colors.whitecolor.withOpacity(
                                                                                  0.5)
                                                                              : colors.blackcolor.withOpacity(
                                                                                  0.5),
                                                                          fontSize:
                                                                              13,
                                                                          decoration:
                                                                              TextDecoration.lineThrough),
                                                                    )
                                                                  ],
                                                                ),
                                                      const SizedBox(
                                                        height: 5,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )),
                                        );
                                      }),
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
                          );
                  } else {
                    allFeaturedProductBloc.featuredproductsBloc(
                      pl,
                      '${urls.v3baseUrl}catalog/products?is_visible=true&include=images,primary_image,primary_image,variants,options&sort=id&direction=desc&is_featured=1&page=$currentPage',
                    );
                    return const ProductsShimmer();
                  }
                }),
          ),
        ],
      ),
    ));
  }
}
