import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/product_detail_screen.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/product_detail_tablet.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

SingleChildScrollView youMightAlsoLikeProductsWidget(
    BuildContext context,
    var productsMainCategoryModel,
    var data,
    void Function() toggleTheme,
    StateSetter setState) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        for (int i = 0; i < productsMainCategoryModel.data!.length; i++)
          productsMainCategoryModel.data![i].id! == data.id
              ? Container()
              : GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetail(
                                  screen: "",
                                  data: productsMainCategoryModel.data![i],
                                  productsMainCategoryModel:
                                      productsMainCategoryModel,
                                  toggleTheme: toggleTheme,
                                )));
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: colors.greyColor.withOpacity(0.3))),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5)),
                              color: colors.greyColor.withOpacity(0.1),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5)),
                              child: productsMainCategoryModel
                                          .data![i].primaryImage ==
                                      null
                                  ? Image.asset("assets/png/no_image.jpg",
                                      height: 150, width: 100, fit: BoxFit.fill)
                                  : CachedNetworkImage(
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          Center(
                                            child: CupertinoActivityIndicator(
                                              radius: 1.4.h,
                                            ),
                                          ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      imageUrl: productsMainCategoryModel
                                          .data![i].primaryImage!.urlThumbnail!,
                                      height: 150,
                                      width: 100,
                                      fit: BoxFit.fill),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              productsMainCategoryModel.data![i].name!,
                              style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "OpenSans"),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SpUtil.getString(SpConstUtil.priceList) == ""
                              ? Container()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                      SpUtil.getString(SpConstUtil.priceList)!,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                          const SizedBox(
                            height: 5,
                          ),

                          // const Spacer(),
                          text("\$${productsMainCategoryModel.data![i].price}",
                              fontWeight: FontWeight.bold, fontSize: 15),
                          // const Spacer(),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  )

                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //     width: 180,
                  //     height: 180,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       // color: colors.themebluecolor,
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Column(
                  //         children: [
                  //           const SizedBox(
                  //             height: 5,
                  //           ),
                  //           productsMainCategoryModel
                  //                   .data![i].images!.isNotEmpty
                  //               ? CachedNetworkImage(
                  //                   height: 110,
                  //                   width: 110,
                  //                   progressIndicatorBuilder:
                  //                       (context, url, downloadProgress) =>
                  //                           Center(
                  //                     child: CupertinoActivityIndicator(

                  //                     ),
                  //                   ),
                  //                   errorWidget: (context, url, error) =>
                  //                       const Icon(Icons.error),
                  //                   imageUrl: productsMainCategoryModel
                  //                       .data![i].primaryImage!.urlStandard!,
                  //                 )

                  //               // Image.network(
                  //               //     productsMainCategoryModel
                  //               //         .data![i].primaryImage!.urlStandard!,
                  //               //     height: 110,
                  //               //     width: 110,
                  //               //   )
                  //               : Image.asset(
                  //                   "assets/png/new_collection4.jpg",
                  //                   height: 110,
                  //                   width: 110,
                  //                 ),
                  //           const SizedBox(
                  //             height: 5,
                  //           ),
                  //           Text(
                  //             productsMainCategoryModel.data![i].name!,
                  //             maxLines: 2,
                  //             overflow: TextOverflow.ellipsis,
                  //             textAlign: TextAlign.center,
                  //             style: TextStyle(
                  //               color: colors.blackcolor,
                  //               fontSize: 11,
                  //               fontFamily: "OpenSans",
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  )
      ],
    ),
  );
}

SingleChildScrollView youMightAlsoLikeProductsTabletWidget(BuildContext context,
    var productsMainCategoryModel, var data, void Function() toggleTheme) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        for (int i = 0; i < productsMainCategoryModel.data!.length; i++)
          productsMainCategoryModel.data![i].id! == data.id
              ? Container()
              : GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailTabletScreen(
                                  screen: "",
                                  data: productsMainCategoryModel.data![i],
                                  productsMainCategoryModel:
                                      productsMainCategoryModel,
                                  toggleTheme: toggleTheme,
                                )));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(2.h),
                    child: Container(
                      width: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: colors.greyColor.withOpacity(0.3))),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                  color: colors.greyColor.withOpacity(0.1),
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                  child: productsMainCategoryModel!
                                              .data![i].primaryImage ==
                                          null
                                      ? Image.asset("assets/png/no_image.jpg",
                                          height: 150,
                                          width: 100,
                                          fit: BoxFit.fill)
                                      : CachedNetworkImage(
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                                child:
                                                    CupertinoActivityIndicator(
                                                  radius: 1.4.h,
                                                ),
                                              ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          imageUrl: productsMainCategoryModel
                                              .data![i]
                                              .primaryImage!
                                              .urlThumbnail!,
                                          height: 150,
                                          width: 100,
                                          fit: BoxFit.fill),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      color: colors.whitecolor.withOpacity(0.7),
                                      shape: BoxShape.circle),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset("assets/png/heart.png"),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              productsMainCategoryModel!.data![i].name!,
                              style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "OpenSans"),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                SpUtil.getString(SpConstUtil.priceList)!,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),

                          // const Spacer(),
                          text("\$${productsMainCategoryModel!.data![i].price}",
                              fontWeight: FontWeight.bold, fontSize: 15),
                          // const Spacer(),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ))
      ],
    ),
  );
}
