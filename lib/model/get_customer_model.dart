import 'dart:convert';

GetCustomerModel getCustomerModelFromJson(String str) =>
    GetCustomerModel.fromJson(json.decode(str));

String getCustomerModelToJson(GetCustomerModel data) =>
    json.encode(data.toJson());

class GetCustomerModel {
  List<Datum>? data;
  Meta? meta;

  GetCustomerModel({
    this.data,
    this.meta,
  });

  factory GetCustomerModel.fromJson(Map<String, dynamic> json) =>
      GetCustomerModel(
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
  int? addressCount;
  List<Address>? addresses;
  List<dynamic>? attributes;
  Authentication? authentication;
  String? company;
  int? customerGroupId;
  String? email;
  String? firstName;
  String? lastName;
  String? notes;
  String? phone;
  String? registrationIpAddress;
  String? taxExemptCategory;
  DateTime? dateCreated;
  DateTime? dateModified;
  int? attributeCount;
  bool? acceptsProductReviewAbandonedCartEmails;
  int? originChannelId;
  dynamic channelIds;
  Consent? consent;

  Datum({
    this.id,
    this.addressCount,
    this.addresses,
    this.attributes,
    this.authentication,
    this.company,
    this.customerGroupId,
    this.email,
    this.firstName,
    this.lastName,
    this.notes,
    this.phone,
    this.registrationIpAddress,
    this.taxExemptCategory,
    this.dateCreated,
    this.dateModified,
    this.attributeCount,
    this.acceptsProductReviewAbandonedCartEmails,
    this.originChannelId,
    this.channelIds,
    this.consent,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        addressCount: json["address_count"],
        addresses: json["addresses"] == null
            ? []
            : List<Address>.from(
                json["addresses"]!.map((x) => Address.fromJson(x))),
        attributes: json["attributes"] == null
            ? []
            : List<dynamic>.from(json["attributes"]!.map((x) => x)),
        authentication: json["authentication"] == null
            ? null
            : Authentication.fromJson(json["authentication"]),
        company: json["company"],
        customerGroupId: json["customer_group_id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        notes: json["notes"],
        phone: json["phone"],
        registrationIpAddress: json["registration_ip_address"],
        taxExemptCategory: json["tax_exempt_category"],
        dateCreated: json["date_created"] == null
            ? null
            : DateTime.parse(json["date_created"]),
        dateModified: json["date_modified"] == null
            ? null
            : DateTime.parse(json["date_modified"]),
        attributeCount: json["attribute_count"],
        acceptsProductReviewAbandonedCartEmails:
            json["accepts_product_review_abandoned_cart_emails"],
        originChannelId: json["origin_channel_id"],
        channelIds: json["channel_ids"],
        consent:
            json["consent"] == null ? null : Consent.fromJson(json["consent"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address_count": addressCount,
        "addresses": addresses == null
            ? []
            : List<dynamic>.from(addresses!.map((x) => x.toJson())),
        "attributes": attributes == null
            ? []
            : List<dynamic>.from(attributes!.map((x) => x)),
        "authentication": authentication?.toJson(),
        "company": company,
        "customer_group_id": customerGroupId,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "notes": notes,
        "phone": phone,
        "registration_ip_address": registrationIpAddress,
        "tax_exempt_category": taxExemptCategory,
        "date_created": dateCreated?.toIso8601String(),
        "date_modified": dateModified?.toIso8601String(),
        "attribute_count": attributeCount,
        "accepts_product_review_abandoned_cart_emails":
            acceptsProductReviewAbandonedCartEmails,
        "origin_channel_id": originChannelId,
        "channel_ids": channelIds,
        "consent": consent?.toJson(),
      };
}

class Address {
  int? id;
  String? address1;
  String? address2;
  String? addressType;
  String? city;
  String? company;
  String? country;
  String? countryCode;
  int? customerId;
  String? firstName;
  String? lastName;
  String? phone;
  String? postalCode;
  String? stateOrProvince;

  Address({
    this.id,
    this.address1,
    this.address2,
    this.addressType,
    this.city,
    this.company,
    this.country,
    this.countryCode,
    this.customerId,
    this.firstName,
    this.lastName,
    this.phone,
    this.postalCode,
    this.stateOrProvince,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        address1: json["address1"],
        address2: json["address2"],
        addressType: json["address_type"],
        city: json["city"],
        company: json["company"],
        country: json["country"],
        countryCode: json["country_code"],
        customerId: json["customer_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        postalCode: json["postal_code"],
        stateOrProvince: json["state_or_province"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address1": address1,
        "address2": address2,
        "address_type": addressType,
        "city": city,
        "company": company,
        "country": country,
        "country_code": countryCode,
        "customer_id": customerId,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "postal_code": postalCode,
        "state_or_province": stateOrProvince,
      };
}

class Authentication {
  bool? forcePasswordReset;

  Authentication({
    this.forcePasswordReset,
  });

  factory Authentication.fromJson(Map<String, dynamic> json) => Authentication(
        forcePasswordReset: json["force_password_reset"],
      );

  Map<String, dynamic> toJson() => {
        "force_password_reset": forcePasswordReset,
      };
}

class Consent {
  List<String>? allow;
  List<dynamic>? deny;

  Consent({
    this.allow,
    this.deny,
  });

  factory Consent.fromJson(Map<String, dynamic> json) => Consent(
        allow: json["allow"] == null
            ? []
            : List<String>.from(json["allow"]!.map((x) => x)),
        deny: json["deny"] == null
            ? []
            : List<dynamic>.from(json["deny"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "allow": allow == null ? [] : List<dynamic>.from(allow!.map((x) => x)),
        "deny": deny == null ? [] : List<dynamic>.from(deny!.map((x) => x)),
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

  Pagination({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        count: json["count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "count": count,
        "per_page": perPage,
        "current_page": currentPage,
        "total_pages": totalPages,
      };
}
