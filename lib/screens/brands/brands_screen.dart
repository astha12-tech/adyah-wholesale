// ignore_for_file: must_be_immutable

import 'package:adyah_wholesale/bloc/get_brands_bloc.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/components/text_component/text14.dart';
import 'package:adyah_wholesale/global/global.dart';
import 'package:adyah_wholesale/model/get_all_brands_model.dart';
import 'package:adyah_wholesale/screens/products_screen/product_screen.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';

class BrandsScreen extends StatefulWidget {
  void Function() toggleTheme;
  BrandsScreen({super.key, required this.toggleTheme});

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  @override
  Widget build(BuildContext context) {
    int crossAxisCount = MediaQuery.of(context).size.width ~/ 180;
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);

    return Scaffold(
      body: brandWidget(context, pl, crossAxisCount),
    );
  }

  Padding brandWidget(
      BuildContext context, ProgressLoader pl, int crossAxisCount) {
    return Padding(
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
                  "Brands",
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: SpUtil.getBool(SpConstUtil.appTheme)!
                      ? colors.whitecolor
                      : colors.blackcolor,
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<GetAllBrandsModel>(
                stream: getBrandBloc.getAllBrandscategoryStream,
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
                                  await getBrandBloc
                                      .getBrandsBloc(pl)
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
                    return MasonryGridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: snapshot.data!.data!.length,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            setState(() {
                              commonData.alllmainProducts.clear();
                              commonData.isShow = false;
                            });
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Products(
                                          title:
                                              snapshot.data!.data![index].name!,
                                          brandID:
                                              snapshot.data!.data![index].id!,
                                          toggleTheme: widget.toggleTheme,
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
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5)),
                                        child: snapshot.data!.data![index]
                                                .imageUrl!.isEmpty
                                            ? Image.asset(
                                                "assets/png/no_image.jpg",
                                                height: 150,
                                                width: double.infinity,
                                                fit: BoxFit.fill,
                                              )
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
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                                imageUrl: snapshot.data!
                                                    .data![index].imageUrl!,
                                                height: 150,
                                                width: double.infinity,
                                                fit: BoxFit.fill,
                                              ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 35,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, right: 5),
                                          child: Text(
                                              snapshot.data!.data![index].name!,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontFamily: "OpenSans",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13)),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    getBrandBloc.getBrandsBloc(pl);
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
