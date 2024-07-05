// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:adyah_wholesale/api/urls.dart';
import 'package:adyah_wholesale/bloc/featured_product_bloc.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/text_component/text14.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/screens/home_screen/featured_products_screen.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/new_one_product_detail_screen.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/product_detail_tablet.dart';
import 'package:adyah_wholesale/components/shimmer_widget/home_screen_shimmer.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adyah_wholesale/model/products_category_model.dart'
    as productsmaincategorymodel;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';

StreamBuilder<productsmaincategorymodel.ProductsMainCategoryModel>
    featuredProductsWidget(
        ProgressLoader pl,
        int crossAxisCount,
        double itemWidth,
        double itemHeight,
        StateSetter setState,
        Set<String> savedWords,
        void Function() toggleTheme) {
  return StreamBuilder<productsmaincategorymodel.ProductsMainCategoryModel>(
      stream: featuredProductBloc.featuredproductStream,
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
                        await featuredProductBloc
                            .featuredproductsBloc(pl,
                                'https://api.bigcommerce.com/stores/${SpUtil.getString(SpConstUtil.storeHashValue)}/v3/catalog/products?is_visible=true&include=images,primary_image,primary_image,variants,options&sort=id&direction=desc&is_featured=1&page=1&limit=6')
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
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                height: 3,
                color: colors.greyColor.withOpacity(0.3),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12, top: 10),
                child: Row(
                  children: [
                    text("Featured Products",
                        fontSize: SizerUtil.deviceType == DeviceType.mobile
                            ? 11.sp
                            : 8.sp,
                        // color: colors.blackcolor,
                        fontWeight: FontWeight.bold),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FeaturedProductsScreen(
                                      toggleTheme: toggleTheme,
                                    )));
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: text("See All",
                            fontSize: SizerUtil.deviceType == DeviceType.mobile
                                ? 9.sp
                                : 7.sp,
                            // color: colors.themebluecolor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              MasonryGridView.builder(
                  itemCount: snapshot.data!.data!.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount),
                  itemBuilder: (context, index) {
                    String storeLike = snapshot.data!.data![index].name!;
                    bool isSaved = savedWords.contains(storeLike);
                    return GestureDetector(
                      onTap: () async {
                        SizerUtil.deviceType == DeviceType.mobile
                            ? await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetail(
                                          data: snapshot.data!.data![index],
                                          productsMainCategoryModel:
                                              snapshot.data!,
                                          screen: "",
                                          toggleTheme: toggleTheme,
                                        )))
                            : await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProductDetailTabletScreen(
                                          screen: "",
                                          data: snapshot.data!.data![index],
                                          productsMainCategoryModel:
                                              snapshot.data!,
                                          toggleTheme: toggleTheme,
                                        )));
                        setState(() {});
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: colors.greyColor.withOpacity(0.3))),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5)),
                                      child: CachedNetworkImage(
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: CupertinoActivityIndicator(
                                            radius: 1.4.h,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        imageUrl: snapshot.data!.data![index]
                                            .primaryImage!.urlThumbnail!,
                                        height: 150,
                                        width: double.infinity,
                                        fit: BoxFit.fill,
                                        // height: itemHeight,
                                        // width: itemWidth,
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (isSaved) {
                                              savedWords.remove(storeLike);
                                            } else {
                                              savedWords.add(storeLike);
                                            }

                                            debugPrint(
                                                "=== isSaved ===>$isSaved");
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                              color: colors.whitecolor
                                                  .withOpacity(0.7),
                                              shape: BoxShape.circle),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: isSaved
                                                ? Image.asset(
                                                    "assets/png/fill_herat.png",
                                                    color: Colors.red,
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
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: SizedBox(
                                    height:
                                        36, // Adjust the height based on your preference
                                    child: Text(
                                      snapshot.data!.data![index].name!,
                                      style: TextStyle(
                                        fontSize: 10,
                                        // color: colors.blackcolor,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "OpenSans",
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SpUtil.getString(SpConstUtil.priceList) == ""
                                    ? Container()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CachedNetworkImage(
                                              height: 20,
                                              width: 20,
                                              imageUrl:
                                                  "https://cdn11.bigcommerce.com//s-gl91ar6pf7//images//stencil//original//image-manager//vip.png"),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          text(
                                            SpUtil.getString(
                                                SpConstUtil.priceList)!,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                text(
                                  "\$${snapshot.data!.data![index].price}",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ],
                            ),
                          )),
                    );
                  }),
            ],
          );
        } else {
          featuredProductBloc.featuredproductsBloc(pl,
              '${urls.v3baseUrl}catalog/products?is_visible=true&include=images,primary_image,primary_image,variants,options&sort=id&direction=desc&is_featured=1&page=1&limit=6');
          return const Center(child: FeaturedProductsShimmer());
        }
      });
}
