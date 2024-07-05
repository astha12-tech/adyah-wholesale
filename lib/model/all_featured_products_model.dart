// To parse this JSON data, do
//
//     final productsMainCategoryModel = productsMainCategoryModelFromJson(jsonString);

// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

FeaturedProductModel productsMainCategoryModelFromJson(String str) =>
    FeaturedProductModel.fromJson(json.decode(str));

String productsMainCategoryModelToJson(FeaturedProductModel data) =>
    json.encode(data.toJson());

class FeaturedProductModel {
  List<Datum>? data;
  Meta? meta;

  FeaturedProductModel({
    this.data,
    this.meta,
  });

  factory FeaturedProductModel.fromJson(Map<String, dynamic> json) =>
      FeaturedProductModel(
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
  String? name;
  String? type;
  String? sku;
  String? description;
  int? weight;
  int? width;
  int? depth;
  int? height;
  double? price;
  int? costPrice;
  int? retailPrice;
  var salePrice;
  int? mapPrice;
  int? taxClassId;
  String? productTaxCode;
  double? calculatedPrice;
  List<int>? categories;
  int? brandId;
  int? optionSetId;
  String? optionSetDisplay;
  var inventoryLevel;
  int? inventoryWarningLevel;
  String? inventoryTracking;
  int? reviewsRatingSum;
  int? reviewsCount;
  int? totalSold;
  int? fixedCostShippingPrice;
  bool? isFreeShipping;
  bool? isVisible;
  bool? isFeatured;
  List<int>? relatedProducts;
  String? warranty;
  String? binPickingNumber;
  String? layoutFile;
  String? upc;
  String? mpn;
  String? gtin;
  dynamic dateLastImported;
  String? searchKeywords;
  String? availability;
  String? availabilityDescription;
  String? giftWrappingOptionsType;
  List<dynamic>? giftWrappingOptionsList;
  int? sortOrder;
  String? condition;
  bool? isConditionShown;
  int? orderQuantityMinimum;
  int? orderQuantityMaximum;
  String? pageTitle;
  List<dynamic>? metaKeywords;
  String? metaDescription;
  DateTime? dateCreated;
  DateTime? dateModified;
  int? viewCount;
  dynamic preorderReleaseDate;
  String? preorderMessage;
  bool? isPreorderOnly;
  bool? isPriceHidden;
  String? priceHiddenLabel;
  CustomUrl? customUrl;
  dynamic baseVariantId;
  String? openGraphType;
  String? openGraphTitle;
  String? openGraphDescription;
  bool? openGraphUseMetaDescription;
  bool? openGraphUseProductName;
  bool? openGraphUseImage;
  List<Variant>? variants;
  List<Image>? images;
  Image? primaryImage;
  List<Option>? options;

  Datum({
    this.id,
    this.name,
    this.type,
    this.sku,
    this.description,
    this.weight,
    this.width,
    this.depth,
    this.height,
    this.price,
    this.costPrice,
    this.retailPrice,
    this.salePrice,
    this.mapPrice,
    this.taxClassId,
    this.productTaxCode,
    this.calculatedPrice,
    this.categories,
    this.brandId,
    this.optionSetId,
    this.optionSetDisplay,
    this.inventoryLevel,
    this.inventoryWarningLevel,
    this.inventoryTracking,
    this.reviewsRatingSum,
    this.reviewsCount,
    this.totalSold,
    this.fixedCostShippingPrice,
    this.isFreeShipping,
    this.isVisible,
    this.isFeatured,
    this.relatedProducts,
    this.warranty,
    this.binPickingNumber,
    this.layoutFile,
    this.upc,
    this.mpn,
    this.gtin,
    this.dateLastImported,
    this.searchKeywords,
    this.availability,
    this.availabilityDescription,
    this.giftWrappingOptionsType,
    this.giftWrappingOptionsList,
    this.sortOrder,
    this.condition,
    this.isConditionShown,
    this.orderQuantityMinimum,
    this.orderQuantityMaximum,
    this.pageTitle,
    this.metaKeywords,
    this.metaDescription,
    this.dateCreated,
    this.dateModified,
    this.viewCount,
    this.preorderReleaseDate,
    this.preorderMessage,
    this.isPreorderOnly,
    this.isPriceHidden,
    this.priceHiddenLabel,
    this.customUrl,
    this.baseVariantId,
    this.openGraphType,
    this.openGraphTitle,
    this.openGraphDescription,
    this.openGraphUseMetaDescription,
    this.openGraphUseProductName,
    this.openGraphUseImage,
    this.variants,
    this.images,
    this.primaryImage,
    this.options,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        type: json["type"]!,
        sku: json["sku"],
        description: json["description"],
        weight: json["weight"],
        width: json["width"],
        depth: json["depth"],
        height: json["height"],
        price: json["price"]?.toDouble(),
        costPrice: json["cost_price"],
        retailPrice: json["retail_price"],
        salePrice: json["sale_price"],
        mapPrice: json["map_price"],
        taxClassId: json["tax_class_id"],
        productTaxCode: json["product_tax_code"],
        calculatedPrice: json["calculated_price"]?.toDouble(),
        categories: json["categories"] == null
            ? []
            : List<int>.from(json["categories"]!.map((x) => x)),
        brandId: json["brand_id"],
        optionSetId: json["option_set_id"],
        optionSetDisplay: json["option_set_display"]!,
        inventoryLevel: json["inventory_level"],
        inventoryWarningLevel: json["inventory_warning_level"],
        inventoryTracking: json["inventory_tracking"]!,
        reviewsRatingSum: json["reviews_rating_sum"],
        reviewsCount: json["reviews_count"],
        totalSold: json["total_sold"],
        fixedCostShippingPrice: json["fixed_cost_shipping_price"],
        isFreeShipping: json["is_free_shipping"],
        isVisible: json["is_visible"],
        isFeatured: json["is_featured"],
        relatedProducts: json["related_products"] == null
            ? []
            : List<int>.from(json["related_products"]!.map((x) => x)),
        warranty: json["warranty"],
        binPickingNumber: json["bin_picking_number"],
        layoutFile: json["layout_file"],
        upc: json["upc"],
        mpn: json["mpn"],
        gtin: json["gtin"],
        dateLastImported: json["date_last_imported"],
        searchKeywords: json["search_keywords"],
        availability: json["availability"]!,
        availabilityDescription: json["availability_description"],
        giftWrappingOptionsType: json["gift_wrapping_options_type"]!,
        giftWrappingOptionsList: json["gift_wrapping_options_list"] == null
            ? []
            : List<dynamic>.from(
                json["gift_wrapping_options_list"]!.map((x) => x)),
        sortOrder: json["sort_order"],
        condition: json["condition"]!,
        isConditionShown: json["is_condition_shown"],
        orderQuantityMinimum: json["order_quantity_minimum"],
        orderQuantityMaximum: json["order_quantity_maximum"],
        pageTitle: json["page_title"],
        metaKeywords: json["meta_keywords"] == null
            ? []
            : List<dynamic>.from(json["meta_keywords"]!.map((x) => x)),
        metaDescription: json["meta_description"],
        dateCreated: json["date_created"] == null
            ? null
            : DateTime.parse(json["date_created"]),
        dateModified: json["date_modified"] == null
            ? null
            : DateTime.parse(json["date_modified"]),
        viewCount: json["view_count"],
        preorderReleaseDate: json["preorder_release_date"],
        preorderMessage: json["preorder_message"],
        isPreorderOnly: json["is_preorder_only"],
        isPriceHidden: json["is_price_hidden"],
        priceHiddenLabel: json["price_hidden_label"],
        customUrl: json["custom_url"] == null
            ? null
            : CustomUrl.fromJson(json["custom_url"]),
        baseVariantId: json["base_variant_id"],
        openGraphType: json["open_graph_type"]!,
        openGraphTitle: json["open_graph_title"],
        openGraphDescription: json["open_graph_description"],
        openGraphUseMetaDescription: json["open_graph_use_meta_description"],
        openGraphUseProductName: json["open_graph_use_product_name"],
        openGraphUseImage: json["open_graph_use_image"],
        variants: json["variants"] == null
            ? []
            : List<Variant>.from(
                json["variants"]!.map((x) => Variant.fromJson(x))),
        images: json["images"] == null
            ? []
            : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
        primaryImage: json["primary_image"] == null
            ? null
            : Image.fromJson(json["primary_image"]),
        options: json["options"] == null
            ? []
            : List<Option>.from(
                json["options"]!.map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "sku": sku,
        "description": description,
        "weight": weight,
        "width": width,
        "depth": depth,
        "height": height,
        "price": price,
        "cost_price": costPrice,
        "retail_price": retailPrice,
        "sale_price": salePrice,
        "map_price": mapPrice,
        "tax_class_id": taxClassId,
        "product_tax_code": productTaxCode,
        "calculated_price": calculatedPrice,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x)),
        "brand_id": brandId,
        "option_set_id": optionSetId,
        "option_set_display": optionSetDisplay,
        "inventory_level": inventoryLevel,
        "inventory_warning_level": inventoryWarningLevel,
        "inventory_tracking": inventoryTracking,
        "reviews_rating_sum": reviewsRatingSum,
        "reviews_count": reviewsCount,
        "total_sold": totalSold,
        "fixed_cost_shipping_price": fixedCostShippingPrice,
        "is_free_shipping": isFreeShipping,
        "is_visible": isVisible,
        "is_featured": isFeatured,
        "related_products": relatedProducts == null
            ? []
            : List<dynamic>.from(relatedProducts!.map((x) => x)),
        "warranty": warranty,
        "bin_picking_number": binPickingNumber,
        "layout_file": layoutFile,
        "upc": upc,
        "mpn": mpn,
        "gtin": gtin,
        "date_last_imported": dateLastImported,
        "search_keywords": searchKeywords,
        "availability": availability,
        "availability_description": availabilityDescription,
        "gift_wrapping_options_type": giftWrappingOptionsType,
        "gift_wrapping_options_list": giftWrappingOptionsList == null
            ? []
            : List<dynamic>.from(giftWrappingOptionsList!.map((x) => x)),
        "sort_order": sortOrder,
        "condition": condition,
        "is_condition_shown": isConditionShown,
        "order_quantity_minimum": orderQuantityMinimum,
        "order_quantity_maximum": orderQuantityMaximum,
        "page_title": pageTitle,
        "meta_keywords": metaKeywords == null
            ? []
            : List<dynamic>.from(metaKeywords!.map((x) => x)),
        "meta_description": metaDescription,
        "date_created": dateCreated?.toIso8601String(),
        "date_modified": dateModified?.toIso8601String(),
        "view_count": viewCount,
        "preorder_release_date": preorderReleaseDate,
        "preorder_message": preorderMessage,
        "is_preorder_only": isPreorderOnly,
        "is_price_hidden": isPriceHidden,
        "price_hidden_label": priceHiddenLabel,
        "custom_url": customUrl?.toJson(),
        "base_variant_id": baseVariantId,
        "open_graph_type": openGraphType,
        "open_graph_title": openGraphTitle,
        "open_graph_description": openGraphDescription,
        "open_graph_use_meta_description": openGraphUseMetaDescription,
        "open_graph_use_product_name": openGraphUseProductName,
        "open_graph_use_image": openGraphUseImage,
        "variants": variants == null
            ? []
            : List<dynamic>.from(variants!.map((x) => x.toJson())),
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "primary_image": primaryImage?.toJson(),
        "options": options == null
            ? []
            : List<dynamic>.from(options!.map((x) => x.toJson())),
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

class Image {
  int? id;
  int? productId;
  bool? isThumbnail;
  int? sortOrder;
  String? description;
  String? imageFile;
  String? urlZoom;
  String? urlStandard;
  String? urlThumbnail;
  String? urlTiny;
  DateTime? dateModified;

  Image({
    this.id,
    this.productId,
    this.isThumbnail,
    this.sortOrder,
    this.description,
    this.imageFile,
    this.urlZoom,
    this.urlStandard,
    this.urlThumbnail,
    this.urlTiny,
    this.dateModified,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        productId: json["product_id"],
        isThumbnail: json["is_thumbnail"],
        sortOrder: json["sort_order"],
        description: json["description"],
        imageFile: json["image_file"],
        urlZoom: json["url_zoom"],
        urlStandard: json["url_standard"],
        urlThumbnail: json["url_thumbnail"],
        urlTiny: json["url_tiny"],
        dateModified: json["date_modified"] == null
            ? null
            : DateTime.parse(json["date_modified"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "is_thumbnail": isThumbnail,
        "sort_order": sortOrder,
        "description": description,
        "image_file": imageFile,
        "url_zoom": urlZoom,
        "url_standard": urlStandard,
        "url_thumbnail": urlThumbnail,
        "url_tiny": urlTiny,
        "date_modified": dateModified?.toIso8601String(),
      };
}

class Option {
  int? id;
  int? productId;
  String? name;
  String? displayName;
  String? type;
  int? sortOrder;
  List<OptionOptionValue>? optionValues;
  List<dynamic>? config;

  Option({
    this.id,
    this.productId,
    this.name,
    this.displayName,
    this.type,
    this.sortOrder,
    this.optionValues,
    this.config,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        productId: json["product_id"],
        name: json["name"],
        displayName: json["display_name"]!,
        type: json["type"]!,
        sortOrder: json["sort_order"],
        optionValues: json["option_values"] == null
            ? []
            : List<OptionOptionValue>.from(json["option_values"]!
                .map((x) => OptionOptionValue.fromJson(x))),
        config: json["config"] == null
            ? []
            : List<dynamic>.from(json["config"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "name": name,
        "display_name": displayName,
        "type": type,
        "sort_order": sortOrder,
        "option_values": optionValues == null
            ? []
            : List<dynamic>.from(optionValues!.map((x) => x.toJson())),
        "config":
            config == null ? [] : List<dynamic>.from(config!.map((x) => x)),
      };
}

class OptionOptionValue {
  int? id;
  String? label;
  int? sortOrder;
  dynamic valueData;
  bool? isDefault;

  OptionOptionValue({
    this.id,
    this.label,
    this.sortOrder,
    this.valueData,
    this.isDefault,
  });

  factory OptionOptionValue.fromJson(Map<String, dynamic> json) =>
      OptionOptionValue(
        id: json["id"],
        label: json["label"],
        sortOrder: json["sort_order"],
        valueData: json["value_data"],
        isDefault: json["is_default"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "sort_order": sortOrder,
        "value_data": valueData,
        "is_default": isDefault,
      };
}

class Variant {
  int? id;
  int? productId;
  int? quantity;
  String? sku;
  int? skuId;
  double? price;
  double? calculatedPrice;
  dynamic salePrice;
  int? retailPrice;
  dynamic mapPrice;
  int? weight;
  int? calculatedWeight;
  dynamic width;
  dynamic height;
  dynamic depth;
  bool? isFreeShipping;
  dynamic fixedCostShippingPrice;
  bool? purchasingDisabled;
  String? purchasingDisabledMessage;
  String? imageUrl;
  int? costPrice;
  String? upc;
  String? mpn;
  String? gtin;
  var inventoryLevel;
  int? inventoryWarningLevel;
  String? binPickingNumber;
  List<VariantOptionValue>? optionValues;

  Variant({
    this.id,
    this.productId,
    this.sku,
    this.skuId,
    this.price,
    this.calculatedPrice,
    this.salePrice,
    this.retailPrice,
    this.mapPrice,
    this.weight,
    this.calculatedWeight,
    this.width,
    this.height,
    this.depth,
    this.isFreeShipping,
    this.fixedCostShippingPrice,
    this.purchasingDisabled,
    this.purchasingDisabledMessage,
    this.imageUrl,
    this.costPrice,
    this.upc,
    this.mpn,
    this.quantity,
    this.gtin,
    this.inventoryLevel,
    this.inventoryWarningLevel,
    this.binPickingNumber,
    this.optionValues,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        id: json["id"],
        productId: json["product_id"],
        sku: json["sku"],
        skuId: json["sku_id"],
        price: json["price"]?.toDouble(),
        calculatedPrice: json["calculated_price"]?.toDouble(),
        salePrice: json["sale_price"],
        retailPrice: json["retail_price"],
        mapPrice: json["map_price"],
        weight: json["weight"],
        calculatedWeight: json["calculated_weight"],
        width: json["width"],
        height: json["height"],
        depth: json["depth"],
        isFreeShipping: json["is_free_shipping"],
        fixedCostShippingPrice: json["fixed_cost_shipping_price"],
        purchasingDisabled: json["purchasing_disabled"],
        purchasingDisabledMessage: json["purchasing_disabled_message"],
        imageUrl: json["image_url"],
        costPrice: json["cost_price"],
        upc: json["upc"],
        mpn: json["mpn"],
        gtin: json["gtin"],
        inventoryLevel: json["inventory_level"],
        inventoryWarningLevel: json["inventory_warning_level"],
        binPickingNumber: json["bin_picking_number"],
        optionValues: json["option_values"] == null
            ? []
            : List<VariantOptionValue>.from(json["option_values"]!
                .map((x) => VariantOptionValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "sku": sku,
        "sku_id": skuId,
        "price": price,
        "calculated_price": calculatedPrice,
        "sale_price": salePrice,
        "retail_price": retailPrice,
        "map_price": mapPrice,
        "weight": weight,
        "calculated_weight": calculatedWeight,
        "width": width,
        "height": height,
        "depth": depth,
        "is_free_shipping": isFreeShipping,
        "fixed_cost_shipping_price": fixedCostShippingPrice,
        "purchasing_disabled": purchasingDisabled,
        "purchasing_disabled_message": purchasingDisabledMessage,
        "image_url": imageUrl,
        "cost_price": costPrice,
        "upc": upc,
        "mpn": mpn,
        "gtin": gtin,
        "inventory_level": inventoryLevel,
        "inventory_warning_level": inventoryWarningLevel,
        "bin_picking_number": binPickingNumber,
        "option_values": optionValues == null
            ? []
            : List<dynamic>.from(optionValues!.map((x) => x.toJson())),
      };
}

class VariantOptionValue {
  int? id;
  String? label;
  int? optionId;
  String? optionDisplayName;

  VariantOptionValue({
    this.id,
    this.label,
    this.optionId,
    this.optionDisplayName,
  });

  factory VariantOptionValue.fromJson(Map<String, dynamic> json) =>
      VariantOptionValue(
        id: json["id"],
        label: json["label"],
        optionId: json["option_id"],
        optionDisplayName: json["option_display_name"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "option_id": optionId,
        "option_display_name": optionDisplayName,
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
  bool? tooMany;

  Pagination({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
    this.links,
    this.tooMany,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        count: json["count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        tooMany: json["too_many"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "count": count,
        "per_page": perPage,
        "current_page": currentPage,
        "total_pages": totalPages,
        "links": links?.toJson(),
        "too_many": tooMany,
      };
}

class Links {
  String? next;
  String? current;

  Links({
    this.next,
    this.current,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        next: json["next"],
        current: json["current"],
      );

  Map<String, dynamic> toJson() => {
        "next": next,
        "current": current,
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
