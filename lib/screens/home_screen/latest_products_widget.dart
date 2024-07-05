import 'package:adyah_wholesale/bloc/latest_product_bloc.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/text_component/text14.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/screens/home_screen/latest_products_screen.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/new_one_product_detail_screen.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/product_detail_tablet.dart';
import 'package:adyah_wholesale/components/shimmer_widget/home_screen_shimmer.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adyah_wholesale/model/latest_product_model.dart'
    as productsmaincategorymodel;
import 'package:sizer/sizer.dart';

StreamBuilder<productsmaincategorymodel.LatestProductModel>
    latestProductsWidget(
        ProgressLoader pl, void Function() toggleTheme, StateSetter setState) {
  return StreamBuilder<productsmaincategorymodel.LatestProductModel>(
      stream: latestProductBloc.latestproductStream,
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
                        await latestProductBloc
                            .latestproductsBloc(pl)
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
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    text("Latest Products",
                        fontSize: SizerUtil.deviceType == DeviceType.mobile
                            ? 11.sp
                            : 8.sp,
                        fontWeight: FontWeight.bold),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LatestProductsScreen(
                                      toggleTheme: toggleTheme,
                                    )));
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: text("See All",
                            fontSize: SizerUtil.deviceType == DeviceType.mobile
                                ? 9.sp
                                : 7.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    for (int i = 0; i < snapshot.data!.data!.length; i++)
                      GestureDetector(
                          onTap: () async {
                            SizerUtil.deviceType == DeviceType.mobile
                                ? await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetail(
                                              screen: "",
                                              data: snapshot.data!.data![i],
                                              productsMainCategoryModel:
                                                  snapshot.data,
                                              toggleTheme: toggleTheme,
                                            )))
                                : await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailTabletScreen(
                                              screen: "",
                                              data: snapshot.data!.data![i],
                                              productsMainCategoryModel:
                                                  snapshot.data!,
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
                                      color:
                                          colors.greyColor.withOpacity(0.3))),
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
                                          color:
                                              colors.greyColor.withOpacity(0.1),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5)),
                                          child: snapshot.data!.data![i]
                                                      .primaryImage ==
                                                  null
                                              ? Image.asset(
                                                  "assets/png/no_image.jpg",
                                                  height: 150,
                                                  width: 100,
                                                  fit: BoxFit.fill)
                                              : CachedNetworkImage(
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              downloadProgress) =>
                                                          Center(
                                                            child:
                                                                CupertinoActivityIndicator(
                                                              radius: 1.4.h,
                                                            ),
                                                          ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                  imageUrl: snapshot
                                                      .data!
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
                                              color: colors.whitecolor
                                                  .withOpacity(0.7),
                                              shape: BoxShape.circle),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                "assets/png/heart.png"),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      snapshot.data!.data![i].name!,
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
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            text(
                                              SpUtil.getString(
                                                  SpConstUtil.priceList)!,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ],
                                        ),
                                  const SizedBox(
                                    height: 5,
                                  ),

                                  // const Spacer(),
                                  text("\$${snapshot.data!.data![i].price}",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
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
              ),
              const SizedBox(
                height: 15,
              )
            ],
          );
        } else {
          latestProductBloc.latestproductsBloc(pl);
          return const Center(child: LatestProductsShimmer());
        }
      });
}
