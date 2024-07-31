import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/shimmer_widget/skeleton_ui.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:shimmer/shimmer.dart';

class ProductsShimmer extends StatefulWidget {
  const ProductsShimmer({super.key});

  @override
  State<ProductsShimmer> createState() => _ProductsShimmerState();
}

class _ProductsShimmerState extends State<ProductsShimmer> {
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
    super.initState();
    getRandomColors();
  }

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = MediaQuery.of(context).size.width ~/ 180;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
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
              height: 300,
              width: double.infinity,
              radius: 10,
            ),
          ),
        );
      },
    );
  }
}
