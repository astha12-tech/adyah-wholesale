import 'dart:async';

import 'package:adyah_wholesale/api/api.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/model/parent_category_model.dart';

class ParentCategoryBloc {
  StreamController<ParentCategoryModel> parentcategorystreamController =
      StreamController.broadcast();
  Stream<ParentCategoryModel> get parentcategoryStream =>
      parentcategorystreamController.stream;
  ParentCategoryModel? parentCategoryModel;
  parentcategoryBloc(ProgressLoader pl) async {
    parentCategoryModel = await apis.categoryListApi2(pl);
    parentcategorystreamController.sink.add(parentCategoryModel!);
  }
}

ParentCategoryBloc parentCategoryBloc = ParentCategoryBloc();
