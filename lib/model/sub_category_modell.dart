import 'dart:convert';

SubCategoryModel categoryModelFromJson(String str) =>
    SubCategoryModel.fromJson(json.decode(str));

String categoryModelToJson(SubCategoryModel data) => json.encode(data.toJson());

class SubCategoryModel {
  List<Datum>? data;
  Meta? meta;

  SubCategoryModel({
    this.data,
    this.meta,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
      };
}

class Datum {
  int? id;
  int? parentId;
  String? name;
  bool? isVisible;
  int? depth;
  List<int>? path;
  List<Datum>? children;
  String? url;

  Datum({
    this.id,
    this.parentId,
    this.name,
    this.isVisible,
    this.depth,
    this.path,
    this.children,
    this.url,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        parentId: json["parent_id"],
        name: json["name"],
        isVisible: json["is_visible"],
        depth: json["depth"],
        path: json["path"] == null
            ? []
            : List<int>.from(json["path"]!.map((x) => x)),
        children: json["children"] == null
            ? []
            : List<Datum>.from(json["children"]!.map((x) => Datum.fromJson(x))),
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "name": name,
        "is_visible": isVisible,
        "depth": depth,
        "path": path == null ? [] : List<dynamic>.from(path!.map((x) => x)),
        "children": children == null
            ? []
            : List<dynamic>.from(children!.map((x) => x.toJson())),
        "url": url,
      };
}

class Meta {
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) => Meta();

  Map<String, dynamic> toJson() => {};
}
