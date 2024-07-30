import 'dart:convert';

CartDataModel cartDataModelFromJson(String str) =>
    CartDataModel.fromJson(json.decode(str));

String cartDataModelToJson(CartDataModel data) => json.encode(data.toJson());

class CartDataModel {
  Data? data;
  Meta? meta;

  CartDataModel({
    this.data,
    this.meta,
  });

  factory CartDataModel.fromJson(Map<String, dynamic> json) => CartDataModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "meta": meta?.toJson(),
      };
}

class Data {
  String? id;
  int? customerId;
  int? channelId;
  String? email;
  Currency? currency;
  bool? taxIncluded;
  double? baseAmount;
  int? discountAmount;
  int? manualDiscountAmount;
  double? cartAmount;
  List<dynamic>? coupons;
  List<Discount>? discounts;
  LineItems? lineItems;
  DateTime? createdTime;
  DateTime? updatedTime;
  String? locale;
  RedirectUrls? redirectUrls;
  Promotions? promotions;

  Data({
    this.id,
    this.customerId,
    this.channelId,
    this.email,
    this.currency,
    this.taxIncluded,
    this.baseAmount,
    this.discountAmount,
    this.manualDiscountAmount,
    this.cartAmount,
    this.coupons,
    this.discounts,
    this.lineItems,
    this.createdTime,
    this.updatedTime,
    this.locale,
    this.redirectUrls,
    this.promotions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        customerId: json["customer_id"],
        channelId: json["channel_id"],
        email: json["email"],
        currency: json["currency"] == null
            ? null
            : Currency.fromJson(json["currency"]),
        taxIncluded: json["tax_included"],
        baseAmount: json["base_amount"]?.toDouble(),
        discountAmount: json["discount_amount"],
        manualDiscountAmount: json["manual_discount_amount"],
        cartAmount: json["cart_amount"]?.toDouble(),
        coupons: json["coupons"] == null
            ? []
            : List<dynamic>.from(json["coupons"]!.map((x) => x)),
        discounts: json["discounts"] == null
            ? []
            : List<Discount>.from(
                json["discounts"]!.map((x) => Discount.fromJson(x))),
        lineItems: json["line_items"] == null
            ? null
            : LineItems.fromJson(json["line_items"]),
        createdTime: json["created_time"] == null
            ? null
            : DateTime.parse(json["created_time"]),
        updatedTime: json["updated_time"] == null
            ? null
            : DateTime.parse(json["updated_time"]),
        locale: json["locale"],
        redirectUrls: json["redirect_urls"] == null
            ? null
            : RedirectUrls.fromJson(json["redirect_urls"]),
        promotions: json["promotions"] == null
            ? null
            : Promotions.fromJson(json["promotions"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "channel_id": channelId,
        "email": email,
        "currency": currency?.toJson(),
        "tax_included": taxIncluded,
        "base_amount": baseAmount,
        "discount_amount": discountAmount,
        "manual_discount_amount": manualDiscountAmount,
        "cart_amount": cartAmount,
        "coupons":
            coupons == null ? [] : List<dynamic>.from(coupons!.map((x) => x)),
        "discounts": discounts == null
            ? []
            : List<dynamic>.from(discounts!.map((x) => x.toJson())),
        "line_items": lineItems?.toJson(),
        "created_time": createdTime?.toIso8601String(),
        "updated_time": updatedTime?.toIso8601String(),
        "locale": locale,
        "redirect_urls": redirectUrls?.toJson(),
        "promotions": promotions?.toJson(),
      };
}

class Currency {
  String? code;

  Currency({
    this.code,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
      };
}

class Discount {
  String? id;
  int? discountedAmount;

  Discount({
    this.id,
    this.discountedAmount,
  });

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        id: json["id"],
        discountedAmount: json["discounted_amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "discounted_amount": discountedAmount,
      };
}

class LineItems {
  List<PhysicalItem>? physicalItems;
  List<dynamic>? digitalItems;
  List<dynamic>? giftCertificates;
  List<dynamic>? customItems;

  LineItems({
    this.physicalItems,
    this.digitalItems,
    this.giftCertificates,
    this.customItems,
  });

  factory LineItems.fromJson(Map<String, dynamic> json) => LineItems(
        physicalItems: json["physical_items"] == null
            ? []
            : List<PhysicalItem>.from(
                json["physical_items"]!.map((x) => PhysicalItem.fromJson(x))),
        digitalItems: json["digital_items"] == null
            ? []
            : List<dynamic>.from(json["digital_items"]!.map((x) => x)),
        giftCertificates: json["gift_certificates"] == null
            ? []
            : List<dynamic>.from(json["gift_certificates"]!.map((x) => x)),
        customItems: json["custom_items"] == null
            ? []
            : List<dynamic>.from(json["custom_items"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "physical_items": physicalItems == null
            ? []
            : List<dynamic>.from(physicalItems!.map((x) => x.toJson())),
        "digital_items": digitalItems == null
            ? []
            : List<dynamic>.from(digitalItems!.map((x) => x)),
        "gift_certificates": giftCertificates == null
            ? []
            : List<dynamic>.from(giftCertificates!.map((x) => x)),
        "custom_items": customItems == null
            ? []
            : List<dynamic>.from(customItems!.map((x) => x)),
      };
}

class PhysicalItem {
  String? id;
  dynamic parentId;
  int? variantId;
  int? productId;
  String? sku;
  String? name;
  String? url;
  int? quantity;
  bool? taxable;
  String? imageUrl;
  List<dynamic>? discounts;
  List<dynamic>? coupons;
  int? discountAmount;
  int? couponAmount;
  double? originalPrice;
  double? listPrice;
  double? salePrice;
  double? extendedListPrice;
  double? extendedSalePrice;
  bool? isRequireShipping;
  bool? isMutable;
  List<Option>? options;

  PhysicalItem({
    this.id,
    this.parentId,
    this.variantId,
    this.productId,
    this.sku,
    this.name,
    this.url,
    this.quantity,
    this.taxable,
    this.imageUrl,
    this.discounts,
    this.coupons,
    this.discountAmount,
    this.couponAmount,
    this.originalPrice,
    this.listPrice,
    this.salePrice,
    this.extendedListPrice,
    this.extendedSalePrice,
    this.isRequireShipping,
    this.isMutable,
    this.options,
  });

  factory PhysicalItem.fromJson(Map<String, dynamic> json) => PhysicalItem(
        id: json["id"],
        parentId: json["parent_id"],
        variantId: json["variant_id"],
        productId: json["product_id"],
        sku: json["sku"],
        name: json["name"],
        url: json["url"],
        quantity: json["quantity"],
        taxable: json["taxable"],
        imageUrl: json["image_url"],
        discounts: json["discounts"] == null
            ? []
            : List<dynamic>.from(json["discounts"]!.map((x) => x)),
        coupons: json["coupons"] == null
            ? []
            : List<dynamic>.from(json["coupons"]!.map((x) => x)),
        discountAmount: json["discount_amount"],
        couponAmount: json["coupon_amount"],
        originalPrice: json["original_price"]?.toDouble(),
        listPrice: json["list_price"]?.toDouble(),
        salePrice: json["sale_price"]?.toDouble(),
        extendedListPrice: json["extended_list_price"]?.toDouble(),
        extendedSalePrice: json["extended_sale_price"]?.toDouble(),
        isRequireShipping: json["is_require_shipping"],
        isMutable: json["is_mutable"],
        options: json["options"] == null
            ? []
            : List<Option>.from(
                json["options"]!.map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "variant_id": variantId,
        "product_id": productId,
        "sku": sku,
        "name": name,
        "url": url,
        "quantity": quantity,
        "taxable": taxable,
        "image_url": imageUrl,
        "discounts": discounts == null
            ? []
            : List<dynamic>.from(discounts!.map((x) => x)),
        "coupons":
            coupons == null ? [] : List<dynamic>.from(coupons!.map((x) => x)),
        "discount_amount": discountAmount,
        "coupon_amount": couponAmount,
        "original_price": originalPrice,
        "list_price": listPrice,
        "sale_price": salePrice,
        "extended_list_price": extendedListPrice,
        "extended_sale_price": extendedSalePrice,
        "is_require_shipping": isRequireShipping,
        "is_mutable": isMutable,
        "options": options == null
            ? []
            : List<dynamic>.from(options!.map((x) => x.toJson())),
      };
}

class Option {
  String? name;
  int? nameId;
  String? value;
  var valueId;

  Option({
    this.name,
    this.nameId,
    this.value,
    this.valueId,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        name: json["name"],
        nameId: json["nameId"],
        value: json["value"],
        valueId: json["valueId"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "nameId": nameId,
        "value": value,
        "valueId": valueId,
      };
}

class Promotions {
  List<dynamic>? banners;

  Promotions({
    this.banners,
  });

  factory Promotions.fromJson(Map<String, dynamic> json) => Promotions(
        banners: json["banners"] == null
            ? []
            : List<dynamic>.from(json["banners"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "banners":
            banners == null ? [] : List<dynamic>.from(banners!.map((x) => x)),
      };
}

class RedirectUrls {
  String? cartUrl;
  String? checkoutUrl;
  String? embeddedCheckoutUrl;

  RedirectUrls({
    this.cartUrl,
    this.checkoutUrl,
    this.embeddedCheckoutUrl,
  });

  factory RedirectUrls.fromJson(Map<String, dynamic> json) => RedirectUrls(
        cartUrl: json["cart_url"],
        checkoutUrl: json["checkout_url"],
        embeddedCheckoutUrl: json["embedded_checkout_url"],
      );

  Map<String, dynamic> toJson() => {
        "cart_url": cartUrl,
        "checkout_url": checkoutUrl,
        "embedded_checkout_url": embeddedCheckoutUrl,
      };
}

class Meta {
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) => Meta();

  Map<String, dynamic> toJson() => {};
}
