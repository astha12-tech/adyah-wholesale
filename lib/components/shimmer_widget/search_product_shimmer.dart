import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/shimmer_widget/skeleton_ui.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:shimmer/shimmer.dart';

class SearchShimmer extends StatefulWidget {
  const SearchShimmer({super.key});

  @override
  State<SearchShimmer> createState() => _DrawerShimmerState();
}

class _DrawerShimmerState extends State<SearchShimmer> {
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
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
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
                    height: 100,
                    width: double.infinity,
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
