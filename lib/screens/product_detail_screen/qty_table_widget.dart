// ignore_for_file: avoid_print

import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/sizebox/sizebox.dart';
import 'package:adyah_wholesale/screens/product_detail_screen/add_cart_button_widget.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:adyah_wholesale/screens/product_detail_screen/variant_data.dart';
import 'package:adyah_wholesale/components/common_text_field/lazyload_textform_field.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:sizer/sizer.dart';

// Widget quantityTableWidget(
//     List<String> colorLabels,
//     List<String> sizeLabels,
//     var data,
//     StateSetter setState,
//     List<VariantData> variantDataList,
//     GlobalKey<FormState> formKey,
//     ProgressLoader pl,
//     int qty,
//     TextEditingController controller,
//     {required BuildContext context}) {
//   return sizeLabels.isEmpty
//       ? data.variants[0].inventoryLevel != 0
//           ? Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   text("${data.variants[0].inventoryLevel.toString()} Left",
//                       fontSize: 7.sp),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   TextFormField(
//                     onChanged: (value) {
//                       setState(() {
//                         controller.text = value;
//                       });
//                     },
//                     controller: controller,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter quantity';
//                       }
//                       // Additional validation logic if needed
//                       return null;
//                     },
//                     autovalidateMode: AutovalidateMode.onUserInteraction,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                         hintText: "Add Qty...",
//                         hintStyle: TextStyle(fontSize: 7.sp),
//                         contentPadding: const EdgeInsets.only(left: 15),
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: colors.blackcolor)),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(
//                                 color: colors.greyColor.withOpacity(0.3))),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         )),
//                   ),
//                   sizedboxWidget(),
//                   addToCartButtonWidgetNew(
//                       data.variants[0].productId,
//                       controller.text.isEmpty ? 0 : int.parse(controller.text),
//                       data.variants[0].id,
//                       pl,
//                       formKey,
//                       setState)
//                 ],
//               ),
//             )
//           : Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(2),
//                       color: Colors.red.withOpacity(0.1)),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         Image.asset(
//                           "assets/png/out-of-stock.png",
//                           height: 20,
//                           width: 20,
//                         ),
//                         // Image.asset(
//                         //   "assets/png/info.png",
//                         //   height: 15,
//                         //   width: 15,
//                         //   color: Colors.red,
//                         // ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         text("Out of stock", color: Colors.red),
//                       ],
//                     ),
//                   )),
//             )
//       : Form(
//           key: formKey,
//           child: FittedBox(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 8, right: 8),
//               child: DataTable(
//                 dataRowMaxHeight: double.infinity,
//                 headingRowColor:
//                     const WidgetStatePropertyAll(Colors.transparent),
//                 dataRowColor: const WidgetStatePropertyAll(Colors.transparent),
//                 columns: [
//                   DataColumn(
//                       label: SizedBox(
//                           width: 100,
//                           child: text('Size',

//                               // fontFamily: "OpenSans",
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15))),
//                   for (var colorLabel in colorLabels)
//                     DataColumn(
//                       label: SizedBox(
//                           width: 100,
//                           child: Text(
//                             colorLabel,
//                             style: const TextStyle(
//                                 fontFamily: "OpenSans",
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 15),
//                             textAlign: TextAlign.center,
//                           )),
//                     )
//                 ],
//                 rows: [
//                   for (var sizeLabel in sizeLabels)
//                     DataRow(cells: [
//                       DataCell(text(sizeLabel)),
//                       for (var colorLabel in colorLabels)
//                         DataCell(
//                           Column(
//                             children: [
//                               if (data.variants != null &&
//                                   data.variants!.isNotEmpty)
//                                 for (var variant
//                                     in data.variants!) // Iterate over variants
//                                   if (variant.optionValues != null &&
//                                       variant.optionValues!.isNotEmpty &&
//                                       variant.optionValues![0].label ==
//                                           sizeLabel &&
//                                       variant.optionValues![1].label ==
//                                           colorLabel)
//                                     text(
//                                         "${variant.inventoryLevel.toString()} Left"),
//                               if (data.variants == null ||
//                                   data.variants!.isEmpty ||
//                                   data.variants!.every((variant) =>
//                                       variant.optionValues == null ||
//                                       variant.optionValues!.isEmpty))
//                                 text("No options founds"),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               LazyLoadTextFormField(
//                                 sizeLabel: sizeLabel,
//                                 colorLabel: colorLabel,
//                                 data: data,
//                                 productId: data.id!,
//                                 onVariantSelected:
//                                     (variantId, productId, quantity) {
//                                   setState(() {
//                                     if (quantity == 0) {
//                                       variantDataList.clear();
//                                     } else {
//                                       var existingIndex =
//                                           variantDataList.indexWhere((data) =>
//                                               data.productId == productId &&
//                                               data.variantId == variantId);

//                                       if (existingIndex != -1) {
//                                         variantDataList[existingIndex]
//                                             .quantity = quantity;
//                                       } else {
//                                         variantDataList.add(VariantData(
//                                           productId: productId,
//                                           variantId: variantId,
//                                           quantity: quantity,
//                                         ));
//                                       }
//                                     }
//                                   });
//                                 },
//                               ),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                             ],
//                           ),
//                         ),
//                     ]),
//                 ],
//               ),
//             ),
//           ),
//         );
// }


Widget quantityTableWidget(
    List<String> colorLabels,
    List<String> sizeLabels,
    var data,
    StateSetter setState,
    List<VariantData> variantDataList,
    GlobalKey<FormState> formKey,
    ProgressLoader pl,
    int qty,
    TextEditingController controller,
    {required BuildContext context}) {
  return sizeLabels.isEmpty
      ? data.variants[0].inventoryLevel != 0
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text("${data.variants[0].inventoryLevel.toString()} Left",
                      fontSize: 7.sp),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        controller.text = value;
                      });
                    },
                    controller: controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter quantity';
                      }
                      // Additional validation logic if needed
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Add Qty...",
                        hintStyle: TextStyle(fontSize: 7.sp),
                        contentPadding: const EdgeInsets.only(left: 15),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: colors.blackcolor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                color: colors.greyColor.withOpacity(0.3))),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                  ),
                  sizedboxWidget(),
                  addToCartButtonWidgetNew(
                      data.variants[0].productId,
                      controller.text.isEmpty ? 0 : int.parse(controller.text),
                      data.variants[0].id,
                      pl,
                      formKey,
                      setState)
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.red.withOpacity(0.1)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/png/out-of-stock.png",
                          height: 20,
                          width: 20,
                        ),
                        // Image.asset(
                        //   "assets/png/info.png",
                        //   height: 15,
                        //   width: 15,
                        //   color: Colors.red,
                        // ),
                        const SizedBox(
                          width: 10,
                        ),
                        text("Out of stock", color: Colors.red),
                      ],
                    ),
                  )),
            )
      : Form(
          key: formKey,
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: DataTable(
                dataRowMaxHeight: double.infinity,
                headingRowColor:
                    const WidgetStatePropertyAll(Colors.transparent),
                dataRowColor: const WidgetStatePropertyAll(Colors.transparent),
                columns: [
                  DataColumn(
                      label: SizedBox(
                          width: 100,
                          child: text('Size',

                              // fontFamily: "OpenSans",
                              fontWeight: FontWeight.bold,
                              fontSize: 15))),
                  for (var colorLabel in colorLabels)
                    DataColumn(
                      label: SizedBox(
                          width: 100,
                          child: Text(
                            colorLabel,
                            style: const TextStyle(
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                            textAlign: TextAlign.center,
                          )),
                    )
                ],
                rows: [
                  for (var sizeLabel in sizeLabels)
                    DataRow(cells: [
                      DataCell(text(sizeLabel)),
                      for (var colorLabel in colorLabels)
                        DataCell(
                          Column(
                            children: [
                              if (data.variants != null &&
                                  data.variants!.isNotEmpty)
                                for (var variant
                                    in data.variants!) // Iterate over variants
                                  if (variant.optionValues != null &&
                                      variant.optionValues!.isNotEmpty &&
                                      variant.optionValues![0].label ==
                                          sizeLabel &&
                                      variant.optionValues!.length > 1 &&
                                      variant.optionValues![1].label ==
                                          colorLabel)
                                    text(
                                        "${variant.inventoryLevel.toString()} Left"),
                              if (data.variants == null ||
                                  data.variants!.isEmpty ||
                                  data.variants!.every((variant) =>
                                      variant.optionValues == null ||
                                      variant.optionValues!.isEmpty))
                                text("No options founds"),
                              const SizedBox(
                                height: 5,
                              ),
                              LazyLoadTextFormField(
                                sizeLabel: sizeLabel,
                                colorLabel: colorLabel,
                                data: data,
                                productId: data.id!,
                                onVariantSelected:
                                    (variantId, productId, quantity) {
                                  setState(() {
                                    if (quantity == 0) {
                                      variantDataList.clear();
                                    } else {
                                      var existingIndex =
                                          variantDataList.indexWhere((data) =>
                                              data.productId == productId &&
                                              data.variantId == variantId);

                                      if (existingIndex != -1) {
                                        variantDataList[existingIndex]
                                            .quantity = quantity;
                                      } else {
                                        variantDataList.add(VariantData(
                                          productId: productId,
                                          variantId: variantId,
                                          quantity: quantity,
                                        ));
                                      }
                                    }
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                    ]),
                ],
              ),
            ),
          ),
        );
}
