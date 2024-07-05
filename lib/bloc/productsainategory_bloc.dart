// ignore_for_file: avoid_print

import 'dart:async';

import 'package:adyah_wholesale/api/api.dart';
import 'package:adyah_wholesale/components/check_internet/check_internet.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/global/global.dart';
import 'package:adyah_wholesale/model/products_category_model.dart';
import 'package:flutter/cupertino.dart';

class ProductsMainCategoryBloc {
  StreamController<ProductsMainCategoryModel>
      productsMainCategorystreamController = StreamController.broadcast();
  Stream<ProductsMainCategoryModel> get productsMainCategorystream =>
      productsMainCategorystreamController.stream;
  ProductsMainCategoryModel? productsMainCategoryModel;
  productsMaincategoryBloc(
      categoryID, String isfeatured, ProgressLoader pl,String url) async {
    productsMainCategoryModel =
        await apis.productsMainCategoryApi(categoryID, isfeatured, pl, 1,url);
    productsMainCategorystreamController.sink.add(productsMainCategoryModel!);
  }

  Future<void> paginatedData(
    categoryID,
    ProgressLoader pl,
    int nextPage,
    String isfeatured,String url
  ) async {
    debugPrint("==== paginatedData ===>");
    bool internet = await checkInternet();
    if (internet) {
      ProductsMainCategoryModel? temp = await apis.productsMainCategoryApi(
        
          categoryID, isfeatured, pl, nextPage,url);
      if (temp != null) {
        debugPrint("---------->temp != null responseCode is 200------>");
        productsMainCategoryModel!.data!.addAll(temp.data!);
        productsMainCategorystreamController.sink
            .add(productsMainCategoryModel!);
        commonData.isShow = false;
      } else {
        debugPrint("---------->temppp.responseCode = not 200------>");

        commonData.isShow = false;
      }
    } else {
      commonData.isShow = false;

      debugPrint("Errorssss");
      productsMainCategorystreamController.sink.addError(commonData.noInternet);
    }
  }
}

ProductsMainCategoryBloc productsMainCategoryBloc = ProductsMainCategoryBloc();
