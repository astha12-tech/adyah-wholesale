import 'package:adyah_wholesale/bloc/home_banner_bloc.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/text_component/fontweight.dart';
import 'package:adyah_wholesale/components/text_component/text14.dart';
import 'package:adyah_wholesale/components/text_component/text16.dart';
import 'package:adyah_wholesale/model/home_banner_model.dart';
import 'package:adyah_wholesale/components/shimmer_widget/home_screen_shimmer.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

StreamBuilder<List<HomeBannerModel>> homeBanner(
    ProgressLoader pl, void Function(int) updateIndex, int currentIndex) {
  return StreamBuilder<List<HomeBannerModel>>(
      stream: homeBannerBloc.homeBannerStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              text14new(
                snapshot.error,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () async {
                        await pl.show();
                        await homeBannerBloc
                            .homeBannerBloc(pl)
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
          return snapshot.data!.isEmpty
              ? Center(
                  child: text16("No data", colors.blackcolor, fontWeight.bold),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                      width: double.infinity,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: 1,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          onPageChanged: (index, reason) {
                            updateIndex(index); // Update the currentIndex
                          },
                        ),
                        items: snapshot.data!.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                // margin: EdgeInsets.only(right: 5),
                                // margin: const EdgeInsets.symmetric(
                                //     horizontal: 5.0),
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/png/adyah_logo.png"),
                                      opacity: 0.7,
                                      fit: BoxFit.contain
                                      // opacity: 0.7,
                                      ),
                                  // color: colors.themebluecolor,
                                  // borderRadius: BorderRadius.circular(10)
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: i.bannerImage!,
                                  // progressIndicatorBuilder:
                                  //     (context, url, downloadProgress) =>
                                  //         Center(
                                  //   child: CupertinoActivityIndicator(
                                  //       value: downloadProgress.progress),
                                  // ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.fill,
                                ),
                                // Image.network(
                                //   i.imageUrl!,
                                //   fit: BoxFit.fill,
                                // )
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: snapshot.data!.map((url) {
                        int index = snapshot.data!.indexOf(url);

                        return currentIndex == index
                            ? Container(
                                width: 8.0,
                                height: 8.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colors.themebluecolor),
                              )
                            : Container(
                                width: 8.0,
                                height: 8.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colors.whitecolor,
                                    border:
                                        Border.all(color: colors.blackcolor)),
                              );
                      }).toList(),
                    )
                  ],
                );
        } else {
          homeBannerBloc.homeBannerBloc(pl);
          return const Center(child: SliderViewShimmer());
        }
      });
}
