// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:adyah_wholesale/api/api.dart';
import 'package:adyah_wholesale/api/urls.dart';
import 'package:adyah_wholesale/bloc/productsainategory_bloc.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/text_component/fontweight.dart';
import 'package:adyah_wholesale/components/text_component/text14.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/global/global.dart';
import 'package:adyah_wholesale/model/get_wish_list_model.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/product_detail_screen.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/product_detail_tablet.dart';
import 'package:adyah_wholesale/components/shimmer_widget/products_shimmer.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adyah_wholesale/model/products_category_model.dart'
    as productscategorymodel;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';

class Products extends StatefulWidget {
  int? categoryID;
  int? brandID;
  String title;
  void Function() toggleTheme;

  Products(
      {super.key,
      this.categoryID,
      this.brandID,
      required this.title,
      required this.toggleTheme});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  int val = 0;
  Set<String> savedWords = <String>{};
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  GetWishListModel? getWishListModel;

  fetchData(ProgressLoader pl) async {
    try {
      // Assuming apis.getWishListApi(pl) returns Future<GetWishListModel?>
      getWishListModel = await apis.getWishListApi(pl);
      // Now you can work with getWishListModel as GetWishListModel?
      debugPrint('Got wishlist model: $getWishListModel');
    } catch (e) {
      debugPrint('Error fetching wishlist: $e');
      // Handle errors as needed
    }
  }

  @override
  void initState() {
    commonData.alllmainProducts.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);

    int crossAxisCount = MediaQuery.of(context).size.width ~/ 180;
    return Scaffold(
        // appBar: AppBar(
        //   leadingWidth: 14.w,
        //   toolbarHeight: MediaQuery.of(context).size.height / 18,
        //   scrolledUnderElevation: 0,
        //   centerTitle: true,
        //   leading: TextButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //       setState(() {});
        //     },
        //     child: Container(
        //       height: 4.h,
        //       width: 4.h,
        //       decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         border: Border.all(
        //             color: SpUtil.getBool(SpConstUtil.appTheme)!
        //                 ? colors.whitecolor
        //                 : colors.blackcolor),
        //       ),
        //       child: Padding(
        //         padding: EdgeInsets.all(0.7.h),
        //         child: Image.asset(
        //           "assets/png/left.png",
        //           color: SpUtil.getBool(SpConstUtil.appTheme)!
        //               ? colors.whitecolor
        //               : colors.blackcolor,
        //         ),
        //       ),
        //     ),
        //   ),
        //   iconTheme: IconThemeData(color: colors.whitecolor),
        //   title: text(widget.title,
        //       fontSize: 13.sp,
        //       fontWeight: FontWeight.bold,
        //       color: SpUtil.getBool(SpConstUtil.appTheme)!
        //           ? colors.whitecolor
        //           : colors.blackcolor),
        // ),
        body: productsWidget(pl, crossAxisCount));
  }

  Widget productsWidget(ProgressLoader pl, int crossAxisCount) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
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
                widget.title,
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
          child: StreamBuilder<productscategorymodel.ProductsMainCategoryModel>(
              stream: productsMainCategoryBloc.productsMainCategorystream,
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
                                await productsMainCategoryBloc
                                    .productsMaincategoryBloc(
                                        widget.categoryID,
                                        "",
                                        pl,
                                        widget.categoryID == null
                                            ? '${urls.storesbaseUrl}${urls.products}?is_visible=true&include=images,primary_image,primary_image,variants,options&page=1&brand_id=${widget.brandID}&is_featured=""&page=1&direction=desc'
                                            : '${urls.storesbaseUrl}${urls.products}?is_visible=true&include=images,primary_image,primary_image,variants,options&page=1&categories:in=${widget.categoryID}&is_featured=""&page=1&direction=desc')
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
                          child: text(
                            "No data",
                            fontWeight: fontWeight.bold,
                          ),
                        )
                      : NotificationListener(
                          onNotification: (ScrollNotification scrollInfo) {
                            setState(() {
                              val = 0;
                            });
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
                                      productsMainCategoryBloc.paginatedData(
                                          widget.categoryID,
                                          pl,
                                          currentPage,
                                          "",
                                          widget.categoryID == null
                                              ? '${urls.storesbaseUrl}${urls.products}?is_visible=true&include=images,primary_image,primary_image,variants,options&page=1&brand_id=${widget.brandID}&is_featured=""&page=$currentPage&direction=desc'
                                              : '${urls.storesbaseUrl}${urls.products}?is_visible=true&include=images,primary_image,primary_image,variants,options&page=1&categories:in=${widget.categoryID}&is_featured=""&page=$currentPage&direction=desc');
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
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.data!.length,
                                  gridDelegate:
                                      SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                  ),
                                  itemBuilder: (context, index) {
                                    // String storeLike =
                                    //     snapshot.data!.data![index].name!;
                                    // bool isSaved = savedWords.contains(storeLike);
                                    bool isInWishList = false;
                                    if (getWishListModel != null &&
                                        getWishListModel!.data != null) {
                                      for (var item
                                          in getWishListModel!.data!) {
                                        for (var subitem in item.items!) {
                                          if (subitem.productId ==
                                              snapshot.data!.data![index].id) {
                                            isInWishList = true;
                                            break;
                                          }
                                        }
                                        if (isInWishList) {
                                          break;
                                        }
                                      }
                                    }
                                    return GestureDetector(
                                      onTap: () async {
                                        SizerUtil.deviceType ==
                                                DeviceType.mobile
                                            ? await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductDetail(
                                                          screen: "",
                                                          data: snapshot.data!
                                                              .data![index],
                                                          productsMainCategoryModel:
                                                              snapshot.data!,
                                                          toggleTheme: widget
                                                              .toggleTheme,
                                                        )))
                                            : await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductDetailTabletScreen(
                                                          screen: "",
                                                          data: snapshot.data!
                                                              .data![index],
                                                          productsMainCategoryModel:
                                                              snapshot.data!,
                                                          toggleTheme: widget
                                                              .toggleTheme,
                                                        )));
                                        setState(() {});
                                      },
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Card(
                                            elevation: 3,
                                            surfaceTintColor: Colors.white,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5)),
                                                          child: snapshot
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .primaryImage ==
                                                                  null
                                                              ? Image.asset(
                                                                  "assets/png/no_image.jpg",
                                                                  height: 150,
                                                                  width: double
                                                                      .infinity,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                )
                                                              : CachedNetworkImage(
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
                                                                      .data![
                                                                          index]
                                                                      .primaryImage!
                                                                      .urlStandard!,
                                                                  height: 150,
                                                                  width: double
                                                                      .infinity,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                )),
                                                      Positioned(
                                                        right: 0,
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                            int productId =
                                                                snapshot
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .id!;

                                                            if (getWishListModel!
                                                                .data!
                                                                .isEmpty) {
                                                              await pl.show();
                                                              await apis
                                                                  .createWishListApi(
                                                                      pl,
                                                                      productId);
                                                              // await productsMainCategoryBloc.productsMaincategoryBloc(
                                                              //     widget
                                                              //         .categoryID,
                                                              //     "",
                                                              //     pl,
                                                              //     widget.categoryID ==
                                                              //             null
                                                              //         ? '${urls.storesbaseUrl}${urls.products}?is_visible=true&include=images,primary_image,primary_image,variants,options&page=1&brand_id=${widget.brandID}&is_featured=""&page=$currentPage'
                                                              //         : '${urls.storesbaseUrl}${urls.products}?is_visible=true&include=images,primary_image,primary_image,variants,options&page=1&categories:in=${widget.categoryID}&is_featured=""&page=$currentPage');
                                                              await fetchData(
                                                                  pl);
                                                              await pl.hide();

                                                              setState(() {
                                                                savedWords.add(
                                                                    snapshot
                                                                        .data!
                                                                        .data![
                                                                            index]
                                                                        .name!);
                                                              });
                                                            } else {
                                                              int wishlistId =
                                                                  getWishListModel!
                                                                      .data![0]
                                                                      .id!;

                                                              int itemId = getWishListModel!
                                                                  .data![0]
                                                                  .items!
                                                                  .indexWhere((item) =>
                                                                      item.productId ==
                                                                      productId);

                                                              bool
                                                                  isInWishList =
                                                                  itemId != -1;

                                                              if (isInWishList) {
                                                                await pl.show();
                                                                await apis.deleteitemsWishListApi(
                                                                    pl,
                                                                    wishlistId,
                                                                    productId,
                                                                    getWishListModel!
                                                                        .data![
                                                                            0]
                                                                        .items![
                                                                            itemId]
                                                                        .id);
                                                                // await productsMainCategoryBloc.productsMaincategoryBloc(
                                                                //     widget
                                                                //         .categoryID,
                                                                //     "",
                                                                //     pl,
                                                                //     widget.categoryID ==
                                                                //             null
                                                                //         ? '${urls.storesbaseUrl}${urls.products}?is_visible=true&include=images,primary_image,primary_image,variants,options&page=1&brand_id=${widget.brandID}&is_featured=""&page=$currentPage'
                                                                //         : '${urls.storesbaseUrl}${urls.products}?is_visible=true&include=images,primary_image,primary_image,variants,options&page=1&categories:in=${widget.categoryID}&is_featured=""&page=$currentPage');
                                                                await fetchData(
                                                                    pl);
                                                                await pl.hide();

                                                                setState(() {
                                                                  savedWords.remove(
                                                                      snapshot
                                                                          .data!
                                                                          .data![
                                                                              index]
                                                                          .name!);
                                                                });
                                                              } else {
                                                                // Not in wishlist, add it to the existing wishlist
                                                                await pl.show();
                                                                await apis.addToitemsWishListApi(
                                                                    pl,
                                                                    wishlistId,
                                                                    productId);
                                                                // await productsMainCategoryBloc.productsMaincategoryBloc(
                                                                //     widget
                                                                //         .categoryID,
                                                                //     "",
                                                                //     pl,
                                                                //     widget.categoryID ==
                                                                //             null
                                                                //         ? '${urls.storesbaseUrl}${urls.products}?is_visible=true&include=images,primary_image,primary_image,variants,options&page=1&brand_id=${widget.brandID}&is_featured=""&page=$currentPage'
                                                                //         : '${urls.storesbaseUrl}${urls.products}?is_visible=true&include=images,primary_image,primary_image,variants,options&page=1&categories:in=${widget.categoryID}&is_featured=""&page=$currentPage');
                                                                await fetchData(
                                                                    pl);
                                                                await pl.hide();

                                                                setState(() {
                                                                  savedWords.add(
                                                                      snapshot
                                                                          .data!
                                                                          .data![
                                                                              index]
                                                                          .name!);
                                                                });
                                                              }
                                                            }
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
                                                                      .all(8.0),
                                                              child:
                                                                  isInWishList
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
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10,
                                                            top: 10),
                                                    child: SizedBox(
                                                      height:
                                                          36, // Adjust the height based on your preference
                                                      child: Text(
                                                        snapshot.data!
                                                            .data![index].name!,
                                                        style: const TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontFamily:
                                                              "OpenSans",
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.center,
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
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                        )
                                                      : commonData.alllmainProducts[
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
                                                                  "\$${commonData.alllmainProducts[index]}",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15,
                                                                ),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  "\$${snapshot.data!.data![index].price}",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "OpenSans",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color: SpUtil.getBool(SpConstUtil
                                                                              .appTheme)!
                                                                          ? colors.whitecolor.withOpacity(
                                                                              0.5)
                                                                          : colors.blackcolor.withOpacity(
                                                                              0.5),
                                                                      fontSize:
                                                                          13,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .lineThrough),
                                                                )
                                                              ],
                                                            ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  // Padding(
                                                  //   padding:
                                                  //       const EdgeInsets.all(
                                                  //           8.0),
                                                  //   child: Container(
                                                  //     decoration: BoxDecoration(
                                                  //         color: colors
                                                  //             .themebluecolor,
                                                  //         borderRadius:
                                                  //             BorderRadius
                                                  //                 .circular(
                                                  //                     10)),
                                                  //     child: Padding(
                                                  //       padding:
                                                  //           const EdgeInsets
                                                  //               .all(8.0),
                                                  //       child: Row(
                                                  //         children: [
                                                  //           const Spacer(),
                                                  //           text("View Item",
                                                  //               color: colors
                                                  //                   .whitecolor),
                                                  //           const SizedBox(
                                                  //             width: 10,
                                                  //           ),
                                                  //           Container(
                                                  //             height: 25,
                                                  //             width: 25,
                                                  //             decoration: BoxDecoration(
                                                  //                 shape: BoxShape
                                                  //                     .circle,
                                                  //                 color: colors
                                                  //                     .whitecolor),
                                                  //             child: Padding(
                                                  //               padding:
                                                  //                   const EdgeInsets
                                                  //                       .all(
                                                  //                       5.0),
                                                  //               child:
                                                  //                   Image.asset(
                                                  //                 "assets/png/next.png",
                                                  //                 color: colors
                                                  //                     .themebluecolor,
                                                  //               ),
                                                  //             ),
                                                  //           ),
                                                  //           const Spacer(),
                                                  //         ],
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          )),
                                    );
                                  },
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
                        );
                } else {
                  productsMainCategoryBloc.productsMaincategoryBloc(
                      widget.categoryID,
                      "",
                      pl,
                      widget.categoryID == null
                          ? '${urls.storesbaseUrl}${urls.products}?is_visible=true&include=images,primary_image,primary_image,variants,options&page=1&brand_id=${widget.brandID}&is_featured=""&page=1&direction=desc'
                          : '${urls.storesbaseUrl}${urls.products}?is_visible=true&include=images,primary_image,primary_image,variants,options&page=1&categories:in=${widget.categoryID}&is_featured=""&page=1&direction=desc');
                  fetchData(pl);
                  return const ProductsShimmer();
                }
              }),
        ),
      ],
    );
  }
}
