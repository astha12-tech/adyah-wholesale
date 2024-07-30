import 'dart:convert';

BillingCheckoutModel billingCheckoutModelFromJson(String str) =>
    BillingCheckoutModel.fromJson(json.decode(str));

String billingCheckoutModelToJson(BillingCheckoutModel data) =>
    json.encode(data.toJson());

class BillingCheckoutModel {
  Data? data;
  Meta? meta;

  BillingCheckoutModel({
    this.data,
    this.meta,
  });

  factory BillingCheckoutModel.fromJson(Map<String, dynamic> json) =>
      BillingCheckoutModel(
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
  Cart? cart;
  Address? billingAddress;
  List<Consignment>? consignments;
  List<Tax>? taxes;
  List<dynamic>? coupons;
  dynamic orderId;
  int? shippingCostTotalIncTax;
  int? shippingCostTotalExTax;
  int? handlingCostTotalIncTax;
  int? handlingCostTotalExTax;
  int? taxTotal;
  double? subtotalIncTax;
  double? subtotalExTax;
  double? grandTotal;
  DateTime? createdTime;
  DateTime? updatedTime;
  String? customerMessage;
  String? staffNote;
  List<dynamic>? fees;
  Promotions? promotions;

  Data({
    this.id,
    this.cart,
    this.billingAddress,
    this.consignments,
    this.taxes,
    this.coupons,
    this.orderId,
    this.shippingCostTotalIncTax,
    this.shippingCostTotalExTax,
    this.handlingCostTotalIncTax,
    this.handlingCostTotalExTax,
    this.taxTotal,
    this.subtotalIncTax,
    this.subtotalExTax,
    this.grandTotal,
    this.createdTime,
    this.updatedTime,
    this.customerMessage,
    this.staffNote,
    this.fees,
    this.promotions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        cart: json["cart"] == null ? null : Cart.fromJson(json["cart"]),
        billingAddress: json["billing_address"] == null
            ? null
            : Address.fromJson(json["billing_address"]),
        consignments: json["consignments"] == null
            ? []
            : List<Consignment>.from(
                json["consignments"]!.map((x) => Consignment.fromJson(x))),
        taxes: json["taxes"] == null
            ? []
            : List<Tax>.from(json["taxes"]!.map((x) => Tax.fromJson(x))),
        coupons: json["coupons"] == null
            ? []
            : List<dynamic>.from(json["coupons"]!.map((x) => x)),
        orderId: json["order_id"],
        shippingCostTotalIncTax: json["shipping_cost_total_inc_tax"],
        shippingCostTotalExTax: json["shipping_cost_total_ex_tax"],
        handlingCostTotalIncTax: json["handling_cost_total_inc_tax"],
        handlingCostTotalExTax: json["handling_cost_total_ex_tax"],
        taxTotal: json["tax_total"],
        subtotalIncTax: json["subtotal_inc_tax"]?.toDouble(),
        subtotalExTax: json["subtotal_ex_tax"]?.toDouble(),
        grandTotal: json["grand_total"]?.toDouble(),
        createdTime: json["created_time"] == null
            ? null
            : DateTime.parse(json["created_time"]),
        updatedTime: json["updated_time"] == null
            ? null
            : DateTime.parse(json["updated_time"]),
        customerMessage: json["customer_message"],
        staffNote: json["staff_note"],
        fees: json["fees"] == null
            ? []
            : List<dynamic>.from(json["fees"]!.map((x) => x)),
        promotions: json["promotions"] == null
            ? null
            : Promotions.fromJson(json["promotions"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cart": cart?.toJson(),
        "billing_address": billingAddress?.toJson(),
        "consignments": consignments == null
            ? []
            : List<dynamic>.from(consignments!.map((x) => x.toJson())),
        "taxes": taxes == null
            ? []
            : List<dynamic>.from(taxes!.map((x) => x.toJson())),
        "coupons":
            coupons == null ? [] : List<dynamic>.from(coupons!.map((x) => x)),
        "order_id": orderId,
        "shipping_cost_total_inc_tax": shippingCostTotalIncTax,
        "shipping_cost_total_ex_tax": shippingCostTotalExTax,
        "handling_cost_total_inc_tax": handlingCostTotalIncTax,
        "handling_cost_total_ex_tax": handlingCostTotalExTax,
        "tax_total": taxTotal,
        "subtotal_inc_tax": subtotalIncTax,
        "subtotal_ex_tax": subtotalExTax,
        "grand_total": grandTotal,
        "created_time": createdTime?.toIso8601String(),
        "updated_time": updatedTime?.toIso8601String(),
        "customer_message": customerMessage,
        "staff_note": staffNote,
        "fees": fees == null ? [] : List<dynamic>.from(fees!.map((x) => x)),
        "promotions": promotions?.toJson(),
      };
}

class Address {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? stateOrProvince;
  String? stateOrProvinceCode;
  String? country;
  String? countryCode;
  String? postalCode;
  String? phone;
  List<dynamic>? customFields;

  Address({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.stateOrProvince,
    this.stateOrProvinceCode,
    this.country,
    this.countryCode,
    this.postalCode,
    this.phone,
    this.customFields,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        company: json["company"],
        address1: json["address1"],
        address2: json["address2"],
        city: json["city"],
        stateOrProvince: json["state_or_province"],
        stateOrProvinceCode: json["state_or_province_code"],
        country: json["country"],
        countryCode: json["country_code"],
        postalCode: json["postal_code"],
        phone: json["phone"],
        customFields: json["custom_fields"] == null
            ? []
            : List<dynamic>.from(json["custom_fields"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "company": company,
        "address1": address1,
        "address2": address2,
        "city": city,
        "state_or_province": stateOrProvince,
        "state_or_province_code": stateOrProvinceCode,
        "country": country,
        "country_code": countryCode,
        "postal_code": postalCode,
        "phone": phone,
        "custom_fields": customFields == null
            ? []
            : List<dynamic>.from(customFields!.map((x) => x)),
      };
}

class Cart {
  String? id;
  int? customerId;
  int? channelId;
  String? email;
  Currency? currency;
  bool? taxIncluded;
  double? baseAmount;
  int? discountAmount;
  int? manualDiscountAmount;
  double? cartAmountIncTax;
  double? cartAmountExTax;
  List<dynamic>? coupons;
  List<Discount>? discounts;
  LineItems? lineItems;
  DateTime? createdTime;
  DateTime? updatedTime;

  Cart({
    this.id,
    this.customerId,
    this.channelId,
    this.email,
    this.currency,
    this.taxIncluded,
    this.baseAmount,
    this.discountAmount,
    this.manualDiscountAmount,
    this.cartAmountIncTax,
    this.cartAmountExTax,
    this.coupons,
    this.discounts,
    this.lineItems,
    this.createdTime,
    this.updatedTime,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
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
        cartAmountIncTax: json["cart_amount_inc_tax"]?.toDouble(),
        cartAmountExTax: json["cart_amount_ex_tax"]?.toDouble(),
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
        "cart_amount_inc_tax": cartAmountIncTax,
        "cart_amount_ex_tax": cartAmountExTax,
        "coupons":
            coupons == null ? [] : List<dynamic>.from(coupons!.map((x) => x)),
        "discounts": discounts == null
            ? []
            : List<dynamic>.from(discounts!.map((x) => x.toJson())),
        "line_items": lineItems?.toJson(),
        "created_time": createdTime?.toIso8601String(),
        "updated_time": updatedTime?.toIso8601String(),
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
  bool? isTaxable;
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
  dynamic giftWrapping;
  bool? isMutable;

  PhysicalItem({
    this.id,
    this.parentId,
    this.variantId,
    this.productId,
    this.sku,
    this.name,
    this.url,
    this.quantity,
    this.isTaxable,
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
    this.giftWrapping,
    this.isMutable,
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
        isTaxable: json["is_taxable"],
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
        giftWrapping: json["gift_wrapping"],
        isMutable: json["is_mutable"],
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
        "is_taxable": isTaxable,
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
        "gift_wrapping": giftWrapping,
        "is_mutable": isMutable,
      };
}

class Consignment {
  String? id;
  int? shippingCostIncTax;
  int? shippingCostExTax;
  int? handlingCostIncTax;
  int? handlingCostExTax;
  List<dynamic>? couponDiscounts;
  List<dynamic>? discounts;
  List<String>? lineItemIds;
  SelectedShippingOption? selectedShippingOption;
  Address? shippingAddress;
  Address? address;

  Consignment({
    this.id,
    this.shippingCostIncTax,
    this.shippingCostExTax,
    this.handlingCostIncTax,
    this.handlingCostExTax,
    this.couponDiscounts,
    this.discounts,
    this.lineItemIds,
    this.selectedShippingOption,
    this.shippingAddress,
    this.address,
  });

  factory Consignment.fromJson(Map<String, dynamic> json) => Consignment(
        id: json["id"],
        shippingCostIncTax: json["shipping_cost_inc_tax"],
        shippingCostExTax: json["shipping_cost_ex_tax"],
        handlingCostIncTax: json["handling_cost_inc_tax"],
        handlingCostExTax: json["handling_cost_ex_tax"],
        couponDiscounts: json["coupon_discounts"] == null
            ? []
            : List<dynamic>.from(json["coupon_discounts"]!.map((x) => x)),
        discounts: json["discounts"] == null
            ? []
            : List<dynamic>.from(json["discounts"]!.map((x) => x)),
        lineItemIds: json["line_item_ids"] == null
            ? []
            : List<String>.from(json["line_item_ids"]!.map((x) => x)),
        selectedShippingOption: json["selected_shipping_option"] == null
            ? null
            : SelectedShippingOption.fromJson(json["selected_shipping_option"]),
        shippingAddress: json["shipping_address"] == null
            ? null
            : Address.fromJson(json["shipping_address"]),
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shipping_cost_inc_tax": shippingCostIncTax,
        "shipping_cost_ex_tax": shippingCostExTax,
        "handling_cost_inc_tax": handlingCostIncTax,
        "handling_cost_ex_tax": handlingCostExTax,
        "coupon_discounts": couponDiscounts == null
            ? []
            : List<dynamic>.from(couponDiscounts!.map((x) => x)),
        "discounts": discounts == null
            ? []
            : List<dynamic>.from(discounts!.map((x) => x)),
        "line_item_ids": lineItemIds == null
            ? []
            : List<dynamic>.from(lineItemIds!.map((x) => x)),
        "selected_shipping_option": selectedShippingOption?.toJson(),
        "shipping_address": shippingAddress?.toJson(),
        "address": address?.toJson(),
      };
}

class SelectedShippingOption {
  String? id;
  String? type;
  String? description;
  String? imageUrl;
  int? cost;
  String? transitTime;
  String? additionalDescription;

  SelectedShippingOption({
    this.id,
    this.type,
    this.description,
    this.imageUrl,
    this.cost,
    this.transitTime,
    this.additionalDescription,
  });

  factory SelectedShippingOption.fromJson(Map<String, dynamic> json) =>
      SelectedShippingOption(
        id: json["id"],
        type: json["type"],
        description: json["description"],
        imageUrl: json["image_url"],
        cost: json["cost"],
        transitTime: json["transit_time"],
        additionalDescription: json["additional_description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "description": description,
        "image_url": imageUrl,
        "cost": cost,
        "transit_time": transitTime,
        "additional_description": additionalDescription,
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

class Tax {
  String? name;
  int? amount;

  Tax({
    this.name,
    this.amount,
  });

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
        name: json["name"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount,
      };
}

class Meta {
  Meta();

  factory Meta.fromJson(Map<String, dynamic> json) => Meta();

  Map<String, dynamic> toJson() => {};
}
