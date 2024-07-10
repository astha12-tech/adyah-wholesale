// ignore_for_file: must_be_immutable, avoid_print

import 'package:adyah_wholesale/bloc/get_blog_bloc.dart';
import 'package:adyah_wholesale/components/html/index.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/model/get_blog_model.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FlutterBlogDetailScreen extends StatefulWidget {
  GetBlogModel blogList;
  FlutterBlogDetailScreen({super.key, required this.blogList});

  @override
  State<FlutterBlogDetailScreen> createState() =>
      _FlutterBlogDetailScreenState();
}

class _FlutterBlogDetailScreenState extends State<FlutterBlogDetailScreen> {
  double textSize = 15.0;
  @override
  Widget build(BuildContext context) {
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverAppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.whitecolor.withOpacity(0.7)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset("assets/png/left.png"),
                  )),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (context, StateSetter setStates) {
                          return SizedBox(
                            height:
                                MediaQuery.of(context).copyWith().size.height *
                                    (1 / 4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        CupertinoIcons.textformat,
                                        size: 20,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                                      Icon(
                                        CupertinoIcons.textformat,
                                        size: 30,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                                      Icon(
                                        CupertinoIcons.textformat,
                                        size: 40,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                                    ],
                                  ),
                                ),
                                Slider(
                                  onChanged: (double value) {
                                    setStates(() {
                                      textSize = value;
                                      debugPrint("=== textSize ===>$textSize");
                                    });
                                  },
                                  onChangeEnd: (double value) {
                                    setState(() {
                                      textSize = value;
                                      debugPrint("=== textSize ===>$textSize");
                                    });
                                  },
                                  value: textSize,
                                  min: 15.0,
                                  max: 30.0,
                                  divisions: 4,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    });
              },
              child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.whitecolor.withOpacity(0.7)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset("assets/png/decrease-font-size.png"),
                  )),
            ),
          ],
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: SpUtil.getBool(SpConstUtil.appTheme)!
                      ? ThemeData.dark().scaffoldBackgroundColor
                      : colors.whitecolor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
                  child: Text(
                    widget.blogList.title!,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "OpenSans"),
                    textAlign: TextAlign.center,
                  )),
            )),
        pinned: true,
        backgroundColor: colors.themebluecolor,
        automaticallyImplyLeading: false,
        expandedHeight: 300,
        flexibleSpace: FlexibleSpaceBar(
            background: CachedNetworkImage(
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CupertinoActivityIndicator(
              radius: 1.4.h,
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          imageUrl:
              "https://adyahwholesale.com${widget.blogList.thumbnailPath!}",
          width: double.maxFinite,
          fit: BoxFit.cover,
        )),
      ),
      SliverToBoxAdapter(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: SpUtil.getBool(SpConstUtil.appTheme)!
              ? ThemeData.dark().scaffoldBackgroundColor
              : colors.whitecolor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 15,
              ),
              HtmlWidget(
                widget.blogList.body!,
                textStyle: TextStyle(fontSize: textSize),
              ),
              const SizedBox(
                height: 25,
              ),
              text("Related blogs",
                  fontSize: 17,
                  // color: colors.blackcolor,
                  fontWeight: FontWeight.bold),
              StreamBuilder<List<GetBlogModel>>(
                  stream: blogBloc.blogStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return text(snapshot.error.toString());
                    } else if (snapshot.hasData) {
                      return SingleChildScrollView(
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            for (int i = 0; i < snapshot.data!.length; i++)
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FlutterBlogDetailScreen(
                                        blogList: snapshot.data![i],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        snapshot.data![i].thumbnailPath!.isEmpty
                                            ? Image.asset(
                                                "assets/png/no_image.png",
                                                height: 100,
                                                width: 100,
                                              )
                                            : Image.network(
                                                "https://adyahwholesale.com${snapshot.data![i].thumbnailPath!}",
                                                height: 100,
                                                width: 100,
                                              ),
                                        const SizedBox(
                                            height:
                                                4), // Adjust spacing between image and text
                                        SizedBox(
                                          width: 100, // Limiting width for text
                                          child: Text(
                                            snapshot.data![i].title!,
                                            style:
                                                const TextStyle(fontSize: 12),
                                            maxLines: 2,
                                            overflow: TextOverflow
                                                .ellipsis, // Ellipsis when text overflows
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      );
                    } else {
                      blogBloc.blogBlocc(pl,
                          "https://api.bigcommerce.com/stores/${SpUtil.getString(SpConstUtil.storeHashValue)}/v2/blog/posts?is_published=true");
                      return Center(
                        child: CupertinoActivityIndicator(
                          radius: 1.4.h,
                        ),
                      );
                    }
                  }),
              const SizedBox(
                height: 15,
              ),
              text("Comment", fontSize: 17, fontWeight: FontWeight.bold),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Write your comment",
                      ),
                    ),
                  ),
                  const Icon(Icons.send)
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ))
    ]));
  }
}
