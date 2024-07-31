import 'dart:convert';

ParentCategoryModel parentCategoryModelFromJson(String str) =>
    ParentCategoryModel.fromJson(json.decode(str));

String parentCategoryModelToJson(ParentCategoryModel data) =>
    json.encode(data.toJson());

class ParentCategoryModel {
  List<Datum>? data;
  Meta? meta;

  ParentCategoryModel({
    this.data,
    this.meta,
  });

  factory ParentCategoryModel.fromJson(Map<String, dynamic> json) =>
      ParentCategoryModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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
  int? categoryId;
  int? parentId;
  int? treeId;
  String? name;
  String? description;
  int? views;
  int? sortOrder;
  String? pageTitle;
  String? searchKeywords;
  List<String>? metaKeywords;
  String? metaDescription;
  String? layoutFile;
  bool? isVisible;
  String? defaultProductSort;
  Url? url;
  String? imageUrl;
  String? categoryUuid;

  Datum({
    this.categoryId,
    this.parentId,
    this.treeId,
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
    this.url,
    this.imageUrl,
    this.categoryUuid,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        categoryId: json["category_id"],
        parentId: json["parent_id"],
        treeId: json["tree_id"],
        name: json["name"],
        description: json["description"],
        views: json["views"],
        sortOrder: json["sort_order"],
        pageTitle: json["page_title"],
        searchKeywords: json["search_keywords"],
        metaKeywords: json["meta_keywords"] == null
            ? []
            : json["meta_keywords"] is List<dynamic>
                ? List<String>.from(json["meta_keywords"])
                : [],
        metaDescription: json["meta_description"],
        layoutFile: json["layout_file"],
        isVisible: json["is_visible"],
        defaultProductSort: json["default_product_sort"],
        url: json["url"] == null || json["url"] is String
            ? null
            : Url.fromJson(json["url"]),
        imageUrl: json["image_url"],
        categoryUuid: json["category_uuid"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "parent_id": parentId,
        "tree_id": treeId,
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
        "url": url?.toJson(),
        "image_url": imageUrl,
        "category_uuid": categoryUuid,
      };
}

class Url {
  String? path;
  bool? isCustomized;

  Url({
    this.path,
    this.isCustomized,
  });

  factory Url.fromJson(Map<String, dynamic> json) => Url(
        path: json["path"],
        isCustomized: json["is_customized"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "is_customized": isCustomized,
      };
}

class Meta {
  Pagination? pagination;

  Meta({
    this.pagination,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination?.toJson(),
      };
}

class Pagination {
  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPages;
  Links? links;

  Pagination({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
    this.links,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        count: json["count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "count": count,
        "per_page": perPage,
        "current_page": currentPage,
        "total_pages": totalPages,
        "links": links?.toJson(),
      };
}

class Links {
  String? previous;
  String? current;
  String? next;

  Links({
    this.previous,
    this.current,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        previous: json["previous"],
        current: json["current"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "previous": previous,
        "current": current,
        "next": next,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
