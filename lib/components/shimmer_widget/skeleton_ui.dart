// ignore_for_file: must_be_immutable

import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';

class SkeletonUi extends StatelessWidget {
  double? height;
  double? width;
  double? radius;
  SkeletonUi({super.key, this.height, this.width, this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: colors.greyColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(radius!)),
    );
  }
}
