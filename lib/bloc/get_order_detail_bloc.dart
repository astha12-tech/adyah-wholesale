import 'dart:async';

import 'package:adyah_wholesale/api/api.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/model/get_my_order_details_model.dart';

class GetAllOrderDetailBloc {
  StreamController<GetMyOrdersDetailsModel> getAllOrderDetailstreamController =
      StreamController.broadcast();
  Stream<GetMyOrdersDetailsModel> get getAllorderDetailcategoryStream =>
      getAllOrderDetailstreamController.stream;
  GetMyOrdersDetailsModel? getMyOrdersDetailsModel;
  getAllrderDeatilsBloc(ProgressLoader pl, var orderID) async {
    getMyOrdersDetailsModel = await apis.getMyOrderDetailsApi(pl, orderID);
    getAllOrderDetailstreamController.sink.add(getMyOrdersDetailsModel!);
  }
}

GetAllOrderDetailBloc getAllOrderDetailBloc = GetAllOrderDetailBloc();
