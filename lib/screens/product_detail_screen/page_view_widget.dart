import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

SizedBox pageviewWidget(
  PageController pageController,
  var data,
  int selectedImageIndex,
  void Function(int) onImageIndexSelected,
) {
  return SizedBox(
    height: 300,
    width: double.infinity,
    child: data.images!.isEmpty
        ? Image.asset(
            "assets/png/no_image.png",
            height: 300,
            width: double.infinity,
          )
        : PageView.builder(
            controller: pageController,
            itemCount: data.images!.length,
            onPageChanged: (int index) {
              if (selectedImageIndex != index) {
                onImageIndexSelected(index);
              }
            },
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                  height: 300,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                        child: CupertinoActivityIndicator(
                          radius: 1.4.h,
                        ),
                      ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  imageUrl: data.images![index].urlStandard!,
                  fit: BoxFit.fill);
              // Image.network(
              //   data.images![index].urlStandard!,
              //   height: 300,
              //   width: double.infinity,
              // );
            },
          ),
  );
}

SizedBox pageviewTabletWidget(
    PageController pageController,
    var data,
    int selectedImageIndex,
    void Function(int) onImageIndexSelected,
    BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height / 3,
    width: double.infinity,
    child: data.images!.isEmpty
        ? Image.asset(
            "assets/png/no_image.png",
            height: MediaQuery.of(context).size.height / 3,
            width: double.infinity,
          )
        : PageView.builder(
            controller: pageController,
            itemCount: data.images!.length,
            onPageChanged: (int index) {
              if (selectedImageIndex != index) {
                onImageIndexSelected(index);
              }
            },
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                  height: MediaQuery.of(context).size.height / 3,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                        child: CupertinoActivityIndicator(
                          radius: 1.4.h,
                        ),
                      ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  imageUrl: data.images![index].urlStandard!,
                  fit: BoxFit.fill);
              // Image.network(
              //   data.images![index].urlStandard!,
              //   height: 300,
              //   width: double.infinity,
              // );
            },
          ),
  );
}
