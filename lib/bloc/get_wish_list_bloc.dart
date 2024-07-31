import 'dart:async';

import 'package:adyah_wholesale/api/api.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/model/get_wish_list_model.dart';

class GetWishlistBloc {
  StreamController<GetWishListModel> getWishliststreamController =
      StreamController.broadcast();
  Stream<GetWishListModel> get getWishlistcategoryStream =>
      getWishliststreamController.stream;
  GetWishListModel? getWishListModel;
  getWishListBloc(ProgressLoader pl) async {
    getWishListModel = await apis.getWishListApi(pl);
    getWishliststreamController.sink.add(getWishListModel!);
  }
}

GetWishlistBloc getWishlistBloc = GetWishlistBloc();
