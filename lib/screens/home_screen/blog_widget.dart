// ignore_for_file: prefer_const_constructors
import 'package:adyah_wholesale/bloc/get_blog_bloc.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/text_component/fontweight.dart';
import 'package:adyah_wholesale/components/text_component/text14.dart';
import 'package:adyah_wholesale/components/text_component/text16.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/model/get_blog_model.dart';
import 'package:adyah_wholesale/screens/home_screen/all_blog_screen.dart';
import 'package:adyah_wholesale/screens/home_screen/blog_detail_screen.dart';
import 'package:adyah_wholesale/components/shimmer_widget/home_screen_shimmer.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';


StreamBuilder<List<GetBlogModel>> blogWidget(ProgressLoader pl) {

  return StreamBuilder<List<GetBlogModel>>(
      stream: blogBloc.blogStream,
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
                        await blogBloc
                            .blogBlocc(pl,
                                "https://api.bigcommerce.com/stores/${SpUtil.getString(SpConstUtil.storeHashValue)}/v2/blog/posts?is_published=true&limit=5")
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 3,
                      color: colors.greyColor.withOpacity(0.3),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          text("Our Blog Posts",
                              fontSize:
                                  SizerUtil.deviceType == DeviceType.mobile
                                      ? 11.sp
                                      : 8.sp,
                              fontWeight: FontWeight.bold),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AllBlogsScreen()));
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: text("See All",
                                  fontSize:
                                      SizerUtil.deviceType == DeviceType.mobile
                                          ? 9.sp
                                          : 7.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    for (int i = 0; i < snapshot.data!.length; i++)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FlutterBlogDetailScreen(
                                        blogList: snapshot.data![i],
                                      )));
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Padding(
                            padding: EdgeInsets.all(2.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                snapshot.data![i].thumbnailPath!.isEmpty
                                    ? Image.asset(
                                        "assets/png/no_image.png",
                                        height: 12.h,
                                        width: 18.h,
                                        fit: BoxFit.fill,
                                      )
                                    : CachedNetworkImage(
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: CupertinoActivityIndicator(
                                            radius: 1.4.h,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        imageUrl:
                                            "https://adyahwholesale.com${snapshot.data![i].thumbnailPath!}",
                                        height: 12.h,
                                        width: 18.h,
                                        fit: BoxFit.fill,
                                      ),
                                // Image.network(
                                //     "https://adyahwholesale.com${snapshot.data![i].thumbnailPath!}",
                                //     height: 90,
                                //     width: 140,
                                //     errorBuilder:
                                //         (context, error, stackTrace) {
                                //       return Image.asset(
                                //         "assets/png/no_image.png",
                                //         height: 90,
                                //         width: 140,
                                //       );
                                //     },
                                //     fit: BoxFit.fill,
                                //   ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      text(snapshot.data![i].title!,
                                          fontSize: 9.sp),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Row(
                                        children: [
                                          text(
                                              DateFormat('MMMM dd, yyyy')
                                                  .format(snapshot.data![i]
                                                      .publishedDate!.date!),
                                              fontSize: 8.sp),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Image.asset(
                                            "assets/png/comment.png",
                                            height: 2.h,
                                            width: 2.h,
                                            color: SpUtil.getBool(
                                                    SpConstUtil.appTheme)!
                                                ? colors.whitecolor
                                                : colors.blackcolor,
                                          ),
                                          SizedBox(
                                            width: 1.w,
                                          ),
                                          text("0", fontSize: 8.sp),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                );
        } else {
          blogBloc.blogBlocc(pl,
              "https://api.bigcommerce.com/stores/${SpUtil.getString(SpConstUtil.storeHashValue)}/v2/blog/posts?is_published=true&limit=5");
          return Center(child: ShimmerLayout());
        }
      });
}
