import 'dart:convert';

ImageCategoryModel imageCategoryModelFromJson(String str) =>
    ImageCategoryModel.fromJson(json.decode(str));

String imageCategoryModelToJson(ImageCategoryModel data) =>
    json.encode(data.toJson());

class ImageCategoryModel {
  Data? data;
  Meta? meta;

  ImageCategoryModel({
    this.data,
    this.meta,
  });

  factory ImageCategoryModel.fromJson(Map<String, dynamic> json) =>
      ImageCategoryModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "meta": meta?.toJson(),
      };
}

class Data {
  int? id;
  int? parentId;
  String? name;
  String? description;
  int? views;
  int? sortOrder;
  String? pageTitle;
  String? searchKeywords;
  List<dynamic>? metaKeywords;
  String? metaDescription;
  String? layoutFile;
  bool? isVisible;
  String? defaultProductSort;
  CustomUrl? customUrl;
  String? imageUrl;

  Data({
    this.id,
    this.parentId,
    this.name,
    this.description,
    this.views,
    this.sortOrder,
    this.pageTitle,
    this.searchKeywords,
    this.metaKeywords,
    this.metaDescription,
    this.layoutFile,
    this.isVisible,
    this.defaultProductSort,
    this.customUrl,
    this.imageUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        parentId: json["parent_id"],
        name: json["name"],
        description: json["description"],
        views: json["views"],
        sortOrder: json["sort_order"],
        pageTitle: json["page_title"],
        searchKeywords: json["search_keywords"],
        metaKeywords: json["meta_keywords"] == null
            ? []
            : List<dynamic>.from(json["meta_keywords"]!.map((x) => x)),
        metaDescription: json["meta_description"],
        layoutFile: json["layout_file"],
        isVisible: json["is_visible"],
        defaultProductSort: json["default_product_sort"],
        customUrl: json["custom_url"] == null
            ? null
            : CustomUrl.fromJson(json["custom_url"]),
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "name": name,
        "description": description,
        "views": views,
        "sort_order": sortOrder,
        "page_title": pageTitle,
        "search_keywords": searchKeywords,
        "meta_keywords": metaKeywords == null
            ? []
            : List<dynamic>.from(metaKeywords!.map((x) => x)),
        "meta_description": metaDescription,
        "layout_file": layoutFile,
        "is_visible": isVisible,
        "default_product_sort": defaultProductSort,
        "custom_url": customUrl?.toJson(),
        "image_url": imageUrl,
      };
}

class CustomUrl {
  String? url;
  bool? isCustomized;

  CustomUrl({
    this.url,
    this.isCustomized,
  });

  factory CustomUrl.fromJson(Map<String, dynamic> json) => CustomUrl(
        url: json["url"],
        isCustomized: json["is_customized"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "is_customized": isCustomized,
      };
}

class Meta {
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) => Meta();

  Map<String, dynamic> toJson() => {};
}
