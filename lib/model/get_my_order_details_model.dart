import 'dart:convert';

GetMyOrdersDetailsModel getMyOrdersDetailsModelFromJson(String str) =>
    GetMyOrdersDetailsModel.fromJson(json.decode(str));

String getMyOrdersDetailsModelToJson(GetMyOrdersDetailsModel data) =>
    json.encode(data.toJson());

class GetMyOrdersDetailsModel {
  int? code;
  String? message;
  Data? data;

  GetMyOrdersDetailsModel({
    this.code,
    this.message,
    this.data,
  });

  factory GetMyOrdersDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetMyOrdersDetailsModel(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int? id;
  int? customerId;
  String? dateCreated;
  String? dateModified;
  String? dateShipped;
  int? statusId;
  String? status;
  String? subtotalExTax;
  String? subtotalIncTax;
  String? subtotalTax;
  String? baseShippingCost;
  String? shippingCostExTax;
  String? shippingCostIncTax;
  String? shippingCostTax;
  int? shippingCostTaxClassId;
  String? baseHandlingCost;
  String? handlingCostExTax;
  String? handlingCostIncTax;
  String? handlingCostTax;
  int? handlingCostTaxClassId;
  String? baseWrappingCost;
  String? wrappingCostExTax;
  String? wrappingCostIncTax;
  String? wrappingCostTax;
  int? wrappingCostTaxClassId;
  String? totalExTax;
  String? totalIncTax;
  String? totalTax;
  int? itemsTotal;
  int? itemsShipped;
  String? paymentMethod;
  String? paymentProviderId;
  String? paymentStatus;
  String? refundedAmount;
  bool? orderIsDigital;
  String? storeCreditAmount;
  String? giftCertificateAmount;
  String? ipAddress;
  String? ipAddressV6;
  String? geoipCountry;
  String? geoipCountryIso2;
  int? currencyId;
  String? currencyCode;
  String? currencyExchangeRate;
  int? defaultCurrencyId;
  String? defaultCurrencyCode;
  dynamic staffNotes;
  dynamic customerMessage;
  String? discountAmount;
  String? couponDiscount;
  int? shippingAddressCount;
  bool? isDeleted;
  String? ebayOrderId;
  dynamic cartId;
  BillingAddress? billingAddress;
  bool? isEmailOptIn;
  String? creditCardType;
  String? orderSource;
  int? dataChannelId;
  dynamic externalSource;
  Consignments? consignments;
  List<Product>? products;
  Consignments? shippingAddresses;
  Consignments? coupons;
  dynamic externalId;
  dynamic externalMerchantId;
  String? taxProviderId;
  String? customerLocale;
  String? externalOrderId;
  String? storeDefaultCurrencyCode;
  String? storeDefaultToTransactionalExchangeRate;
  String? customStatus;
  List<ShippingAddress>? shippingAddress;
  bool? shipments;
  String? poNumber;
  int? bundleDateModified;
  int? bundleDateCreated;
  Money? money;
  String? referenceNumber;
  int? isInvoiceOrder;
  dynamic extraInt2;
  dynamic extraInt3;
  dynamic extraInt4;
  dynamic extraInt5;
  dynamic extraStr1;
  dynamic extraStr2;
  dynamic extraStr3;
  dynamic extraStr4;
  dynamic extraStr5;
  dynamic extraText;
  dynamic extraInfo;
  dynamic channelId;
  String? channelName;

  Data({
    this.id,
    this.customerId,
    this.dateCreated,
    this.dateModified,
    this.dateShipped,
    this.statusId,
    this.status,
    this.subtotalExTax,
    this.subtotalIncTax,
    this.subtotalTax,
    this.baseShippingCost,
    this.shippingCostExTax,
    this.shippingCostIncTax,
    this.shippingCostTax,
    this.shippingCostTaxClassId,
    this.baseHandlingCost,
    this.handlingCostExTax,
    this.handlingCostIncTax,
    this.handlingCostTax,
    this.handlingCostTaxClassId,
    this.baseWrappingCost,
    this.wrappingCostExTax,
    this.wrappingCostIncTax,
    this.wrappingCostTax,
    this.wrappingCostTaxClassId,
    this.totalExTax,
    this.totalIncTax,
    this.totalTax,
    this.itemsTotal,
    this.itemsShipped,
    this.paymentMethod,
    this.paymentProviderId,
    this.paymentStatus,
    this.refundedAmount,
    this.orderIsDigital,
    this.storeCreditAmount,
    this.giftCertificateAmount,
    this.ipAddress,
    this.ipAddressV6,
    this.geoipCountry,
    this.geoipCountryIso2,
    this.currencyId,
    this.currencyCode,
    this.currencyExchangeRate,
    this.defaultCurrencyId,
    this.defaultCurrencyCode,
    this.staffNotes,
    this.customerMessage,
    this.discountAmount,
    this.couponDiscount,
    this.shippingAddressCount,
    this.isDeleted,
    this.ebayOrderId,
    this.cartId,
    this.billingAddress,
    this.isEmailOptIn,
    this.creditCardType,
    this.orderSource,
    this.dataChannelId,
    this.externalSource,
    this.consignments,
    this.products,
    this.shippingAddresses,
    this.coupons,
    this.externalId,
    this.externalMerchantId,
    this.taxProviderId,
    this.customerLocale,
    this.externalOrderId,
    this.storeDefaultCurrencyCode,
    this.storeDefaultToTransactionalExchangeRate,
    this.customStatus,
    this.shippingAddress,
    this.shipments,
    this.poNumber,
    this.bundleDateModified,
    this.bundleDateCreated,
    this.money,
    this.referenceNumber,
    this.isInvoiceOrder,
    this.extraInt2,
    this.extraInt3,
    this.extraInt4,
    this.extraInt5,
    this.extraStr1,
    this.extraStr2,
    this.extraStr3,
    this.extraStr4,
    this.extraStr5,
    this.extraText,
    this.extraInfo,
    this.channelId,
    this.channelName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        customerId: json["customer_id"],
        dateCreated: json["date_created"],
        dateModified: json["date_modified"],
        dateShipped: json["date_shipped"],
        statusId: json["status_id"],
        status: json["status"],
        subtotalExTax: json["subtotal_ex_tax"],
        subtotalIncTax: json["subtotal_inc_tax"],
        subtotalTax: json["subtotal_tax"],
        baseShippingCost: json["base_shipping_cost"],
        shippingCostExTax: json["shipping_cost_ex_tax"],
        shippingCostIncTax: json["shipping_cost_inc_tax"],
        shippingCostTax: json["shipping_cost_tax"],
        shippingCostTaxClassId: json["shipping_cost_tax_class_id"],
        baseHandlingCost: json["base_handling_cost"],
        handlingCostExTax: json["handling_cost_ex_tax"],
        handlingCostIncTax: json["handling_cost_inc_tax"],
        handlingCostTax: json["handling_cost_tax"],
        handlingCostTaxClassId: json["handling_cost_tax_class_id"],
        baseWrappingCost: json["base_wrapping_cost"],
        wrappingCostExTax: json["wrapping_cost_ex_tax"],
        wrappingCostIncTax: json["wrapping_cost_inc_tax"],
        wrappingCostTax: json["wrapping_cost_tax"],
        wrappingCostTaxClassId: json["wrapping_cost_tax_class_id"],
        totalExTax: json["total_ex_tax"],
        totalIncTax: json["total_inc_tax"],
        totalTax: json["total_tax"],
        itemsTotal: json["items_total"],
        itemsShipped: json["items_shipped"],
        paymentMethod: json["payment_method"],
        paymentProviderId: json["payment_provider_id"],
        paymentStatus: json["payment_status"],
        refundedAmount: json["refunded_amount"],
        orderIsDigital: json["order_is_digital"],
        storeCreditAmount: json["store_credit_amount"],
        giftCertificateAmount: json["gift_certificate_amount"],
        ipAddress: json["ip_address"],
        ipAddressV6: json["ip_address_v6"],
        geoipCountry: json["geoip_country"],
        geoipCountryIso2: json["geoip_country_iso2"],
        currencyId: json["currency_id"],
        currencyCode: json["currency_code"],
        currencyExchangeRate: json["currency_exchange_rate"],
        defaultCurrencyId: json["default_currency_id"],
        defaultCurrencyCode: json["default_currency_code"],
        staffNotes: json["staff_notes"],
        customerMessage: json["customer_message"],
        discountAmount: json["discount_amount"],
        couponDiscount: json["coupon_discount"],
        shippingAddressCount: json["shipping_address_count"],
        isDeleted: json["is_deleted"],
        ebayOrderId: json["ebay_order_id"],
        cartId: json["cart_id"],
        billingAddress: json["billing_address"] == null
            ? null
            : BillingAddress.fromJson(json["billing_address"]),
        isEmailOptIn: json["is_email_opt_in"],
        creditCardType: json["credit_card_type"],
        orderSource: json["order_source"],
        dataChannelId: json["channel_id"],
        externalSource: json["external_source"],
        consignments: json["consignments"] == null
            ? null
            : Consignments.fromJson(json["consignments"]),
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
        shippingAddresses: json["shipping_addresses"] == null
            ? null
            : Consignments.fromJson(json["shipping_addresses"]),
        coupons: json["coupons"] == null
            ? null
            : Consignments.fromJson(json["coupons"]),
        externalId: json["external_id"],
        externalMerchantId: json["external_merchant_id"],
        taxProviderId: json["tax_provider_id"],
        customerLocale: json["customer_locale"],
        externalOrderId: json["external_order_id"],
        storeDefaultCurrencyCode: json["store_default_currency_code"],
        storeDefaultToTransactionalExchangeRate:
            json["store_default_to_transactional_exchange_rate"],
        customStatus: json["custom_status"],
        shippingAddress: json["shippingAddress"] == null
            ? []
            : List<ShippingAddress>.from(json["shippingAddress"]!
                .map((x) => ShippingAddress.fromJson(x))),
        shipments: json["shipments"],
        poNumber: json["poNumber"],
        bundleDateModified: json["bundle_date_modified"],
        bundleDateCreated: json["bundle_date_created"],
        money: json["money"] == null ? null : Money.fromJson(json["money"]),
        referenceNumber: json["referenceNumber"],
        isInvoiceOrder: json["isInvoiceOrder"],
        extraInt2: json["extraInt2"],
        extraInt3: json["extraInt3"],
        extraInt4: json["extraInt4"],
        extraInt5: json["extraInt5"],
        extraStr1: json["extraStr1"],
        extraStr2: json["extraStr2"],
        extraStr3: json["extraStr3"],
        extraStr4: json["extraStr4"],
        extraStr5: json["extraStr5"],
        extraText: json["extraText"],
        extraInfo: json["extraInfo"],
        channelId: json["channelId"],
        channelName: json["channelName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "date_created": dateCreated,
        "date_modified": dateModified,
        "date_shipped": dateShipped,
        "status_id": statusId,
        "status": status,
        "subtotal_ex_tax": subtotalExTax,
        "subtotal_inc_tax": subtotalIncTax,
        "subtotal_tax": subtotalTax,
        "base_shipping_cost": baseShippingCost,
        "shipping_cost_ex_tax": shippingCostExTax,
        "shipping_cost_inc_tax": shippingCostIncTax,
        "shipping_cost_tax": shippingCostTax,
        "shipping_cost_tax_class_id": shippingCostTaxClassId,
        "base_handling_cost": baseHandlingCost,
        "handling_cost_ex_tax": handlingCostExTax,
        "handling_cost_inc_tax": handlingCostIncTax,
        "handling_cost_tax": handlingCostTax,
        "handling_cost_tax_class_id": handlingCostTaxClassId,
        "base_wrapping_cost": baseWrappingCost,
        "wrapping_cost_ex_tax": wrappingCostExTax,
        "wrapping_cost_inc_tax": wrappingCostIncTax,
        "wrapping_cost_tax": wrappingCostTax,
        "wrapping_cost_tax_class_id": wrappingCostTaxClassId,
        "total_ex_tax": totalExTax,
        "total_inc_tax": totalIncTax,
        "total_tax": totalTax,
        "items_total": itemsTotal,
        "items_shipped": itemsShipped,
        "payment_method": paymentMethod,
        "payment_provider_id": paymentProviderId,
        "payment_status": paymentStatus,
        "refunded_amount": refundedAmount,
        "order_is_digital": orderIsDigital,
        "store_credit_amount": storeCreditAmount,
        "gift_certificate_amount": giftCertificateAmount,
        "ip_address": ipAddress,
        "ip_address_v6": ipAddressV6,
        "geoip_country": geoipCountry,
        "geoip_country_iso2": geoipCountryIso2,
        "currency_id": currencyId,
        "currency_code": currencyCode,
        "currency_exchange_rate": currencyExchangeRate,
        "default_currency_id": defaultCurrencyId,
        "default_currency_code": defaultCurrencyCode,
        "staff_notes": staffNotes,
        "customer_message": customerMessage,
        "discount_amount": discountAmount,
        "coupon_discount": couponDiscount,
        "shipping_address_count": shippingAddressCount,
        "is_deleted": isDeleted,
        "ebay_order_id": ebayOrderId,
        "cart_id": cartId,
        "billing_address": billingAddress?.toJson(),
        "is_email_opt_in": isEmailOptIn,
        "credit_card_type": creditCardType,
        "order_source": orderSource,
        "channel_id": dataChannelId,
        "external_source": externalSource,
        "consignments": consignments?.toJson(),
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "shipping_addresses": shippingAddresses?.toJson(),
        "coupons": coupons?.toJson(),
        "external_id": externalId,
        "external_merchant_id": externalMerchantId,
        "tax_provider_id": taxProviderId,
        "customer_locale": customerLocale,
        "external_order_id": externalOrderId,
        "store_default_currency_code": storeDefaultCurrencyCode,
        "store_default_to_transactional_exchange_rate":
            storeDefaultToTransactionalExchangeRate,
        "custom_status": customStatus,
        "shippingAddress": shippingAddress == null
            ? []
            : List<dynamic>.from(shippingAddress!.map((x) => x.toJson())),
        "shipments": shipments,
        "poNumber": poNumber,
        "bundle_date_modified": bundleDateModified,
        "bundle_date_created": bundleDateCreated,
        "money": money?.toJson(),
        "referenceNumber": referenceNumber,
        "isInvoiceOrder": isInvoiceOrder,
        "extraInt2": extraInt2,
        "extraInt3": extraInt3,
        "extraInt4": extraInt4,
        "extraInt5": extraInt5,
        "extraStr1": extraStr1,
        "extraStr2": extraStr2,
        "extraStr3": extraStr3,
        "extraStr4": extraStr4,
        "extraStr5": extraStr5,
        "extraText": extraText,
        "extraInfo": extraInfo,
        "channelId": channelId,
        "channelName": channelName,
      };
}

class BillingAddress {
  String? firstName;
  String? lastName;
  String? company;
  String? street1;
  String? street2;
  String? city;
  String? state;
  String? zip;
  String? country;
  String? countryIso2;
  String? phone;
  String? email;
  List<dynamic>? formFields;

  BillingAddress({
    this.firstName,
    this.lastName,
    this.company,
    this.street1,
    this.street2,
    this.city,
    this.state,
    this.zip,
    this.country,
    this.countryIso2,
    this.phone,
    this.email,
    this.formFields,
  });

  factory BillingAddress.fromJson(Map<String, dynamic> json) => BillingAddress(
        firstName: json["first_name"],
        lastName: json["last_name"],
        company: json["company"],
        street1: json["street_1"],
        street2: json["street_2"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        country: json["country"],
        countryIso2: json["country_iso2"],
        phone: json["phone"],
        email: json["email"],
        formFields: json["form_fields"] == null
            ? []
            : List<dynamic>.from(json["form_fields"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "company": company,
        "street_1": street1,
        "street_2": street2,
        "city": city,
        "state": state,
        "zip": zip,
        "country": country,
        "country_iso2": countryIso2,
        "phone": phone,
        "email": email,
        "form_fields": formFields == null
            ? []
            : List<dynamic>.from(formFields!.map((x) => x)),
      };
}

class Consignments {
  String? url;
  String? resource;

  Consignments({
    this.url,
    this.resource,
  });

  factory Consignments.fromJson(Map<String, dynamic> json) => Consignments(
        url: json["url"],
        resource: json["resource"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "resource": resource,
      };
}

class Money {
  String? currencyLocation;
  String? currencyToken;
  String? decimalToken;
  int? decimalPlaces;
  String? thousandsToken;

  Money({
    this.currencyLocation,
    this.currencyToken,
    this.decimalToken,
    this.decimalPlaces,
    this.thousandsToken,
  });

  factory Money.fromJson(Map<String, dynamic> json) => Money(
        currencyLocation: json["currency_location"],
        currencyToken: json["currency_token"],
        decimalToken: json["decimal_token"],
        decimalPlaces: json["decimal_places"],
        thousandsToken: json["thousands_token"],
      );

  Map<String, dynamic> toJson() => {
        "currency_location": currencyLocation,
        "currency_token": currencyToken,
        "decimal_token": decimalToken,
        "decimal_places": decimalPlaces,
        "thousands_token": thousandsToken,
      };
}

class Product {
  int? id;
  int? orderId;
  int? productId;
  int? variantId;
  int? orderPickupMethodId;
  int? orderAddressId;
  String? name;
  String? nameCustomer;
  String? nameMerchant;
  String? sku;
  String? upc;
  String? type;
  String? basePrice;
  String? priceExTax;
  String? priceIncTax;
  String? priceTax;
  String? baseTotal;
  String? totalExTax;
  String? totalIncTax;
  String? totalTax;
  String? weight;
  String? width;
  String? height;
  String? depth;
  int? quantity;
  String? baseCostPrice;
  String? costPriceIncTax;
  String? costPriceExTax;
  String? costPriceTax;
  bool? isRefunded;
  int? quantityRefunded;
  String? refundAmount;
  int? returnId;
  int? wrappingId;
  String? wrappingName;
  String? baseWrappingCost;
  String? wrappingCostExTax;
  String? wrappingCostIncTax;
  String? wrappingCostTax;
  String? wrappingMessage;
  int? quantityShipped;
  dynamic eventName;
  dynamic eventDate;
  String? fixedShippingCost;
  String? ebayItemId;
  String? ebayTransactionId;
  int? optionSetId;
  dynamic parentOrderProductId;
  bool? isBundledProduct;
  String? binPickingNumber;
  String? externalId;
  String? fulfillmentSource;
  String? brand;
  dynamic giftCertificateId;
  List<dynamic>? appliedDiscounts;
  List<ProductOption>? productOptions;
  List<dynamic>? configurableFields;
  String? discountedTotalIncTax;

  Product({
    this.id,
    this.orderId,
    this.productId,
    this.variantId,
    this.orderPickupMethodId,
    this.orderAddressId,
    this.name,
    this.nameCustomer,
    this.nameMerchant,
    this.sku,
    this.upc,
    this.type,
    this.basePrice,
    this.priceExTax,
    this.priceIncTax,
    this.priceTax,
    this.baseTotal,
    this.totalExTax,
    this.totalIncTax,
    this.totalTax,
    this.weight,
    this.width,
    this.height,
    this.depth,
    this.quantity,
    this.baseCostPrice,
    this.costPriceIncTax,
    this.costPriceExTax,
    this.costPriceTax,
    this.isRefunded,
    this.quantityRefunded,
    this.refundAmount,
    this.returnId,
    this.wrappingId,
    this.wrappingName,
    this.baseWrappingCost,
    this.wrappingCostExTax,
    this.wrappingCostIncTax,
    this.wrappingCostTax,
    this.wrappingMessage,
    this.quantityShipped,
    this.eventName,
    this.eventDate,
    this.fixedShippingCost,
    this.ebayItemId,
    this.ebayTransactionId,
    this.optionSetId,
    this.parentOrderProductId,
    this.isBundledProduct,
    this.binPickingNumber,
    this.externalId,
    this.fulfillmentSource,
    this.brand,
    this.giftCertificateId,
    this.appliedDiscounts,
    this.productOptions,
    this.configurableFields,
    this.discountedTotalIncTax,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        variantId: json["variant_id"],
        orderPickupMethodId: json["order_pickup_method_id"],
        orderAddressId: json["order_address_id"],
        name: json["name"],
        nameCustomer: json["name_customer"],
        nameMerchant: json["name_merchant"],
        sku: json["sku"],
        upc: json["upc"],
        type: json["type"],
        basePrice: json["base_price"],
        priceExTax: json["price_ex_tax"],
        priceIncTax: json["price_inc_tax"],
        priceTax: json["price_tax"],
        baseTotal: json["base_total"],
        totalExTax: json["total_ex_tax"],
        totalIncTax: json["total_inc_tax"],
        totalTax: json["total_tax"],
        weight: json["weight"],
        width: json["width"],
        height: json["height"],
        depth: json["depth"],
        quantity: json["quantity"],
        baseCostPrice: json["base_cost_price"],
        costPriceIncTax: json["cost_price_inc_tax"],
        costPriceExTax: json["cost_price_ex_tax"],
        costPriceTax: json["cost_price_tax"],
        isRefunded: json["is_refunded"],
        quantityRefunded: json["quantity_refunded"],
        refundAmount: json["refund_amount"],
        returnId: json["return_id"],
        wrappingId: json["wrapping_id"],
        wrappingName: json["wrapping_name"],
        baseWrappingCost: json["base_wrapping_cost"],
        wrappingCostExTax: json["wrapping_cost_ex_tax"],
        wrappingCostIncTax: json["wrapping_cost_inc_tax"],
        wrappingCostTax: json["wrapping_cost_tax"],
        wrappingMessage: json["wrapping_message"],
        quantityShipped: json["quantity_shipped"],
        eventName: json["event_name"],
        eventDate: json["event_date"],
        fixedShippingCost: json["fixed_shipping_cost"],
        ebayItemId: json["ebay_item_id"],
        ebayTransactionId: json["ebay_transaction_id"],
        optionSetId: json["option_set_id"],
        parentOrderProductId: json["parent_order_product_id"],
        isBundledProduct: json["is_bundled_product"],
        binPickingNumber: json["bin_picking_number"],
        externalId: json["external_id"],
        fulfillmentSource: json["fulfillment_source"],
        brand: json["brand"],
        giftCertificateId: json["gift_certificate_id"],
        appliedDiscounts: json["applied_discounts"] == null
            ? []
            : List<dynamic>.from(json["applied_discounts"]!.map((x) => x)),
        productOptions: json["product_options"] == null
            ? []
            : List<ProductOption>.from(
                json["product_options"]!.map((x) => ProductOption.fromJson(x))),
        configurableFields: json["configurable_fields"] == null
            ? []
            : List<dynamic>.from(json["configurable_fields"]!.map((x) => x)),
        discountedTotalIncTax: json["discounted_total_inc_tax"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "variant_id": variantId,
        "order_pickup_method_id": orderPickupMethodId,
        "order_address_id": orderAddressId,
        "name": name,
        "name_customer": nameCustomer,
        "name_merchant": nameMerchant,
        "sku": sku,
        "upc": upc,
        "type": type,
        "base_price": basePrice,
        "price_ex_tax": priceExTax,
        "price_inc_tax": priceIncTax,
        "price_tax": priceTax,
        "base_total": baseTotal,
        "total_ex_tax": totalExTax,
        "total_inc_tax": totalIncTax,
        "total_tax": totalTax,
        "weight": weight,
        "width": width,
        "height": height,
        "depth": depth,
        "quantity": quantity,
        "base_cost_price": baseCostPrice,
        "cost_price_inc_tax": costPriceIncTax,
        "cost_price_ex_tax": costPriceExTax,
        "cost_price_tax": costPriceTax,
        "is_refunded": isRefunded,
        "quantity_refunded": quantityRefunded,
        "refund_amount": refundAmount,
        "return_id": returnId,
        "wrapping_id": wrappingId,
        "wrapping_name": wrappingName,
        "base_wrapping_cost": baseWrappingCost,
        "wrapping_cost_ex_tax": wrappingCostExTax,
        "wrapping_cost_inc_tax": wrappingCostIncTax,
        "wrapping_cost_tax": wrappingCostTax,
        "wrapping_message": wrappingMessage,
        "quantity_shipped": quantityShipped,
        "event_name": eventName,
        "event_date": eventDate,
        "fixed_shipping_cost": fixedShippingCost,
        "ebay_item_id": ebayItemId,
        "ebay_transaction_id": ebayTransactionId,
        "option_set_id": optionSetId,
        "parent_order_product_id": parentOrderProductId,
        "is_bundled_product": isBundledProduct,
        "bin_picking_number": binPickingNumber,
        "external_id": externalId,
        "fulfillment_source": fulfillmentSource,
        "brand": brand,
        "gift_certificate_id": giftCertificateId,
        "applied_discounts": appliedDiscounts == null
            ? []
            : List<dynamic>.from(appliedDiscounts!.map((x) => x)),
        "product_options": productOptions == null
            ? []
            : List<dynamic>.from(productOptions!.map((x) => x.toJson())),
        "configurable_fields": configurableFields == null
            ? []
            : List<dynamic>.from(configurableFields!.map((x) => x)),
        "discounted_total_inc_tax": discountedTotalIncTax,
      };
}

class ProductOption {
  int? id;
  int? optionId;
  int? orderProductId;
  int? productOptionId;
  String? displayName;
  String? displayNameCustomer;
  String? displayNameMerchant;
  String? displayValue;
  String? displayValueCustomer;
  String? displayValueMerchant;
  String? value;
  String? type;
  String? name;
  String? displayStyle;

  ProductOption({
    this.id,
    this.optionId,
    this.orderProductId,
    this.productOptionId,
    this.displayName,
    this.displayNameCustomer,
    this.displayNameMerchant,
    this.displayValue,
    this.displayValueCustomer,
    this.displayValueMerchant,
    this.value,
    this.type,
    this.name,
    this.displayStyle,
  });

  factory ProductOption.fromJson(Map<String, dynamic> json) => ProductOption(
        id: json["id"],
        optionId: json["option_id"],
        orderProductId: json["order_product_id"],
        productOptionId: json["product_option_id"],
        displayName: json["display_name"],
        displayNameCustomer: json["display_name_customer"],
        displayNameMerchant: json["display_name_merchant"],
        displayValue: json["display_value"],
        displayValueCustomer: json["display_value_customer"],
        displayValueMerchant: json["display_value_merchant"],
        value: json["value"],
        type: json["type"],
        name: json["name"],
        displayStyle: json["display_style"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "option_id": optionId,
        "order_product_id": orderProductId,
        "product_option_id": productOptionId,
        "display_name": displayName,
        "display_name_customer": displayNameCustomer,
        "display_name_merchant": displayNameMerchant,
        "display_value": displayValue,
        "display_value_customer": displayValueCustomer,
        "display_value_merchant": displayValueMerchant,
        "value": value,
        "type": type,
        "name": name,
        "display_style": displayStyle,
      };
}

class ShippingAddress {
  int? id;
  int? orderId;
  String? firstName;
  String? lastName;
  String? company;
  String? street1;
  String? street2;
  String? city;
  String? zip;
  String? country;
  String? countryIso2;
  String? state;
  String? email;
  String? phone;
  int? itemsTotal;
  int? itemsShipped;
  String? shippingMethod;
  String? baseCost;
  String? costExTax;
  String? costIncTax;
  String? costTax;
  int? costTaxClassId;
  String? baseHandlingCost;
  String? handlingCostExTax;
  String? handlingCostIncTax;
  String? handlingCostTax;
  int? handlingCostTaxClassId;
  int? shippingZoneId;
  String? shippingZoneName;
  Consignments? shippingQuotes;
  List<dynamic>? formFields;

  ShippingAddress({
    this.id,
    this.orderId,
    this.firstName,
    this.lastName,
    this.company,
    this.street1,
    this.street2,
    this.city,
    this.zip,
    this.country,
    this.countryIso2,
    this.state,
    this.email,
    this.phone,
    this.itemsTotal,
    this.itemsShipped,
    this.shippingMethod,
    this.baseCost,
    this.costExTax,
    this.costIncTax,
    this.costTax,
    this.costTaxClassId,
    this.baseHandlingCost,
    this.handlingCostExTax,
    this.handlingCostIncTax,
    this.handlingCostTax,
    this.handlingCostTaxClassId,
    this.shippingZoneId,
    this.shippingZoneName,
    this.shippingQuotes,
    this.formFields,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        id: json["id"],
        orderId: json["order_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        company: json["company"],
        street1: json["street_1"],
        street2: json["street_2"],
        city: json["city"],
        zip: json["zip"],
        country: json["country"],
        countryIso2: json["country_iso2"],
        state: json["state"],
        email: json["email"],
        phone: json["phone"],
        itemsTotal: json["items_total"],
        itemsShipped: json["items_shipped"],
        shippingMethod: json["shipping_method"],
        baseCost: json["base_cost"],
        costExTax: json["cost_ex_tax"],
        costIncTax: json["cost_inc_tax"],
        costTax: json["cost_tax"],
        costTaxClassId: json["cost_tax_class_id"],
        baseHandlingCost: json["base_handling_cost"],
        handlingCostExTax: json["handling_cost_ex_tax"],
        handlingCostIncTax: json["handling_cost_inc_tax"],
        handlingCostTax: json["handling_cost_tax"],
        handlingCostTaxClassId: json["handling_cost_tax_class_id"],
        shippingZoneId: json["shipping_zone_id"],
        shippingZoneName: json["shipping_zone_name"],
        shippingQuotes: json["shipping_quotes"] == null
            ? null
            : Consignments.fromJson(json["shipping_quotes"]),
        formFields: json["form_fields"] == null
            ? []
            : List<dynamic>.from(json["form_fields"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "first_name": firstName,
        "last_name": lastName,
        "company": company,
        "street_1": street1,
        "street_2": street2,
        "city": city,
        "zip": zip,
        "country": country,
        "country_iso2": countryIso2,
        "state": state,
        "email": email,
        "phone": phone,
        "items_total": itemsTotal,
        "items_shipped": itemsShipped,
        "shipping_method": shippingMethod,
        "base_cost": baseCost,
        "cost_ex_tax": costExTax,
        "cost_inc_tax": costIncTax,
        "cost_tax": costTax,
        "cost_tax_class_id": costTaxClassId,
        "base_handling_cost": baseHandlingCost,
        "handling_cost_ex_tax": handlingCostExTax,
        "handling_cost_inc_tax": handlingCostIncTax,
        "handling_cost_tax": handlingCostTax,
        "handling_cost_tax_class_id": handlingCostTaxClassId,
        "shipping_zone_id": shippingZoneId,
        "shipping_zone_name": shippingZoneName,
        "shipping_quotes": shippingQuotes?.toJson(),
        "form_fields": formFields == null
            ? []
            : List<dynamic>.from(formFields!.map((x) => x)),
      };
}
