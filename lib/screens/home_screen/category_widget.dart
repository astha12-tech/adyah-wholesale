// ignore_for_file: prefer_const_constructors

import 'package:adyah_wholesale/bloc/parent_category_bloc.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/text_component/fontweight.dart';
import 'package:adyah_wholesale/components/text_component/text14.dart';
import 'package:adyah_wholesale/components/text_component/text16.dart';
import 'package:adyah_wholesale/global/global.dart';
import 'package:adyah_wholesale/model/parent_category_model.dart';
import 'package:adyah_wholesale/screens/products_screen/product_screen.dart';
import 'package:adyah_wholesale/components/shimmer_widget/home_screen_shimmer.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

StreamBuilder<ParentCategoryModel> categoryWidget(
    ProgressLoader pl, void Function() toggleTheme, StateSetter setState) {
  return StreamBuilder<ParentCategoryModel>(
      stream: parentCategoryBloc.parentcategoryStream,
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
                        await parentCategoryBloc
                            .parentcategoryBloc(pl)
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
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int index = 0;
                              index < snapshot.data!.data!.length;
                              index++)
                            GestureDetector(
                              onTap: () {
                                debugPrint("==== tapped ====");
                                setState(() {
                                  commonData.alllmainProducts.clear();
                                  commonData.isShow = false;
                                  debugPrint(
                                      "=== category page commonData.isShow ===>${commonData.isShow}");
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Products(
                                              title: snapshot
                                                  .data!.data![index].name!,
                                              categoryID: snapshot.data!
                                                  .data![index].categoryId!,
                                              toggleTheme: toggleTheme,
                                            )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 8,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: colors.whitecolor,
                                        ),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              15,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              15,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color((math.Random()
                                                              .nextDouble() *
                                                          0xFFFFFF)
                                                      .toInt())
                                                  .withOpacity(0.2)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: snapshot.data!.data![index]
                                                    .imageUrl!.isEmpty
                                                ? Image.asset(
                                                    "assets/png/no_image.png",
                                                    color: colors.blackcolor,
                                                  )
                                                : Image.network(snapshot.data!
                                                    .data![index].imageUrl!),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${snapshot.data!.data![index].name}",
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                85,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "OpenSans"),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                );
        } else {
          parentCategoryBloc.parentcategoryBloc(pl);
          return const Center(child: CategoryShimmer());
        }
      });
}
