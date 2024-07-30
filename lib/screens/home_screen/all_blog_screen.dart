// ignore_for_file: prefer_const_constructors

import 'package:adyah_wholesale/bloc/get_blog_bloc.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/text_component/text14.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/model/get_blog_model.dart';
import 'package:adyah_wholesale/screens/home_screen/blog_detail_screen.dart';
import 'package:adyah_wholesale/components/shimmer_widget/home_screen_shimmer.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class AllBlogsScreen extends StatefulWidget {
  const AllBlogsScreen({super.key});

  @override
  State<AllBlogsScreen> createState() => _AllBlogsScreenState();
}

class _AllBlogsScreenState extends State<AllBlogsScreen> {
  String search = "";
  @override
  Widget build(BuildContext context) {
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: SpUtil.getBool(SpConstUtil.appTheme)!
                      ? colors.whitecolor
                      : colors.blackcolor),
            ),
            child: Padding(
              padding: EdgeInsets.all(0.45.h),
              child: Image.asset("assets/png/left.png",
                  color: SpUtil.getBool(SpConstUtil.appTheme)!
                      ? colors.whitecolor
                      : colors.blackcolor),
            ),
          ),
        ),
        scrolledUnderElevation: 0,
        toolbarHeight: MediaQuery.of(context).size.height / 18,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: text("Blogs",
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: SpUtil.getBool(SpConstUtil.appTheme)!
                ? colors.whitecolor
                : colors.blackcolor),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: StreamBuilder<List<GetBlogModel>>(
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
                              child: ElevatedButton(
                                  onPressed: () async {
                                    await pl.show();
                                    await blogBloc
                                        .blogBlocc(pl,
                                            "https://api.bigcommerce.com/stores/${SpUtil.getString(SpConstUtil.storeHashValue)}/v2/blog/posts?is_published=true")
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
                        children: [
                          for (int i = 0; i < snapshot.data!.length; i++)
                            snapshot.data![i].title!
                                    .toLowerCase()
                                    .contains(search.toLowerCase())
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                FlutterBlogDetailScreen(
                                              blogList: snapshot.data![i],
                                            ),
                                          ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, top: 10),
                                      child: Card(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(
                                                                10)),
                                                child: SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      5,
                                                  width: double.infinity,
                                                  child: snapshot
                                                          .data![i]
                                                          .thumbnailPath!
                                                          .isEmpty
                                                      ? Image.asset(
                                                          "assets/png/no_image.png",
                                                          fit: BoxFit.cover,
                                                        )
                                                      : CachedNetworkImage(
                                                          progressIndicatorBuilder:
                                                              (context, url,
                                                                      downloadProgress) =>
                                                                  Center(
                                                                    child:
                                                                        CupertinoActivityIndicator(
                                                                      radius:
                                                                          1.4.h,
                                                                    ),
                                                                  ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Icon(
                                                                  Icons.error),
                                                          imageUrl:
                                                              "https://adyahwholesale.com${snapshot.data![i].thumbnailPath!}",
                                                          fit: BoxFit.fill),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              text(
                                                DateFormat('MMMM dd, yyyy')
                                                    .format(snapshot.data![i]
                                                        .publishedDate!.date!),
                                                fontSize: 7.sp,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  snapshot.data![i].title!,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "OpenSans",
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container()
                        ],
                      );
                    } else {
                      blogBloc.blogBlocc(pl,
                          "https://api.bigcommerce.com/stores/${SpUtil.getString(SpConstUtil.storeHashValue)}/v2/blog/posts?is_published=true");
                      return const Center(child: BlogShrimmerListview());
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
