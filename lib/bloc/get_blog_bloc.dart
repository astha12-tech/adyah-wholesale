import 'dart:async';

import 'package:adyah_wholesale/api/api.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/model/get_blog_model.dart';

class BlogBloc {
  StreamController<List<GetBlogModel>> blogstreamController =
      StreamController.broadcast();
  Stream<List<GetBlogModel>> get blogStream => blogstreamController.stream;
  List<GetBlogModel>? blogModel;
  blogBlocc(ProgressLoader pl, String url) async {
    blogModel = await apis.getBlogApi(pl, url);
    blogstreamController.sink.add(blogModel!);
  }
}

BlogBloc blogBloc = BlogBloc();
