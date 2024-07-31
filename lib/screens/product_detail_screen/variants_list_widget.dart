import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

SingleChildScrollView variantsListWidget(
    PageController pageController,
    var data,
    int selectedImageIndex,
    void Function(int)
        onImageIndexSelected, // Callback to update selectedImageIndex

    ScrollController scrollController,
    BuildContext context) {
  return SingleChildScrollView(
    controller: scrollController,
    scrollDirection: Axis.horizontal,
    physics: const BouncingScrollPhysics(),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < data.images!.length; i++)
          GestureDetector(
            onTap: () {
              if (selectedImageIndex != i) {
                onImageIndexSelected(
                    i); // Call the callback to update selectedImageIndex
                pageController.animateToPage(
                  i,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: Container(
                margin: const EdgeInsets.only(right: 15, left: 15),
                padding: const EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height / 16,
                width: MediaQuery.of(context).size.height / 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: colors.whitecolor,
                  border: Border.all(
                    color: selectedImageIndex == i
                        ? SpUtil.getBool(SpConstUtil.appTheme)!
                            ? colors.whitecolor
                            : colors.themebluecolor
                        : Colors.transparent,
                  ),
                ),
                child: data.images![i].urlStandard!.isEmpty
                    ? Image.asset("assets/png/no_image.png")
                    : CachedNetworkImage(
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CupertinoActivityIndicator(
                            radius: 1.4.h,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        imageUrl: data.images![i].urlStandard!,
                      )

                //  Image.network(data.images![i].urlStandard!),
                ),
          ),
      ],
    ),
  );
}
