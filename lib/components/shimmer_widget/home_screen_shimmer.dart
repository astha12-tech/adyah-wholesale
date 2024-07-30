// ignore_for_file: use_key_in_widget_constructors

import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/shimmer_widget/skeleton_ui.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:shimmer/shimmer.dart';

class SliderViewShimmer extends StatefulWidget {
  const SliderViewShimmer({super.key});

  @override
  State<SliderViewShimmer> createState() => _SliderViewShimmerState();
}

class _SliderViewShimmerState extends State<SliderViewShimmer> {
  List<Color> colorss = [];

  void getRandomColors() {
    var options = Options(
      format: Format.hex,
      count: 7,
      colorType: ColorType.random,
      luminosity: Luminosity.light,
    );
    List<dynamic> colorHexes = RandomColor.getColor(options);
    colorss = colorHexes
        .map((hex) => Color(int.parse(hex.replaceFirst('#', '0xff'))))
        .toList();
  }

  @override
  void initState() {
    getRandomColors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: colorss.isNotEmpty
            ? colorss[0].withOpacity(0.5)
            : colors.greyColor.withOpacity(0.5),
        highlightColor: SpUtil.getBool(SpConstUtil.appTheme)!
            ? colors.whitecolor.withOpacity(0.8)
            : colors.greyColor.withOpacity(0.1),
        child: SkeletonUi(
          height: MediaQuery.of(context).size.height / 4,
          width: double.infinity,
          radius: 10,
        ));
  }
}

class CategoryShimmer extends StatefulWidget {
  const CategoryShimmer({super.key});

  @override
  State<CategoryShimmer> createState() => _CategoryShimmerState();
}

class _CategoryShimmerState extends State<CategoryShimmer> {
  List<Color> colorss = [];

  void getRandomColors() {
    var options = Options(
      format: Format.hex,
      count: 15,
      colorType: ColorType.random,
      luminosity: Luminosity.light,
    );
    List<dynamic> colorHexes = RandomColor.getColor(options);
    colorss = colorHexes
        .map((hex) => Color(int.parse(hex.replaceFirst('#', '0xff'))))
        .toList();
  }

  @override
  void initState() {
    getRandomColors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            for (int index = 0; index < 15; index++)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Shimmer.fromColors(
                  baseColor: colorss.isNotEmpty
                      ? colorss[index].withOpacity(0.5)
                      : colors.greyColor.withOpacity(0.5),
                  highlightColor: SpUtil.getBool(SpConstUtil.appTheme)!
                      ? colors.whitecolor.withOpacity(0.8)
                      : colors.greyColor.withOpacity(0.1),
                  child: SkeletonUi(
                    height: MediaQuery.of(context).size.height / 15,
                    width: MediaQuery.of(context).size.height / 15,
                    radius: 100,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class BlogShimmer extends StatefulWidget {
  const BlogShimmer({super.key});

  @override
  State<BlogShimmer> createState() => _BlogShimmerState();
}

class _BlogShimmerState extends State<BlogShimmer> {
  List<Color> colorss = [];

  void getRandomColors() {
    var options = Options(
      format: Format.hex,
      count: 7,
      colorType: ColorType.random,
      luminosity: Luminosity.light,
    );
    List<dynamic> colorHexes = RandomColor.getColor(options);
    colorss = colorHexes
        .map((hex) => Color(int.parse(hex.replaceFirst('#', '0xff'))))
        .toList();
  }

  @override
  void initState() {
    getRandomColors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 1000;
    return SafeArea(
      child: ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          offset += 5;
          time = 800 + offset;

          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Shimmer.fromColors(
                highlightColor: SpUtil.getBool(SpConstUtil.appTheme)!
                    ? colors.whitecolor.withOpacity(0.8)
                    : Colors.white,
                baseColor: colorss.isNotEmpty
                    ? colorss[index].withOpacity(0.5)
                    : colors.greyColor.withOpacity(0.5),
                period: Duration(milliseconds: time),
                child: ShimmerLayout(),
              ));
        },
      ),
    );
  }
}

class ShimmerLayout extends StatefulWidget {
  @override
  State<ShimmerLayout> createState() => _ShimmerLayoutState();
}

class _ShimmerLayoutState extends State<ShimmerLayout> {
  List<Color> colorss = [];

  void getRandomColors() {
    var options = Options(
      format: Format.hex,
      count: 7,
      colorType: ColorType.random,
      luminosity: Luminosity.light,
    );
    List<dynamic> colorHexes = RandomColor.getColor(options);
    colorss = colorHexes
        .map((hex) => Color(int.parse(hex.replaceFirst('#', '0xff'))))
        .toList();
  }

  @override
  void initState() {
    getRandomColors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width / 2;
    double containerHeight = 25;

    return Column(
      children: [
        for (int i = 0; i < 3; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 7.5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 8,
                    width: MediaQuery.of(context).size.height / 8,
                    color: colorss.isNotEmpty
                        ? colorss[i].withOpacity(0.3)
                        : colors.greyColor.withOpacity(0.3),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: containerHeight,
                        width: containerWidth,
                        color: colorss.isNotEmpty
                            ? colorss[i].withOpacity(0.3)
                            : colors.greyColor.withOpacity(0.3),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: containerHeight,
                        width: containerWidth,
                        color: colorss.isNotEmpty
                            ? colorss[i].withOpacity(0.3)
                            : colors.greyColor.withOpacity(0.3),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: containerHeight,
                        width: containerWidth * 0.75,
                        color: colorss.isNotEmpty
                            ? colorss[i].withOpacity(0.3)
                            : colors.greyColor.withOpacity(0.3),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class FeaturedProductsShimmer extends StatefulWidget {
  const FeaturedProductsShimmer({super.key});

  @override
  State<FeaturedProductsShimmer> createState() =>
      _FeaturedProductsShimmerState();
}

class _FeaturedProductsShimmerState extends State<FeaturedProductsShimmer> {
  List<Color> colorss = [];

  void getRandomColors() {
    var options = Options(
      format: Format.hex,
      count: 12,
      colorType: ColorType.random,
      luminosity: Luminosity.light,
    );
    List<dynamic> colorHexes = RandomColor.getColor(options);
    colorss = colorHexes
        .map((hex) => Color(int.parse(hex.replaceFirst('#', '0xff'))))
        .toList();
  }

  @override
  void initState() {
    getRandomColors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = MediaQuery.of(context).size.width ~/ 180;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Shimmer.fromColors(
            baseColor: colors.greyColor.withOpacity(0.5),
            highlightColor: SpUtil.getBool(SpConstUtil.appTheme)!
                ? colors.whitecolor.withOpacity(0.8)
                : colors.greyColor.withOpacity(0.1),
            child: SkeletonUi(
              height: 3,
              width: double.infinity,
              radius: 10,
            ),
          ),
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount, childAspectRatio: 0.8),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Shimmer.fromColors(
                baseColor: colorss.isNotEmpty
                    ? colorss[index % colorss.length].withOpacity(0.5)
                    : colors.greyColor.withOpacity(0.5),
                highlightColor: SpUtil.getBool(SpConstUtil.appTheme)!
                    ? colors.whitecolor.withOpacity(0.8)
                    : colors.greyColor.withOpacity(0.1),
                child: SkeletonUi(
                  height: 280,
                  width: double.infinity,
                  radius: 10,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class LatestProductsShimmer extends StatefulWidget {
  const LatestProductsShimmer({super.key});

  @override
  State<LatestProductsShimmer> createState() => _LatestProductsShimmerState();
}

class _LatestProductsShimmerState extends State<LatestProductsShimmer> {
  List<Color> colorss = [];

  void getRandomColors() {
    var options = Options(
      format: Format.hex,
      count: 15,
      colorType: ColorType.random,
      luminosity: Luminosity.light,
    );
    List<dynamic> colorHexes = RandomColor.getColor(options);
    colorss = colorHexes
        .map((hex) => Color(int.parse(hex.replaceFirst('#', '0xff'))))
        .toList();
  }

  @override
  void initState() {
    getRandomColors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            for (int index = 0; index < 15; index++)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Shimmer.fromColors(
                  baseColor: colorss.isNotEmpty
                      ? colorss[index].withOpacity(0.5)
                      : colors.greyColor.withOpacity(0.5),
                  highlightColor: SpUtil.getBool(SpConstUtil.appTheme)!
                      ? colors.whitecolor.withOpacity(0.8)
                      : colors.greyColor.withOpacity(0.1),
                  child: SkeletonUi(
                    height: MediaQuery.of(context).size.height / 4,
                    width: 180,
                    radius: 10,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class DrawerShimmer extends StatefulWidget {
  const DrawerShimmer({super.key});

  @override
  State<DrawerShimmer> createState() => _DrawerShimmerState();
}

class _DrawerShimmerState extends State<DrawerShimmer> {
  List<Color> colorss = [];

  void getRandomColors() {
    var options = Options(
      format: Format.hex,
      count: 7,
      colorType: ColorType.random,
      luminosity: Luminosity.light,
    );
    List<dynamic> colorHexes = RandomColor.getColor(options);
    colorss = colorHexes
        .map((hex) => Color(int.parse(hex.replaceFirst('#', '0xff'))))
        .toList();
  }

  @override
  void initState() {
    getRandomColors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int index = 0; index < 7; index++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Shimmer.fromColors(
              baseColor: colorss.isNotEmpty
                  ? colorss[index].withOpacity(0.5)
                  : colors.greyColor.withOpacity(0.5),
              highlightColor: SpUtil.getBool(SpConstUtil.appTheme)!
                  ? colors.whitecolor.withOpacity(0.8)
                  : colors.greyColor.withOpacity(0.1),
              child: SkeletonUi(
                height: 50,
                width: double.infinity,
                radius: 10,
              ),
            ),
          ),
      ],
    );
  }
}

class BlogShrimmerListview extends StatefulWidget {
  const BlogShrimmerListview({super.key});

  @override
  State<BlogShrimmerListview> createState() => _BlogShrimmerListviewState();
}

class _BlogShrimmerListviewState extends State<BlogShrimmerListview> {
  List<Color> colorss = [];

  void getRandomColors() {
    var options = Options(
      format: Format.hex,
      count: 7,
      colorType: ColorType.random,
      luminosity: Luminosity.light,
    );
    List<dynamic> colorHexes = RandomColor.getColor(options);
    colorss = colorHexes
        .map((hex) => Color(int.parse(hex.replaceFirst('#', '0xff'))))
        .toList();
  }

  @override
  void initState() {
    getRandomColors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (int index = 0; index < 7; index++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Shimmer.fromColors(
                baseColor: colorss.isNotEmpty
                    ? colorss[index].withOpacity(0.5)
                    : colors.greyColor.withOpacity(0.5),
                highlightColor: SpUtil.getBool(SpConstUtil.appTheme)!
                    ? colors.whitecolor.withOpacity(0.8)
                    : colors.greyColor.withOpacity(0.1),
                child: SkeletonUi(
                  height: MediaQuery.of(context).size.height / 5,
                  width: double.infinity,
                  radius: 10,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
