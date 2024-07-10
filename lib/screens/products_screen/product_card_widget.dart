import 'package:adyah_wholesale/api/urls.dart';
import 'package:adyah_wholesale/bloc/productsainategory_bloc.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/text_component/fontweight.dart';
import 'package:adyah_wholesale/components/text_component/text14.dart';
import 'package:adyah_wholesale/components/text_component/text16.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/global/global.dart';

import 'package:adyah_wholesale/screens/product_detail_screen/product_detail_screen.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/product_detail_tablet.dart';
import 'package:adyah_wholesale/components/shimmer_widget/products_shimmer.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adyah_wholesale/model/products_category_model.dart'
    as productscategorymodel;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';

StreamBuilder<productscategorymodel.ProductsMainCategoryModel> productCards(
    ProgressLoader pl,
    int crossAxisCount,
    int categoryID,
    StateSetter setState,
    ScrollController scrollController,
    int currentPage,
    int val,
    bool isDarkMode,
    void Function() toggleTheme) {
  return StreamBuilder<productscategorymodel.ProductsMainCategoryModel>(
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
                  // width: 70,
                  child: ElevatedButton(
                      onPressed: () async {
                        await pl.show();
                        await productsMainCategoryBloc
                            .productsMaincategoryBloc(categoryID, "", pl,
                                '${urls.storesbaseUrl}${urls.products}?is_visible=true&include=images,primary_image,primary_image,variants,options&page=1&categories:in=$categoryID&is_featured=""&page=$currentPage')
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
                  child: text16("No data", colors.blackcolor, fontWeight.bold),
                )
              : NotificationListener(
                  onNotification: (ScrollNotification scrollInfo) {
                    setState(() {
                      val = 0;
                    });
                    // ignore: prefer_typing_uninitialized_variables
                    var data;
                    scrollController.addListener(() {
                      setState(() {
                        commonData.isShow = true;
                      });
                      if (scrollController.position.atEdge) {
                        if (scrollController.position.pixels != 0) {
                          if (val == 0) {
                            setState(() {
                              val++;

                              currentPage++;
                              productsMainCategoryBloc.productsMaincategoryBloc(
                                  categoryID,
                                  "",
                                  pl,
                                  '${urls.storesbaseUrl}${urls.products}?is_visible=true&include=images,primary_image,primary_image,variants,options&page=1&categories:in=$categoryID&is_featured=""&page=$currentPage');
                            });
                          }
                        }
                      }
                    });
                    setState(() {});
                    // ignore: unnecessary_null_comparison
                    return data != null;
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          MasonryGridView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data!.data!.length,
                            gridDelegate:
                                SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  SizerUtil.deviceType == DeviceType.mobile
                                      ? await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetail(
                                                    screen: "",
                                                    data: snapshot
                                                        .data!.data![index],
                                                    productsMainCategoryModel:
                                                        snapshot.data!,
                                                    toggleTheme: toggleTheme,
                                                  )))
                                      : await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetailTabletScreen(
                                                    screen: "",
                                                    data: snapshot
                                                        .data!.data![index],
                                                    productsMainCategoryModel:
                                                        snapshot.data!,
                                                    toggleTheme: toggleTheme,
                                                  )));
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Card(
                                    elevation: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: colors.whitecolor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          const Spacer(),
                                          snapshot.data!.data![index].images!
                                                  .isNotEmpty
                                              ? Image.network(
                                                  snapshot
                                                      .data!
                                                      .data![index]
                                                      .primaryImage!
                                                      .urlStandard!,
                                                  height: 110,
                                                  width: 110,
                                                )
                                              : Image.asset(
                                                  "assets/png/new_collection4.jpg",
                                                  height: 110,
                                                  width: 110,
                                                ),
                                          const Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4, right: 4),
                                            child: Text(
                                              snapshot.data!.data![index].name!,
                                              style: TextStyle(
                                                color: colors.blackcolor,
                                                fontSize: 13,
                                                fontFamily: "OpenSans",
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          const Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: colors.themebluecolor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    const Spacer(),
                                                    text("View Item",
                                                        color:
                                                            colors.whitecolor),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: colors
                                                              .whitecolor),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Image.asset(
                                                          "assets/png/next.png",
                                                          color: colors
                                                              .themebluecolor,
                                                        ),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          )
                                          // const Spacer(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
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
                  ),
                );
        } else {
          productsMainCategoryBloc.productsMaincategoryBloc(categoryID, "", pl,
              '${urls.storesbaseUrl}${urls.products}?is_visible=true&include=images,primary_image,primary_image,variants,options&page=1&categories:in=$categoryID&is_featured=""&page=$currentPage');
          return const ProductsShimmer();
        }
      });
}
