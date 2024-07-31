import 'dart:async';

import 'package:adyah_wholesale/api/api.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/model/home_banner_model.dart';

class HomeBannerBloc {
  StreamController<List<HomeBannerModel>> homeBannerstreamController =
      StreamController.broadcast();
  Stream<List<HomeBannerModel>> get homeBannerStream =>
      homeBannerstreamController.stream;
  List<HomeBannerModel>? getAllBrandsModel;
  homeBannerBloc(ProgressLoader pl) async {
    getAllBrandsModel = await apis.homebannerApi(pl);
    homeBannerstreamController.sink.add(getAllBrandsModel!);
  }
}

HomeBannerBloc homeBannerBloc = HomeBannerBloc();
