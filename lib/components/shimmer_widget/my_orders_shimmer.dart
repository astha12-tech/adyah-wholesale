import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/shimmer_widget/skeleton_ui.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class MyOrdersShimmer extends StatefulWidget {
  const MyOrdersShimmer({super.key});

  @override
  State<MyOrdersShimmer> createState() => _MyOrdersShimmerState();
}

class _MyOrdersShimmerState extends State<MyOrdersShimmer> {
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Shimmer.fromColors(
                baseColor: colorss.isNotEmpty
                    ? colorss[index].withOpacity(0.5)
                    : colors.greyColor.withOpacity(0.5),
                highlightColor: SpUtil.getBool(SpConstUtil.appTheme)!
                    ? colors.whitecolor.withOpacity(0.8)
                    : colors.greyColor.withOpacity(0.1),
                child: SkeletonUi(
                  height: MediaQuery.of(context).size.height / 3,
                  width: double.infinity,
                  radius: 10,
                ),
              ),
            ),
        ],
        // );
        // },
      ),
    );
  }
}

class OrderDetailShimmer extends StatefulWidget {
  const OrderDetailShimmer({super.key});

  @override
  State<OrderDetailShimmer> createState() => _OrderDetailShimmerState();
}

class _OrderDetailShimmerState extends State<OrderDetailShimmer> {
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Shimmer.fromColors(
              baseColor:
                  // colorss.isNotEmpty
                  //     ? colorss[index].withOpacity(0.5)
                  colors.greyColor.withOpacity(0.5),
              highlightColor: SpUtil.getBool(SpConstUtil.appTheme)!
                  ? colors.whitecolor.withOpacity(0.8)
                  : colors.greyColor.withOpacity(0.1),
              child: SkeletonUi(
                height: 50,
                width: 120,
                radius: 20.h,
              ),
            ),
          ),
          for (int index = 0; index < 7; index++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Shimmer.fromColors(
                baseColor: colorss.isNotEmpty
                    ? colorss[index].withOpacity(0.5)
                    : colors.greyColor.withOpacity(0.5),
                highlightColor: SpUtil.getBool(SpConstUtil.appTheme)!
                    ? colors.whitecolor.withOpacity(0.8)
                    : colors.greyColor.withOpacity(0.1),
                child: SkeletonUi(
                  height: MediaQuery.of(context).size.height / 3,
                  width: double.infinity,
                  radius: 10,
                ),
              ),
            ),
        ],
        // );
        // },
      ),
    );
  }
}
