import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';

class Urls {
  String  v3baseUrl =
      "https://api.bigcommerce.com/stores/${SpUtil.getString(SpConstUtil.storeHashValue)}/v3/";
  String v2baseUrl =
      "https://api.bigcommerce.com/stores/${SpUtil.getString(SpConstUtil.storeHashValue)}/v2/";
  String loginbaseUrl = "https://api-b2b.bigcommerce.com/api/io/auth/";
  String storesbaseUrl =
      "https://api.bigcommerce.com/stores/${SpUtil.getString(SpConstUtil.storeHashValue)}/v3/catalog/";
  String companyB2BbaseUrl =
      "https://api-b2b.bigcommerce.com/api/v3/io/companies";
  String homeBannerbaseUrl =
      "https://hunkssmoke.net/wp-json/astha_dar/v1/mobile-banner/";
  String companybaseUrl = "https://api-b2b.bigcommerce.com/api/v3/io/companies";
  String categories = "categories";
  String treescategories = "trees/1/categories";
  String catalogtrees = "catalog/trees/";
  String catalogproducts = "catalog/products";
  String customers = "customers";
  String brands = "brands";
  String products = "products";
  String carts = "carts";
  String orders = "orders";
  String items = "items";
  String addresses = "addresses";
  String validateCredentials = "validate-credentials";
  String pricelistAssignments = "pricelists/assignments";
  String checkouts = "checkouts";
  String wishlists = "wishlists";
  String pricelists = "pricelists";
  String consignments = "consignments";
  String billingaddress = "billing-address";
  String status = "status";
}

Urls urls = Urls();
