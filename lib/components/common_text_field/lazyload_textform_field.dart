// // ignore_for_file: prefer_typing_uninitialized_variables

// import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
// import 'package:adyah_wholesale/utils/colors.dart';
// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class LazyLoadTextFormField extends StatefulWidget {
//   final String sizeLabel;
//   final String colorLabel;
//   var data;
//   final int productId;
//   final Function(int variantId, int productId, int quantity) onVariantSelected;

//   LazyLoadTextFormField({
//     super.key,
//     required this.sizeLabel,
//     required this.colorLabel,
//     required this.data,
//     required this.productId,
//     required this.onVariantSelected,
//   });

//   @override
//   State<LazyLoadTextFormField> createState() => _LazyLoadTextFormFieldState();
// }

// class _LazyLoadTextFormFieldState extends State<LazyLoadTextFormField> {
//   TextEditingController controller = TextEditingController();
//   int quantity = 0;
//   int variantId = 0;
//   @override
//   Widget build(BuildContext context) {
//     return widget.data.variants!.any((variant) =>
//             variant.optionValues![0].label == widget.sizeLabel &&
//             variant.optionValues![1].label == widget.colorLabel)
//         ? TextFormField(
//             textAlign: TextAlign.center,
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return null;
//               }
//               int qty = int.tryParse(value) ?? 0;

//               int inventoryLevel = widget.data.variants!
//                       .firstWhere((variant) =>
//                           variant.optionValues![0].label == widget.sizeLabel &&
//                           variant.optionValues![1].label == widget.colorLabel)
//                       .inventoryLevel ??
//                   0;
//               if (qty > inventoryLevel) {
//                 return 'Entered quantity exceeds available inventory';
//               } else if (value.isNotEmpty) {
//                 if (inventoryLevel == 0) {
//                   return "no stock";
//                 }
//               }
//               return null;
//             },
//             keyboardType: TextInputType.number,
//             controller: controller,
//             onChanged: (value) {
//               int qty = int.tryParse(value) ?? 0;
//               setState(() {
//                 quantity = qty;
//               });
//               variantId = widget.data.variants!
//                   .firstWhere((variant) =>
//                       variant.optionValues![0].label == widget.sizeLabel &&
//                       variant.optionValues![1].label == widget.colorLabel)
//                   .id!;

//               widget.onVariantSelected(variantId, widget.productId, qty);
//             },
//             cursorColor: SpUtil.getBool(SpConstUtil.appTheme)!
//                 ? colors.whitecolor
//                 : colors.blackcolor,
//             decoration: InputDecoration(
//                 contentPadding: EdgeInsets.zero,
//                 focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(5),
//                     borderSide: BorderSide(
//                         color: SpUtil.getBool(SpConstUtil.appTheme)!
//                             ? colors.whitecolor
//                             : colors.blackcolor)),
//                 enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(5),
//                     borderSide:
//                         BorderSide(color: colors.greyColor.withOpacity(0.3))),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                 )),
//           )
//         : const Center(
//             child: Text(
//               'Not Found',
//               textAlign: TextAlign.center,
//             ),
//           );
//   }
// }
import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LazyLoadTextFormField extends StatefulWidget {
  final String sizeLabel;
  final String colorLabel;
  var data;
  final int productId;
  final Function(int variantId, int productId, int quantity) onVariantSelected;

  LazyLoadTextFormField({
    super.key,
    required this.sizeLabel,
    required this.colorLabel,
    required this.data,
    required this.productId,
    required this.onVariantSelected,
  });

  @override
  State<LazyLoadTextFormField> createState() => _LazyLoadTextFormFieldState();
}

class _LazyLoadTextFormFieldState extends State<LazyLoadTextFormField> {
  TextEditingController controller = TextEditingController();
  int quantity = 0;
  int variantId = 0;

  @override
  Widget build(BuildContext context) {
    return widget.data.variants!.any((variant) =>
            variant.optionValues!.length > 1 &&
            variant.optionValues![0].label == widget.sizeLabel &&
            variant.optionValues![1].label == widget.colorLabel)
        ? TextFormField(
            textAlign: TextAlign.center,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) {
                return null;
              }
              int qty = int.tryParse(value) ?? 0;

              int inventoryLevel = widget.data.variants!
                      .firstWhere((variant) =>
                          variant.optionValues!.length > 1 &&
                          variant.optionValues![0].label == widget.sizeLabel &&
                          variant.optionValues![1].label == widget.colorLabel)
                      .inventoryLevel ??
                  0;
              if (qty > inventoryLevel) {
                return 'Entered quantity exceeds available inventory';
              } else if (value.isNotEmpty) {
                if (inventoryLevel == 0) {
                  return "no stock";
                }
              }
              return null;
            },
            keyboardType: TextInputType.number,
            controller: controller,
            onChanged: (value) {
              int qty = int.tryParse(value) ?? 0;
              setState(() {
                quantity = qty;
              });
              variantId = widget.data.variants!
                  .firstWhere((variant) =>
                      variant.optionValues!.length > 1 &&
                      variant.optionValues![0].label == widget.sizeLabel &&
                      variant.optionValues![1].label == widget.colorLabel)
                  .id!;

              widget.onVariantSelected(variantId, widget.productId, qty);
            },
            cursorColor: SpUtil.getBool(SpConstUtil.appTheme)!
                ? colors.whitecolor
                : colors.blackcolor,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                        color: SpUtil.getBool(SpConstUtil.appTheme)!
                            ? colors.whitecolor
                            : colors.blackcolor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:
                        BorderSide(color: colors.greyColor.withOpacity(0.3))),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                )),
          )
        : const Center(
            child: Text(
              'Not Found',
              textAlign: TextAlign.center,
            ),
          );
  }
}
