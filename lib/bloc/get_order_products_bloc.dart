// // ignore_for_file: avoid_print

// import 'dart:async';

// import 'package:adyah_wholesale/api/api.dart';
// import 'package:adyah_wholesale/components/check_internet/check_internet.dart';
// import 'package:adyah_wholesale/components/indicator/indicator.dart';
// import 'package:adyah_wholesale/global/global.dart';
// import 'package:adyah_wholesale/model/get_my_orders_model.dart';
// import 'package:flutter/material.dart';

// class GetOrdersProductsBloc {
//   StreamController<GetMyOrdersModel> getOrdersProductstreamController =
//       StreamController.broadcast();
//   Stream<GetMyOrdersModel> get getAllordercategoryStream =>
//       getOrdersProductstreamController.stream;
//   GetMyOrdersModel? getMyOrdersModel;
//   getAllrderssBloc(ProgressLoader pl) async {
//     getMyOrdersModel = await apis.getMyOrdersApi(pl, 10);
//     getOrdersProductstreamController.sink.add(getMyOrdersModel!);
//   }

//   int _currentPage = 1; // Initialize current page number
//   static const int pageSize = 10;
//   Future<void> paginatedData(ProgressLoader pl) async {
//     debugPrint("==== paginatedData ===>");

//     bool internet = await checkInternet();
//     if (internet) {
//       GetMyOrdersModel? temp =
//           await apis.getMyOrdersApi(pl, pageSize * _currentPage);

//       if (temp != null && temp.data != null && temp.data!.list != null) {
//         getMyOrdersModel!.data!.list!.addAll(temp.data!.list!);
//         getOrdersProductstreamController.sink.add(getMyOrdersModel!);
//         commonData.isShow = false;
//         _currentPage++;
//       } else {
//         debugPrint("---------->temp.responseCode = not 200------>");

//         commonData.isShow = false;
//       }
//     } else {
//       commonData.isShow = false;

//       debugPrint("Errorssss");
//       getOrdersProductstreamController.sink.addError(commonData.noInternet);
//     }
//   }
// }

// GetOrdersProductsBloc getAllOrdersBloc = GetOrdersProductsBloc();
// ignore_for_file: avoid_print

import 'dart:async';

import 'package:adyah_wholesale/api/api.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/model/get_order_product_model.dart';

class GetOrdersProductsBloc {
  StreamController<GeOrderProductsModel> getOrdersProductstreamController =
      StreamController.broadcast();
  Stream<GeOrderProductsModel> get getorderProductsStream =>
      getOrdersProductstreamController.stream;
  GeOrderProductsModel? geOrderProductsModel;
  getordersProductsBloc(ProgressLoader pl, orderid) async {
    geOrderProductsModel = await apis.getOrderProductApi(pl, orderid);
    getOrdersProductstreamController.sink.add(geOrderProductsModel!);
  }
}

GetOrdersProductsBloc getOrdersProductsBloc = GetOrdersProductsBloc();
