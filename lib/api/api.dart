// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:adyah_wholesale/bloc/cart_all_data_bloc.dart';
import 'package:adyah_wholesale/bloc/category_bloc.dart';
import 'package:adyah_wholesale/bloc/featured_product_bloc.dart';
import 'package:adyah_wholesale/bloc/get_blog_bloc.dart';
import 'package:adyah_wholesale/bloc/get_brands_bloc.dart';
import 'package:adyah_wholesale/bloc/get_customer_bloc.dart';
import 'package:adyah_wholesale/bloc/get_my_orders_bloc.dart';
import 'package:adyah_wholesale/bloc/get_order_products_bloc.dart';
import 'package:adyah_wholesale/bloc/get_wish_list_bloc.dart';
import 'package:adyah_wholesale/bloc/home_banner_bloc.dart';
import 'package:adyah_wholesale/bloc/parent_category_bloc.dart';
import 'package:adyah_wholesale/bloc/productsainategory_bloc.dart';
import 'package:adyah_wholesale/components/check_internet/check_internet.dart';
import 'package:adyah_wholesale/components/indicator/indicator.dart';
import 'package:adyah_wholesale/components/shared_prefs/shared_prefs.dart';
import 'package:adyah_wholesale/components/text_component/text.dart';
import 'package:adyah_wholesale/global/global.dart';
import 'package:adyah_wholesale/model/billing_checkout_model.dart';
import 'package:adyah_wholesale/model/cart_data_model.dart';
import 'package:adyah_wholesale/model/category_model.dart';
import 'package:adyah_wholesale/model/checkout_consignments_update_model.dart';
import 'package:adyah_wholesale/model/consignments_model.dart';
import 'package:adyah_wholesale/model/get_all_brands_model.dart';
import 'package:adyah_wholesale/model/get_blog_model.dart';
import 'package:adyah_wholesale/model/get_customer_model.dart';
import 'package:adyah_wholesale/model/get_my_order_details_model.dart';
import 'package:adyah_wholesale/model/get_my_orders_model.dart';
import 'package:adyah_wholesale/model/get_order_product_model.dart';
import 'package:adyah_wholesale/model/get_wish_list_model.dart';
import 'package:adyah_wholesale/model/home_banner_model.dart';
import 'package:adyah_wholesale/model/latest_product_model.dart';
import 'package:adyah_wholesale/model/new_products_model.dart';
import 'package:adyah_wholesale/model/parent_category_model.dart';
import 'package:adyah_wholesale/model/pricelist_model.dart';
import 'package:adyah_wholesale/model/products_category_model.dart';
import 'package:adyah_wholesale/model/all_featured_products_model.dart';
import 'package:adyah_wholesale/screens/authentication/login_screen.dart';
import 'package:adyah_wholesale/screens/bottom_navigation_bar.dart';
import 'package:adyah_wholesale/api/urls.dart';
import 'package:adyah_wholesale/screens/cart_screen/payment_screen.dart';
import 'package:adyah_wholesale/screens/cart_screen/shipping_address_screen.dart';
import 'package:adyah_wholesale/screens/orderplaced/orderplaced.dart';
import 'package:adyah_wholesale/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:adyah_wholesale/model/sub_category_modell.dart';

class Apis {
  showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: colors.blackcolor,
        textColor: colors.whitecolor,
        fontSize: 16.0);
  }

  void calculateTotalQuantity(
      CartDataModel cartData, StateSetter setState) async {
    double totalQuantity = 0;

    if (cartData.data != null &&
        cartData.data!.lineItems != null &&
        cartData.data!.lineItems!.physicalItems != null) {
      for (var item in cartData.data!.lineItems!.physicalItems!) {
        setState(() {
          totalQuantity += item.quantity!;
        });
      }
    }

    await SpUtil.putDouble(SpConstUtil.totalqty, totalQuantity);
  }

  Future<Object?> accountDeleteDialog(ProgressLoader pl, BuildContext context,
      String value, VoidCallback toggleTheme) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                content: const Text(
                  'Please wait at least 24 hours for approval. Check on this page for the approval status.',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: "OpenSans"),
                  textAlign: TextAlign.center,
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      value == "login"
                          ? Navigator.pop(context)
                          : Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) =>
                                    LoginScreen(toggleTheme: toggleTheme),
                              ),
                              (route) => false,
                            );
                    },
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colors.themebluecolor,
                          border: Border.all(color: colors.themebluecolor)),
                      child: Center(
                          child: text("OK",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: colors.whitecolor)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }

  createUserApi(
      String email,
      String firstName,
      String lastName,
      String company,
      String phone,
      String address1,
      String address2,
      String city,
      String password,
      String postalCode,
      String state,
      String countryCode,
      ProgressLoader pl,
      BuildContext context,
      VoidCallback toggleTheme) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'Content-Type': 'application/json'
        };
        var request =
            http.Request('POST', Uri.parse(urls.v3baseUrl + urls.customers));

        request.body = json.encode([
          {
            "email": email,
            "first_name": firstName,
            "last_name": lastName,
            "company": company,
            "phone": phone,
            "notes": "string",
            "tax_exempt_category": "string",
            "customer_group_id": 0,
            "addresses": [
              {
                "address1": address1,
                "address2": address2,
                "address_type": "residential",
                "city": city,
                "company": company,
                "country_code": countryCode,
                "first_name": firstName,
                "last_name": lastName,
                "phone": phone,
                "postal_code": postalCode,
                "state_or_province": state,
                "form_fields": [
                  {"name": "test", "value": "test"}
                ]
              }
            ],
            "authentication": {
              "force_password_reset": false,
              "new_password": password
            },
            "accepts_product_review_abandoned_cart_emails": true,
            "store_credit_amounts": [
              {"amount": 0.0}
            ],
            "origin_channel_id": 1,
            "channel_ids": [1],
            "form_fields": [
              {"name": "test", "value": "test"}
            ]
          }
        ]);
        debugPrint(
            "***====== createUserApi request.body ======*** ${request.body}\n");

        request.headers.addAll(headers);
        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== createUserApi response.body ======*** ${response.body}\n");
        if (response.statusCode == 200) {
          debugPrint(
              "***====== 200 createUserApi response.body ======*** ${response.body}\n");

          await apis.registerApi(
              company,
              phone,
              email,
              jsonDecode(response.body)['data'][0]['addresses'][0]['address1'],
              jsonDecode(response.body)['data'][0]['addresses'][0]['address2'],
              jsonDecode(response.body)['data'][0]['addresses'][0]['city'],
              jsonDecode(response.body)['data'][0]['addresses'][0]['company'],
              jsonDecode(response.body)['data'][0]['addresses'][0]['country'],
              jsonDecode(response.body)['data'][0]['addresses'][0]
                  ['postal_code'],
              jsonDecode(response.body)['data'][0]['addresses'][0]
                  ['first_name'],
              jsonDecode(response.body)['data'][0]['addresses'][0]['last_name'],
              jsonDecode(response.body)['data'][0]['email'],
              jsonDecode(response.body)['data'][0]['phone'],
              pl,
              context,
              toggleTheme);
        } else if (response.statusCode == 422) {
          await pl.hide();

          await showToast(jsonDecode(response.body)['errors'].toString());
        } else if (response.statusCode == 413) {
          await pl.hide();
          await showToast(
              "The request payload is too large. The maximum number of items allowed in the array is 10.");
        } else {
          await pl.hide();

          debugPrint(
              "***====== createUserApi not 200 ======*** ${response.reasonPhrase}");
          await showToast(commonData.error);
        }
      } catch (e) {
        await pl.hide();

        await showToast(commonData.error);
      }
    } else {
      await pl.hide();

      await showToast(commonData.noInternet);
    }
  }

  registerApi(
      String companyName,
      String companyPhone,
      String companyEmail,
      String addressLine1,
      String addressLine2,
      String city,
      String state,
      String country,
      String zipCode,
      String adminFirstName,
      String adminLastName,
      String adminEmail,
      String adminPhoneNumber,
      ProgressLoader pl,
      BuildContext context,
      VoidCallback toggleTheme) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'Authtoken': '${SpUtil.getString(SpConstUtil.authTokenV3)}',
          'client_id': '${SpUtil.getString(SpConstUtil.clientId)}',
          'client_secret': '${SpUtil.getString(SpConstUtil.clientSecret)}',
          'store_hash': '${SpUtil.getString(SpConstUtil.storeHashValue)}',
          'Content-Type': 'application/json'
        };
        var request = http.Request('POST', Uri.parse(urls.companybaseUrl));
        request.body = json.encode({
          "companyName": companyName,
          "companyPhone": companyPhone,
          "companyEmail": companyEmail,
          "addressLine1": addressLine1,
          "addressLine2": addressLine2,
          "city": city,
          "state": state,
          "country": country,
          "zipCode": zipCode,
          "adminFirstName": adminFirstName,
          "adminLastName": adminLastName,
          "adminEmail": adminEmail,
          "adminPhoneNumber": adminPhoneNumber,
          "catalogId": 0,
          "companyStatus": 0,
          "acceptCreationEmail": false,
          "extraFields": [
            {"fieldName": "string", "fieldValue": "string"}
          ],
          "uuid": "string",
          "channelIds": [1, 2],
          "originChannelId": 1
        });
        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== registerApi response.body ======*** ${response.body}\n");
        if (response.statusCode == 200) {
          debugPrint(
              "***====== registerApi response.body ======*** ${response.body}\n");

          await updateStatus(jsonDecode(response.body)['data']['companyId'], 0,
              pl, context, toggleTheme);
        } else if (response.statusCode == 413) {
          await pl.hide();

          await showToast(
              "The request payload is too large. The maximum number of items allowed in the array is 10.");
        } else if (response.statusCode == 422) {
          await pl.hide();

          await showToast(jsonDecode(response.body)['errors'].toString());
        } else {
          await pl.hide();
          await showToast(commonData.error);
          debugPrint(
              "***====== registerApi not 200 ======*** ${response.reasonPhrase}");
        }
      } catch (e) {
        await pl.hide();
        await showToast(commonData.error);
      }
    } else {
      await pl.hide();
      await showToast(commonData.noInternet);
    }
  }

  updateStatus(int companyID, int companyStatus, ProgressLoader pl,
      BuildContext context, VoidCallback toggleTheme) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'Authtoken': '${SpUtil.getString(SpConstUtil.authTokenV3)}',
          'Content-Type': 'application/json'
        };
        var request = http.Request(
            'PUT',
            Uri.parse(
              '${urls.companybaseUrl}/$companyID/${urls.status}',
            ));
        request.body = json.encode({"companyStatus": companyStatus});
        request.headers.addAll(headers);
        http.Response response =
            await http.Response.fromStream(await request.send());

        if (response.statusCode == 200) {
          await pl.hide();
          await showToast("Account Create Successfully...");
          await accountDeleteDialog(pl, context, "register", toggleTheme);
        } else {
          await pl.hide();

          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();

        await showToast(commonData.error);
      }
    } else {
      await pl.hide();

      await showToast(commonData.noInternet);
    }
  }

  loginUserApi(
      String email,
      String password,
      ProgressLoader pl,
      BuildContext context,
      VoidCallback toggleTheme,
      StateSetter setState) async {
    bool internet = await checkInternet();
    if (internet) {
      debugPrint(
          "=== SpUtil.getString(SpConstUtil.storeHashValue) ====>${SpUtil.getString(SpConstUtil.storeHashValue)}");
      try {
        var headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
        };
        var request = http.Request(
            'POST',
            Uri.parse(
                "${urls.v3baseUrl}${urls.customers}/${urls.validateCredentials}"));
        debugPrint("***====== loginUserApi url ======*** $request");
        request.body = json.encode({
          "email": email,
          "password": password,
        });
        debugPrint(
            "***====== loginUserApi request.body ======*** ${request.body}\n");
        debugPrint(
            "***====== loginUserApi request.valuesvalues ======*** ${request.headers.values}");
        debugPrint("***====== loginUserApi headers ======*** $headers");
        debugPrint(
            "***====== loginUserApi entries ======*** ${headers.entries}");
        debugPrint("***====== loginUserApi values ======*** ${headers.values}");

        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());

        debugPrint(
            "***====== loginUserApi response.body ======*** ${response.body}\n");
        debugPrint(
            "***====== loginUserApi response.statusCode ======*** ${response.statusCode}\n");
        if (response.statusCode == 200) {
          if (jsonDecode(response.body)['is_valid'] == true) {
            debugPrint(
                "***====== loginUserApi response.body ======*** ${response.body}\n");

            await SpUtil.putInt(SpConstUtil.customerID,
                jsonDecode(response.body)['customer_id']);
            await getComapnystatusApi(pl, context, toggleTheme, setState);
          } else {
            await showToast(commonData.error);
          }
        } else if (response.statusCode == 422) {
          await pl.hide();
          await showToast(jsonDecode(response.body)['errors']);
        } else if (response.statusCode == 429) {
          await pl.hide();
          await showToast(jsonDecode(response.body)['errors']);
        } else if (response.statusCode == 404) {
          await pl.hide();
          await showToast("Not found");
        } else {
          await pl.hide();
          debugPrint(
              "***====== loginUserApi not 200 ======*** ${response.reasonPhrase}");
        }
      } catch (e) {
        await pl.hide();
        await showToast(commonData.error);
        debugPrint("***====== loginUserApi e is here ======*** $e");
      }
    } else {
      await pl.hide();

      await showToast(commonData.noInternet);
    }
  }

  getComapnystatusApi(ProgressLoader pl, BuildContext context,
      VoidCallback toggleTheme, StateSetter setState) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'Authtoken': '${SpUtil.getString(SpConstUtil.authTokenV3)}'
        };
        var request = http.Request(
            'GET',
            Uri.parse(
                '${urls.companybaseUrl}?customerId=${SpUtil.getInt(SpConstUtil.customerID)}'));
        debugPrint("***====== getComapnystatusApi request====>$request");
        request.headers.addAll(headers);
        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== getComapnystatusApi request.valuesvalues ======*** ${request.headers.values}");
        debugPrint(
            "***====== getComapnystatusApi response.body is here ======*** ${response.body}\n");
        debugPrint(
            "***====== getComapnystatusApi response.statusCode ======*** ${response.statusCode}\n");
        debugPrint(
            "***====== getComapnystatusApi response.headers['set-cookie']aaa ======*** ${response.headers}");
        debugPrint(
            "***====== getComapnystatusApi response.headers['set-cookie'] ======*** ${response.headers['set-cookie']}");
        debugPrint(
            "***====== companystatus ====>${jsonDecode(response.body)['data'][0]['companyStatus']}");
        if (response.statusCode == 200) {
          if (jsonDecode(response.body)['data'][0]['companyStatus'] == 1) {
            await getCustomerApi(
              pl,
            );
            await getCompanyApi(
              pl,
            );
            await getCustomerAddressApi(pl);
            await priceListApi();
            await pl.hide();
            await showToast("Login Successfully...");
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BottomNavigationBarScreen(
                          toggleTheme: toggleTheme,
                        )));
            setState(() {});
          } else {
            await pl.hide();
            await accountDeleteDialog(pl, context, "login", toggleTheme);
          }
        } else if (response.statusCode == 401) {
          await pl.hide();
        } else {
          await pl.hide();

          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();
        await showToast(commonData.error);
      }
    } else {
      await pl.hide();
      await showToast(commonData.noInternet);
    }
    return null;
  }

  Future<GetCustomerModel?> getCustomerApi(ProgressLoader pl) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}'
        };
        var request = http.Request(
            'GET',
            Uri.parse(
                '${urls.v3baseUrl}${urls.customers}?id:in=${SpUtil.getInt(SpConstUtil.customerID)}&include=addresses,attributes'));
        debugPrint("***====== getCustomerApi request ======*** $request");

        request.headers.addAll(headers);
        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== getCustomerApi request.valuesvalues ======*** ${request.headers.values}");
        debugPrint(
            "***====== getCustomerApi response.body is here hhhh ======*** ${response.body}\n");
        debugPrint(
            "***====== getCustomerApi response.statusCode ======*** ${response.statusCode}\n");
        debugPrint(
            "***====== getCustomerApi response.headers['set-cookie']aaa ======*** ${response.headers}");
        debugPrint(
            "***====== getCustomerApi response.headers['set-cookie'] ======*** ${response.headers['set-cookie']}");
        if (response.statusCode == 200) {
          await SpUtil.putString(SpConstUtil.firstName,
              jsonDecode(response.body)['data'][0]['first_name']);

          await SpUtil.putString(SpConstUtil.lastName,
              jsonDecode(response.body)['data'][0]['last_name']);
          await SpUtil.putString(
              SpConstUtil.countryCode,
              jsonDecode(response.body)['data'][0]['addresses'][0]
                  ['country_code']);
          await SpUtil.putString(
              SpConstUtil.postalCode,
              jsonDecode(response.body)['data'][0]['addresses'][0]
                  ['postal_code']);
          await SpUtil.putString(SpConstUtil.city,
              jsonDecode(response.body)['data'][0]['addresses'][0]['city']);
          await SpUtil.putString(SpConstUtil.country,
              jsonDecode(response.body)['data'][0]['addresses'][0]['country']);
          await SpUtil.putString(SpConstUtil.address1,
              jsonDecode(response.body)['data'][0]['addresses'][0]['address1']);
          await SpUtil.putString(SpConstUtil.address2,
              jsonDecode(response.body)['data'][0]['addresses'][0]['address2']);
          await SpUtil.putString(
              SpConstUtil.stateOrProvince,
              jsonDecode(response.body)['data'][0]['addresses'][0]
                  ['state_or_province']);
          await SpUtil.putString(SpConstUtil.phone,
              jsonDecode(response.body)['data'][0]['addresses'][0]['phone']);
          await SpUtil.putString(SpConstUtil.company,
              jsonDecode(response.body)['data'][0]['addresses'][0]['company']);
          await SpUtil.putString(SpConstUtil.userEmail,
              jsonDecode(response.body)['data'][0]['email']);
          return GetCustomerModel.fromJson(jsonDecode(response.body));
        } else if (response.statusCode == 401) {
          await pl.hide();
          getCustomerBloc.getcustomerstreamController.sink
              .addError(jsonDecode(response.body)['title']);
        } else {
          await pl.hide();

          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();

        getCustomerBloc.getcustomerstreamController.sink
            .addError(commonData.error);
      }
    } else {
      await pl.hide();

      getCustomerBloc.getcustomerstreamController.sink
          .addError(commonData.noInternet);
    }
    return null;
  }

  Future getCompanyApi(ProgressLoader pl) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'Authtoken': '${SpUtil.getString(SpConstUtil.authTokenV3)}'
        };
        var request = http.Request(
            'GET',
            Uri.parse(
                '${urls.companyB2BbaseUrl}?customerId=${SpUtil.getInt(SpConstUtil.customerID)}'));
        debugPrint("***====== getCompanyApi request====>$request");
        request.headers.addAll(headers);
        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== getCompanyApi response.body is here hhhh ======*** ${response.body}\n");
        debugPrint(
            "***====== getCompanyApi response.statusCode ======*** ${response.statusCode}\n");
        debugPrint(
            "***====== jsonDecode(response.body)['data'][0]['bcGroupId'] ======*** ${jsonDecode(response.body)['data'][0]['bcGroupId']}");
        debugPrint(
            "***====== getCompanyApi response.headers['set-cookie']aaa ======*** ${response.headers}");
        debugPrint(
            "***====== getCompanyApi response.headers['set-cookie'] ======*** ${response.headers['set-cookie']}");
        if (response.statusCode == 200) {
          // await getpriceListidApi(
          //     jsonDecode(response.body)['data'][0]['bcGroupId'], pl);
          await SpUtil.putString(SpConstUtil.companyID,
              '${jsonDecode(response.body)['data'][0]['companyId']}');
        } else if (response.statusCode == 401) {
          await pl.hide();
          await showToast(jsonDecode(response.body)['title']);
        } else {
          await pl.hide();

          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();
        await showToast(commonData.error);
      }
    } else {
      await pl.hide();
      await showToast(commonData.noInternet);
    }
    return null;
  }

  // loginUserApi(String email, String password) async {
  //   try {
  //     var headers = {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //     };
  //     var request =
  //         http.Request('POST', Uri.parse(urls.loginbaseUrl + urls.createUser));
  //     request.body = json.encode({
  //       "storeHash": "${SpUtil.getString(SpConstUtil.storeHashValue)}",
  //       "email": email,
  //       "password": password,
  //       "channelId": 1,
  //       "name": "custom"
  //     });
  //     request.headers.addAll(headers);

  //     http.StreamedResponse streamedResponse = await request.send();
  //     http.Response response = await http.Response.fromStream(streamedResponse);
  //     debugPrint("==== response.body ======***${response.body}");
  //     debugPrint("==== response.statusCode ======***${response.statusCode}\n");
  //     if (response.statusCode == 200) {
  //       if (jsonDecode(response.body)['code'] == 200) {
  //         debugPrint("==== response.body ======***${response.body}");

  //         await showToast("Login Successfully...");
  //         // debugPrint(
  //         //     "===== response.headers['set-cookie']sss =====>${response.headers['set-cookie']}");
  //         getCartData();
  //         // await getCartData();
  //       } else if (jsonDecode(response.body)['code'] == 400) {
  //         await showToast(
  //             jsonDecode(response.body)['data']['errMsg'].toString());
  //       } else {
  //         debugPrint("=== not 200 ===>>${response.reasonPhrase}");
  //       }
  //     }
  //   } catch (e) {
  //     debugPrint("===== error is here ===== >>$e");
  //   }
  // }

  getCartData() async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var request = http.Request('GET',
        Uri.parse('https://adyahwholesale.com/api/storefront/carts?include'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    debugPrint(
        "***====== getCartData response.statusCode ======*** ${response.statusCode}\n");
    debugPrint(
        "***====== getCartData response.headers ======*** ${response.headers}");
    debugPrint(
        "***====== getCartData response.headers['set-cookie'] ======*** ${response.headers['set-cookie']}");

    if (response.statusCode == 200) {
      debugPrint(
          "***====== getCartData ======*** ${await response.stream.bytesToString()}");
    } else {
      debugPrint(
          "***====== getCartData else ======*** ${response.reasonPhrase}");
    }
  }

  Future<CategoryModel?> categoryListApi(ProgressLoader pl) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}'
        };
        var request = http.Request(
            'GET',
            Uri.parse(
                "${urls.storesbaseUrl}${urls.treescategories}?is_visible=true"));
        debugPrint("***====== categoryListApi request ======*** $request");

        request.headers.addAll(headers);
        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== categoryListApi response.body ======*** ${response.body}\n");
        debugPrint(
            "***====== categoryListApi response.statusCode ======*** ${response.statusCode}\n");
        if (response.statusCode == 200) {
          await pl.hide();
          return CategoryModel.fromJson(jsonDecode(response.body));
        } else if (response.statusCode == 401) {
          await pl.hide();
          categoryBloc.categorystreamController.sink
              .addError(jsonDecode(response.body)['title']);
        } else if (response.statusCode == 403) {
          await pl.hide();
          categoryBloc.categorystreamController.sink
              .addError(jsonDecode(response.body)['title']);
        } else if (response.statusCode == 404) {
          await pl.hide();
          categoryBloc.categorystreamController.sink
              .addError(jsonDecode(response.body)['errors']);
        } else {
          await pl.hide();
          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();
        debugPrint("***====== categoryListApi error is here ======*** $e");
        categoryBloc.categorystreamController.sink.addError(commonData.error);
      }
    } else {
      await pl.hide();

      categoryBloc.categorystreamController.sink
          .addError(commonData.noInternet);
    }
    return null;
  }

  Future<ParentCategoryModel?> categoryListApi2(ProgressLoader pl) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}'
        };
        var request = http.Request(
            'GET',
            Uri.parse(
                "${urls.v3baseUrl}${urls.catalogtrees}${urls.categories}?parent_id:in=0"));
        debugPrint("***====== categoryListApi2 request ======*** $request");

        request.headers.addAll(headers);
        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== categoryListApi2 response.body ======*** ${response.body}\n");
        debugPrint(
            "***====== categoryListApi2 response.statusCode ======*** ${response.statusCode}\n");
        if (response.statusCode == 200) {
          await pl.hide();
          return ParentCategoryModel.fromJson(jsonDecode(response.body));
        } else if (response.statusCode == 401) {
          await pl.hide();
          parentCategoryBloc.parentcategorystreamController.sink
              .addError("Unauthorized");
        } else if (response.statusCode == 404) {
          await pl.hide();
          parentCategoryBloc.parentcategorystreamController.sink
              .addError("Bad Request");
        } else if (response.statusCode == 403) {
          await pl.hide();
          parentCategoryBloc.parentcategorystreamController.sink
              .addError(jsonDecode(response.body)['title']);
        } else if (response.statusCode == 422) {
          await pl.hide();
          parentCategoryBloc.parentcategorystreamController.sink
              .addError(jsonDecode(response.body)['errors']['errors']);
        } else {
          await pl.hide();

          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();

        parentCategoryBloc.parentcategorystreamController.sink
            .addError(commonData.error);
      }
    } else {
      await pl.hide();

      parentCategoryBloc.parentcategorystreamController.sink
          .addError(commonData.noInternet);
    }
    return null;
  }

  Future<SubCategoryModel?> subcategoryListApi() async {
    try {
      var headers = {
        'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}'
      };
      var request = http.Request(
          'GET',
          Uri.parse(
              "${urls.storesbaseUrl}${urls.treescategories}?is_visible=true"));
      debugPrint("***====== subcategoryListApi request ======*** $request");

      request.headers.addAll(headers);

      http.Response response =
          await http.Response.fromStream(await request.send());
      debugPrint(
          "***====== subcategoryListApi response.body ======*** ${response.body}\n");
      debugPrint(
          "***====== subcategoryListApi response.statusCode ======*** ${response.statusCode}\n");
      if (response.statusCode == 200) {
        await showToast("categories get Successfully...");
        return SubCategoryModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        await showToast("Unauthorized");
      } else if (response.statusCode == 403) {
        await showToast(jsonDecode(response.body)['title']);
      } else if (response.statusCode == 404) {
        await showToast(jsonDecode(response.body)['errors']);
      } else {
        debugPrint(response.reasonPhrase);
      }
    } catch (e) {
      debugPrint("***====== subcategoryListApi error is here ===== >>$e");
    }
    return null;
  }

  Future<GetAllBrandsModel?> getAllBrandsApi(ProgressLoader pl) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}'
        };
        var request = http.Request(
            'GET', Uri.parse("${urls.storesbaseUrl}${urls.brands}?sort=name"));

        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint("***====== response.body ======***${response.body}");
        debugPrint(
            "***====== response.statusCode ======***${response.statusCode}\n");
        if (response.statusCode == 200) {
          await pl.hide();
          return GetAllBrandsModel.fromJson(jsonDecode(response.body));
        } else if (response.statusCode == 401) {
          await pl.hide();

          getBrandBloc.getbrandstreamController.sink
              .addError(jsonDecode(response.body)['title']);
        } else {
          await pl.hide();

          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();

        debugPrint("===== error is here ===== >>$e");
        getBrandBloc.getbrandstreamController.sink.addError(commonData.error);
      }
      return null;
    } else {
      await pl.hide();
      getBrandBloc.getbrandstreamController.sink
          .addError(commonData.noInternet);
    }
    return null;
  }

  Future<ProductsMainCategoryModel?> productsMainCategoryApi(categoryID,
      String isfeatured, ProgressLoader pl, int page, String url) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}'
        };
        var request = http.Request('GET', Uri.parse(url));
        debugPrint(
            "***====== productsMainCategoryApi request ======*** $request");

        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== productsMainCategoryApi response.body ======*** ${response.body}\n");
        debugPrint(
            "***====== productsMainCategoryApi response.statusCode ======*** ${response.statusCode}\n");
        if (response.statusCode == 200) {
          await pl.hide();
          return ProductsMainCategoryModel.fromJson(jsonDecode(response.body));
        } else if (response.statusCode == 401) {
          await pl.hide();

          productsMainCategoryBloc.productsMainCategorystreamController.sink
              .addError(jsonDecode(response.body)['title']);
        } else {
          await pl.hide();

          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        productsMainCategoryBloc.productsMainCategorystreamController.sink
            .addError(commonData.error);
      }
      return null;
    } else {
      await pl.hide();

      productsMainCategoryBloc.productsMainCategorystreamController.sink
          .addError(commonData.noInternet);
    }
    return null;
  }

  Future<Map<String, dynamic>> addToCartProductsApi(
      List<Map<String, dynamic>> lineItems,
      ProgressLoader pl,
      StateSetter setState) async {
    var headers = {
      'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
      'X-Auth-Client': '${SpUtil.getString(SpConstUtil.clientId)}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(urls.v3baseUrl + urls.carts));
    request.body = json.encode({
      "customer_id": SpUtil.getInt(SpConstUtil.customerID),
      "line_items": lineItems
    });
    debugPrint("***====== addToCartProductsApi request ======*** $request");
    debugPrint(
        "***====== addToCartProductsApi request.body ======*** ${request.body}\n");
    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());
    debugPrint(
        "***====== addToCartProductsApi response.body ======*** ${response.body}\n");
    debugPrint(
        "***====== addToCartProductsApi response.statusCode ======*** ${response.statusCode}\n");

    if (response.statusCode == 201) {
      await SpUtil.putString(
          SpConstUtil.cartID, jsonDecode(response.body)['data']['id']);
      await showToast("Item in added to cart...");
      await allCartDataApi(SpUtil.getString(SpConstUtil.cartID)!, pl, setState);
      await pl.hide();
    } else if (response.statusCode == 401) {
      await pl.hide();
      await showToast(jsonDecode(response.body)['title']);
    } else if (response.statusCode == 422) {
      await pl.hide();
      await showToast(jsonDecode(response.body)['errors']['variant']);
    } else {
      await pl.hide();

      debugPrint(response.reasonPhrase);
    }

    return {
      'response': response,
      'statusCode': response.statusCode,
    };
  }

  Future<Map<String, dynamic>> addToCartProductsApi2() async {
    var headers = {
      'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
      'X-Auth-Client': '${SpUtil.getString(SpConstUtil.clientId)}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(urls.v3baseUrl + urls.carts));
    request.body = json.encode({
      "customer_id": SpUtil.getInt(SpConstUtil.customerID),
      "line_items": []
    });
    debugPrint("***====== addToCartProductsApi2 request ======*** $request");
    debugPrint(
        "***====== addToCartProductsApi2 request.body ======*** ${request.body}\n");
    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());
    debugPrint(
        "***====== addToCartProductsApi2 response.body ======*** ${response.body}\n");
    debugPrint(
        "***====== addToCartProductsApi2s response.statusCode ======*** ${response.statusCode}\n");

    if (response.statusCode == 201) {
      await SpUtil.putString(
          SpConstUtil.cartID, jsonDecode(response.body)['data']['id']);
      await showToast("addToCart Products Successfully...");
    } else if (response.statusCode == 401) {
      await showToast(jsonDecode(response.body)['title']);
    } else if (response.statusCode == 422) {
      await showToast(jsonDecode(response.body)['title']);
    } else {
      debugPrint(response.reasonPhrase);
    }

    return {
      'response': response,
      'statusCode': response.statusCode,
    };
  }

  addToCartNewApi(List<Map<String, dynamic>> lineItems, String cartID,
      ProgressLoader pl, StateSetter setState) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-Auth-Client': '${SpUtil.getString(SpConstUtil.clientId)}'
        };
        var request = http.Request('POST',
            Uri.parse('${urls.v3baseUrl}${urls.carts}/$cartID/${urls.items}'));
        request.body = json.encode({
          "customer_id": SpUtil.getInt(SpConstUtil.customerID),
          "line_items": lineItems
        });
        debugPrint(
            "***====== addToCartNewApi lineItems ======*** ${request.body}");
        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== addToCartNewApi response.statusCode ======*** ${response.statusCode}\n");
        debugPrint(
            "***====== addToCartNewApi response.statusCode ======*** ${response.body}\n");
        if (response.statusCode == 201) {
          await pl.hide();
          await allCartDataApi(cartID, pl, setState);
          await showToast("Item in added to cart...");
        } else if (response.statusCode == 422) {
          await pl.hide();
          await showToast(jsonDecode(response.body)['title']);
        }
      } catch (e) {
        await pl.hide();
        await showToast(commonData.error);
      }
    } else {
      await pl.hide();

      await showToast(commonData.noInternet);
    }
  }

  generatePaymentAccessTokenApi(ProgressLoader pl, orderID, int expiryYear,
      int expiryMonth, cardholderName, cardNumber) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-Auth-Client': '${SpUtil.getString(SpConstUtil.clientId)}'
        };
        var request = http.Request(
            'POST', Uri.parse('${urls.v3baseUrl}payments/access_tokens'));
        request.body = json.encode({
          "order": {"id": orderID}
        });
        debugPrint(
            "***====== generatePaymentAccessTokenApi lineItems ======*** ${request.body}");
        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== generatePaymentAccessTokenApi response.statusCode ======*** ${response.statusCode}\n");
        debugPrint(
            "***====== generatePaymentAccessTokenApi response.statusCode ======*** ${response.body}\n");
        if (response.statusCode == 201) {
          // await pl.hide();
          await paymentApi(pl, orderID, jsonDecode(response.body)['data']['id'],
              cardNumber, cardholderName, expiryMonth, expiryYear);
        } else if (response.statusCode == 422) {
          await pl.hide();
          await showToast(jsonDecode(response.body)['title']);
        }
      } catch (e) {
        await pl.hide();
        await showToast(commonData.error);
      }
    } else {
      await pl.hide();

      await showToast(commonData.noInternet);
    }
  }

  paymentApi(ProgressLoader pl, orderID, paymentaccessToken, cardNumber,
      cardholderName, int expiryMonth, int expiryYear) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'Accept': 'application/vnd.bc.v1+json',
          'Content-Type': 'application/json',
          'X-Auth-Client': '${SpUtil.getString(SpConstUtil.clientId)}',
          'Authorization': 'PAT $paymentaccessToken'
        };
        var request = http.Request(
            'POST',
            Uri.parse(
                'https://payments.bigcommerce.com/stores/${SpUtil.getString(SpConstUtil.storeHashValue)}/payments'));
        debugPrint("=== request ==>$request");
        request.body = json.encode({
          "payment": {
            "instrument": {
              "type": "card",
              "number": cardNumber,
              "cardholder_name": cardholderName,
              "expiry_month": expiryMonth,
              "expiry_year": expiryYear,
              "verification_value": "123"
            },
            "payment_method_id": "authorizenet.card"
          }
        });
        debugPrint("***====== paymentApi lineItems ======*** ${request.body}");
        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== paymentApi response.statusCode ======*** ${response.statusCode}\n");
        debugPrint(
            "***====== paymentApi response.statusCode ======*** ${response.body}\n");
        if (response.statusCode == 201) {
          await pl.hide();
          await showToast("payment successfully...");
        } else if (response.statusCode == 422) {
          await pl.hide();
          await showToast(jsonDecode(response.body)['title']);
        }
      } catch (e) {
        await pl.hide();
        await showToast(commonData.error);
      }
    } else {
      await pl.hide();

      await showToast(commonData.noInternet);
    }
  }

  deleteCart(String cartID, ProgressLoader pl, BuildContext context,
      void Function() toggleTheme, String firstName, int orderId) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        };
        var request = http.Request(
            'DELETE', Uri.parse('${urls.v3baseUrl}${urls.carts}/$cartID'));

        debugPrint("***====== deleteCartItems lineItems ======*** $request");

        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== deleteCart response.statusCode ======*** ${response.statusCode}\n");
        debugPrint(
            "***====== deleteCart response.statusCode ======*** ${response.body}\n");
        if (response.statusCode == 200) {
        } else if (response.statusCode == 204) {
          await SpUtil.remove(SpConstUtil.cartID);
          await Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => OrderPlacedSuccessScreen(
                toggleTheme: toggleTheme,
                orderID: orderId,
                firstName: firstName,
              ),
            ),
            (route) => false,
          );
        } else if (response.statusCode == 422) {}
      } catch (e) {
        await pl.hide();
        await showToast(commonData.error);
      }
    } else {
      await pl.hide();

      await showToast(commonData.noInternet);
    }
  }

  deleteCartItems(String cartID, String itemID, ProgressLoader pl,
      StateSetter setState) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        };
        var request = http.Request(
            'DELETE',
            Uri.parse(
                '${urls.v3baseUrl}${urls.carts}/$cartID/${urls.items}/$itemID'));

        debugPrint("***====== deleteCartItems lineItems ======*** $request");

        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== deleteCartItems response.statusCode ======*** ${response.statusCode}\n");
        debugPrint(
            "***====== deleteCartItems response.statusCode ======*** ${response.body}\n");
        if (response.statusCode == 200) {
          await cartDataBloc.cartDataBlocc(cartID, pl, setState);
          await SpUtil.remove(SpConstUtil.totalqty);
          await showToast("Item removed...");
        } else if (response.statusCode == 204) {
          // await cartDataBloc.cartDataBlocc(cartID, pl, setState);
          cartDataBloc.reload(cartID, pl, setState);

          await SpUtil.remove(SpConstUtil.totalqty);
          await showToast("Cart deleted...");
        } else if (response.statusCode == 422) {
          await pl.hide();
          await showToast(jsonDecode(response.body)['title']);
        }
      } catch (e) {
        await pl.hide();
        await showToast(commonData.error);
      }
    } else {
      await pl.hide();

      await showToast(commonData.noInternet);
    }
  }

  getPaymetMethodApi(
    ProgressLoader pl,
    BuildContext context,
    void Function() toggleTheme,
    orderID,
    cartID,
  ) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        };
        var request = http.Request('GET',
            Uri.parse('${urls.v3baseUrl}payments/methods?checkout_id=$cartID'));
        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "======*** getPaymetMethodApi response.statusCode ======*** ${response.statusCode}\n");
        debugPrint(
            "======*** getPaymetMethodApi response.statusCode ======*** ${response.body}\n");
        if (response.statusCode == 200) {
          await pl.hide();
          // await deleteCart(
          //     cartID, pl, context, toggleTheme, firstName, orderId);

          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PaymentScreen(
                        toggleTheme: toggleTheme,
                        data: jsonDecode(response.body)['data'],
                        cartID: cartID,
                      )));
        } else if (response.statusCode == 422) {
          await pl.hide();
          await showToast(jsonDecode(response.body)['title']);
        }
      } catch (e) {
        await pl.hide();
        await showToast(commonData.error);
      }
    } else {
      await pl.hide();

      await showToast(commonData.noInternet);
    }
  }

  ordercheckoutApi(ProgressLoader pl, BuildContext context, String cartID,
      void Function() toggleTheme, StateSetter setState) async {
    debugPrint("***====== ordercheckoutApi ======*** ");

    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
        };
        var request = http.Request(
            'POST',
            Uri.parse(
                '${urls.v3baseUrl}${urls.checkouts}/$cartID/${urls.orders}'));
        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== ordercheckoutApi response.statusCode ======*** ${response.statusCode}\n");
        debugPrint(
            "***====== ordercheckoutApi response.statusCode ======*** ${response.body}\n");
        if (response.statusCode == 200) {
          // await pl.hide();
          // await deleteCart(
          //     cartID, pl, context, toggleTheme, firstName, orderId);

          await SpUtil.putInt(
              SpConstUtil.orderID, jsonDecode(response.body)['data']['id']);
          await apis.ordercheckoutUpdateApi(
              pl, context, cartID, toggleTheme, setState);
          // await getPaymetMethodApi(
          //     pl,
          //     context,
          //     toggleTheme,
          //     SpUtil.getInt(SpConstUtil.orderID),
          //     cartID,
          //  );
        } else if (response.statusCode == 422) {
          await pl.hide();
          await showToast(jsonDecode(response.body)['title']);
        }
      } catch (e) {
        await pl.hide();
        await showToast(commonData.error);
      }
    } else {
      await pl.hide();

      await showToast(commonData.noInternet);
    }
  }

  ordercheckoutUpdateApi(ProgressLoader pl, BuildContext context, String cartID,
      void Function() toggleTheme, StateSetter setState) async {
    debugPrint("***====== ordercheckoutApi ======*** ");

    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.Request(
            'PUT',
            Uri.parse(
                '${urls.v2baseUrl}orders/${SpUtil.getInt(SpConstUtil.orderID)}'));
        request.body = json.encode({
          "status_id": 7,
          "payment_method": "cod",
          "customer_id": '${SpUtil.getInt(SpConstUtil.customerID)}'
        });
        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== ordercheckoutApi response.statusCode ======*** ${response.statusCode}\n");
        debugPrint(
            "***====== ordercheckoutApi response.statusCode ======*** ${response.body}\n");
        if (response.statusCode == 200) {
          // await deleteCart(
          //     cartID,
          //     pl,
          //     context,
          //     toggleTheme,
          //     jsonDecode(response.body)['billing_address']['first_name'],
          //     jsonDecode(response.body)['id']);
          await allCartDataApi(cartID, pl, setState);
          await Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => OrderPlacedSuccessScreen(
                toggleTheme: toggleTheme,
                orderID: jsonDecode(response.body)['id'],
                firstName: jsonDecode(response.body)['billing_address']
                    ['first_name'],
              ),
            ),
            (route) => false,
          );
        } else if (response.statusCode == 422) {
          await pl.hide();
          await showToast(jsonDecode(response.body)['title']);
        }
      } catch (e) {
        await pl.hide();
        await showToast(commonData.error);
      }
    } else {
      await pl.hide();

      await showToast(commonData.noInternet);
    }
  }

  createAnOrderApi(
      String cartID,
      String firstName,
      String lastName,
      String street1,
      String city,
      String state,
      String zip,
      String country,
      String countrycode,
      String email,
      List<Map<String, dynamic>> lineItems,
      ProgressLoader pl,
      BuildContext context,
      void Function() toggleTheme) async {
    debugPrint("=== createAnOrderApi ===");
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        };
        var request =
            http.Request('POST', Uri.parse('${urls.v2baseUrl}${urls.orders}'));
        Map<String, dynamic> requestBody = {
          "status_id": 7,
          "customer_id": SpUtil.getInt(SpConstUtil.customerID),
          "billing_address": {
            "first_name": firstName,
            "last_name": lastName,
            "street_1": street1,
            "city": city,
            "state": state,
            "zip": zip,
            "country": country,
            "country_iso2": countrycode,
            "email": email
          },
          "shipping_addresses": [
            {
              "first_name": firstName,
              "last_name": lastName,
              "street_1": street1,
              "city": city,
              "state": state,
              "zip": zip,
              "country": country,
              "country_iso2": countrycode,
              "email": email
            }
          ],
          "products": lineItems
        };
        request.body = json.encode(requestBody);
        debugPrint(
            "***====== createAnOrderApi lineItems ======*** ${request.body}");
        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== createAnOrderApi response.statusCode ======*** ${response.statusCode}\n");
        debugPrint(
            "***====== createAnOrderApi response.body ======*** ${response.body}\n");
        if (response.statusCode == 201) {
          debugPrint(
              "***====== response.statusCode ======*** ${response.statusCode}\n");
          // await Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => PaymentScreen(
          //               toggleTheme: toggleTheme,
          //               cartID: cartID,
          //               firstName: jsonDecode(response.body)['billing_address']
          //                   ['first_name'],
          //               id: jsonDecode(response.body)['id'],
          //             )));
          await deleteCart(cartID, pl, context, toggleTheme, firstName,
              jsonDecode(response.body)['id']);
        } else if (response.statusCode == 422) {
          await pl.hide();
          await showToast(jsonDecode(response.body)['title']);
        }
      } catch (e) {
        await pl.hide();
        await showToast(commonData.error);
      }
    } else {
      await pl.hide();

      await showToast(commonData.noInternet);
    }
  }

  Future<CartDataModel?> allCartDataApi(
      String cartID, ProgressLoader pl, StateSetter setState) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'X-Auth-Client': '${SpUtil.getString(SpConstUtil.clientId)}',
          'Content-Type': 'application/json'
        };
        var request = http.Request(
            'GET',
            Uri.parse(
                '${urls.v3baseUrl}${urls.carts}/$cartID?include=promotions.banners,line_items.digital_items.options,redirect_urls,line_items.physical_items.options'));
        debugPrint("***====== allCartDataApi request ======*** $request");
        debugPrint(
            "***====== allCartDataApi request.body ======*** ${request.body}\n");
        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== allCartDataApi response.body ======*** ${response.body}\n");
        debugPrint(
            "***====== allCartDataApi response.statusCode ======*** ${response.statusCode}\n");
        if (response.statusCode == 200) {
          await pl.hide();
          // here total qty

          // return CartDataModel.fromJson(jsonDecode(response.body));
          CartDataModel cartData =
              CartDataModel.fromJson(jsonDecode(response.body));

          // Calculate and save total quantity
          calculateTotalQuantity(cartData, setState);

          return cartData;
        } else if (response.statusCode == 401) {
          await pl.hide();

          cartDataBloc.cartDatastreamController.sink
              .addError(jsonDecode(response.body)['title']);
        } else if (response.statusCode == 404) {
          await pl.hide();
          await SpUtil.remove(SpConstUtil.cartID);
          // cartDataBloc.cartDataBlocc(cartID, pl, setState);
          cartDataBloc.cartDatastreamController.sink.addError("No Cart Found");
        } else if (response.statusCode == 422) {
          await pl.hide();

          cartDataBloc.cartDatastreamController.sink
              .addError(jsonDecode(response.body)['title']);
        } else {
          await pl.hide();

          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();
        cartDataBloc.cartDatastreamController.sink.addError(commonData.error);
      }
    } else {
      await pl.hide();

      cartDataBloc.cartDatastreamController.sink
          .addError(commonData.noInternet);
    }
    return null;
  }

  Future<List<GetBlogModel>?> getBlogApi(ProgressLoader pl, String url) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        };
        var request = http.Request(
          'GET',
          Uri.parse(url),
        );
        request.headers.addAll(headers);
        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== getBlogApi response.body ======*** ${response.body}\n");
        debugPrint(
            "***====== getBlogApi response.statusCode ======*** ${response.statusCode}\n");
        List<GetBlogModel> getBlogModelListFromJson(String str) =>
            List<GetBlogModel>.from(
                json.decode(str).map((x) => GetBlogModel.fromJson(x)));
        if (response.statusCode == 200) {
          pl.hide();
          List<GetBlogModel> blogPosts =
              getBlogModelListFromJson(response.body);
          return blogPosts;
        } else if (response.statusCode == 401) {
          pl.hide();
          blogBloc.blogstreamController.sink
              .addError(jsonDecode(response.body)['title']);
        } else if (response.statusCode == 422) {
          pl.hide();
          blogBloc.blogstreamController.sink
              .addError(jsonDecode(response.body)['title']);
        } else {
          pl.hide();
          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        pl.hide();
        blogBloc.blogstreamController.sink.addError(commonData.error);
      }
    } else {
      pl.hide();

      await pl.hide();

      blogBloc.blogstreamController.sink.addError(commonData.noInternet);
    }
    return null;
  }

  Future<NewProductsModel?> newProductsApi(categoryID) async {
    try {
      var headers = {
        'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}'
      };
      var request = http.Request(
          'GET',
          Uri.parse(
              '${urls.storesbaseUrl}${urls.products}?is_visible=true&include=images,primary_image,primary_image,variants,options'));
      debugPrint("***====== newProductsApi request ======*** $request");

      request.headers.addAll(headers);

      http.Response response =
          await http.Response.fromStream(await request.send());
      debugPrint(
          "***====== newProductsApi response.body ======*** ${response.body}\n");
      debugPrint(
          "***====== newProductsApi response.statusCode ======*** ${response.statusCode}\n");
      if (response.statusCode == 200) {
        await showToast("categories get Successfully...");
        return NewProductsModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        await showToast(jsonDecode(response.body)['title']);
      } else {
        debugPrint(response.reasonPhrase);
      }
    } catch (e) {
      debugPrint("***====== newProductsApi error is here ======*** $e");
    }
    return null;
  }

  updateQty(String cartID, String itemID, int productID, int variantID, int qty,
      ProgressLoader pl, StateSetter setState) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        };
        var request = http.Request(
            'PUT',
            Uri.parse(
                '${urls.v3baseUrl}${urls.carts}/$cartID/${urls.items}/$itemID'));
        request.body = json.encode({
          "line_item": {
            "product_id": productID,
            "variant_id": variantID,
            "quantity": qty
          },
          "locale": "en"
        });
        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== updateQty response.body ======*** ${response.body}\n");
        debugPrint(
            "***====== updateQty response.statusCode ======*** ${response.statusCode}\n");
        if (response.statusCode == 200) {
          await cartDataBloc.cartDataBlocc(cartID, pl, setState);
          await showToast("update Successfully...");
          await pl.hide();

          // return NewProductsModel.fromJson(jsonDecode(response.body));
        } else if (response.statusCode == 422) {
          await pl.hide();

          await showToast(jsonDecode(response.body)['title']);
        } else if (response.statusCode == 401) {
          await pl.hide();

          await showToast(jsonDecode(response.body)['title']);
        } else {
          await pl.hide();

          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await showToast(commonData.error);
      }
    } else {
      await pl.hide();

      await showToast(commonData.noInternet);
    }
    return null;
  }

  Future<List<HomeBannerModel>?> homebannerApi(ProgressLoader pl) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var request = http.Request('GET', Uri.parse(urls.homeBannerbaseUrl));

        http.Response response =
            await http.Response.fromStream(await request.send());
        List<HomeBannerModel> getBlogModelListFromJson(String str) =>
            List<HomeBannerModel>.from(
                json.decode(str).map((x) => HomeBannerModel.fromJson(x)));
        // debugPrint("=== response body homebanner ===>>${response.body}");
        // debugPrint(
        //     "=== response statuscode homebanner ===>>${response.statusCode}\n");

        if (response.statusCode == 200) {
          await pl.hide();
          List<HomeBannerModel> blogPosts =
              getBlogModelListFromJson(response.body);
          return blogPosts;
        } else {
          await pl.hide();

          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();

        homeBannerBloc.homeBannerstreamController.sink
            .addError(commonData.error);
      }
    } else {
      await pl.hide();

      homeBannerBloc.homeBannerstreamController.sink
          .addError(commonData.noInternet);
    }
    return null;
  }

  Future<ProductsMainCategoryModel?> feauturedProductsApi(
      ProgressLoader pl, int page, String url) async {
    bool internet = await checkInternet();
    if (internet) {
      debugPrint("==== internet ====");
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.Request('GET', Uri.parse(url));

        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());

        if (response.statusCode == 200) {
          return ProductsMainCategoryModel.fromJson(jsonDecode(response.body));
        } else {
          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();

        featuredProductBloc.featuredproductsstreamController.sink
            .addError(commonData.error);
      }
    } else {
      debugPrint("====No internet ====");
      await pl.hide();

      featuredProductBloc.featuredproductsstreamController.sink
          .addError(commonData.noInternet);
    }
    return null;
  }

  Future<FeaturedProductModel?> allfeauturedProductsApi(
      ProgressLoader pl, int page, String url) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.Request('GET', Uri.parse(url));

        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());

        if (response.statusCode == 200) {
          return FeaturedProductModel.fromJson(jsonDecode(response.body));
        } else {
          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();

        featuredProductBloc.featuredproductsstreamController.sink
            .addError(commonData.error);
      }
    } else {
      await pl.hide();

      featuredProductBloc.featuredproductsstreamController.sink
          .addError(commonData.noInternet);
    }
    return null;
  }

  Future<LatestProductModel?> latestProductsApi(ProgressLoader pl) async {
    bool internet = await checkInternet();
    if (internet) {
      debugPrint("===== latestProductsApi internet=====");
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.Request(
            'GET',
            Uri.parse(
                '${urls.v3baseUrl}${urls.catalogproducts}?include=images,variants,primary_image&direction=desc&is_visible=true&sort=date_last_imported&limit=25&brand_id:not_in=0'));

        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());

        if (response.statusCode == 200) {
          return LatestProductModel.fromJson(jsonDecode(response.body));
        } else {
          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();

        featuredProductBloc.featuredproductsstreamController.sink
            .addError(commonData.error);
      }
    } else {
      debugPrint("=====else No latestProductsApi internet=====");

      await pl.hide();

      featuredProductBloc.featuredproductsstreamController.sink
          .addError(commonData.noInternet);
    }
    return null;
  }

  Future<LatestProductModel?> skuscannProductsApi(
      ProgressLoader pl, String sku) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.Request(
            'GET',
            Uri.parse(
                '${urls.v3baseUrl}${urls.catalogproducts}?include=images,variants,primary_image&is_visible=true&sku=$sku'));

        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());

        if (response.statusCode == 200) {
          return LatestProductModel.fromJson(jsonDecode(response.body));
        } else {
          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();

        featuredProductBloc.featuredproductsstreamController.sink
            .addError(commonData.error);
      }
    } else {
      await pl.hide();

      featuredProductBloc.featuredproductsstreamController.sink
          .addError(commonData.noInternet);
    }
    return null;
  }

  getCustomerAddressApi(ProgressLoader pl) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.Request(
            'GET',
            Uri.parse(
                '${urls.v2baseUrl}${urls.customers}/${SpUtil.getInt(SpConstUtil.customerID)}/${urls.addresses}'));

        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== getCustomerAddressApi response.headers['set-cookie']aaa ======*** ${response.headers}");
        debugPrint(
            "***====== getCustomerAddressApi response.headers['set-cookie'] ======*** ${response.headers['set-cookie']}");

        if (response.statusCode == 200) {
          await SpUtil.putInt(SpConstUtil.customerAddressID,
              jsonDecode(response.body)[0]['id']);
          debugPrint(
              "***====== customerAddressid ======*** ${SpUtil.getInt(SpConstUtil.customerAddressID)}");
        } else {
          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();
        await showToast(commonData.error);
      }
    } else {
      await pl.hide();
      await showToast(commonData.noInternet);
    }
    return null;
  }

  updateCustomerAddressApi(
    ProgressLoader pl,
    String firstName,
    String lastName,
    String company,
    String street1,
    String street2,
    String city,
    String state,
    String zip,
    String country,
    String phone,
  ) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.Request(
            'PUT',
            Uri.parse(
                '${urls.v2baseUrl}${urls.customers}/${SpUtil.getInt(SpConstUtil.customerID)}/${urls.addresses}/${SpUtil.getInt(SpConstUtil.customerAddressID)}'));
        debugPrint("==== request ===>$request");
        request.body = json.encode({
          "customer_id": SpUtil.getInt(SpConstUtil.customerID),
          "first_name": firstName,
          "last_name": lastName,
          "company": company,
          "street_1": street1,
          "street_2": street2,
          "city": city,
          "state": state,
          "zip": zip,
          "country": country,
          "phone": phone,
          "address_type": "residential"
        });
        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== updateCustomerAddressApi response body adress update ======*** ${response.body}\n");
        debugPrint(
            "***====== updateCustomerAddressApi response body adress statusCode ======*** ${response.statusCode}\n");

        if (response.statusCode == 200) {
        } else {
          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();
        await showToast(commonData.error);
      }
    } else {
      await pl.hide();
      await showToast(commonData.noInternet);
    }
    return null;
  }

  updateCustomerApi2(
    ProgressLoader pl,
    String firstName,
    String lastName,
    String company,
    String street1,
    String street2,
    String city,
    String state,
    String zip,
    String country,
    String phone,
    String email,
  ) async {
    bool internet = await checkInternet();
    if (internet) {
      debugPrint(
          "=== companyId ====>${{SpUtil.getString(SpConstUtil.companyID)}}");
      try {
        var headers = {
          'authToken': '${SpUtil.getString(SpConstUtil.authTokenV3)}',
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.Request(
            'PUT',
            Uri.parse(
                '${urls.companyB2BbaseUrl}/${SpUtil.getString(SpConstUtil.companyID)}'));
        debugPrint("***====== updateCustomerApi2 request ======*** $request");
        request.body = json.encode({
          "customer_id": SpUtil.getInt(SpConstUtil.customerID),
          // "first_name": firstName,
          // "last_name": lastName,
          "companyName": company,
          "addressLine1": street1,
          "addressLine2": street2,
          "city": city,
          "state": state,
          "zipCode": zip,
          "country": country,
          "companyPhone": phone,
          "companyEmail": email,
          // "address_type": "residential"
        });
        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "======*** updateCustomerApi2 response body adress update ======*** ${response.body}\n");
        debugPrint(
            "======*** updateCustomerApi2 response body adress statusCode ======*** ${response.statusCode}\n");

        if (response.statusCode == 200) {
          await updateCustomerApi(pl, email);
          await updateCustomerAddressApi(
            pl,
            firstName,
            lastName,
            company,
            street1,
            street2,
            city,
            state,
            zip,
            country,
            phone,
          );
          await showToast("Profile updated successfully...");
          // await SpUtil.putInt(SpConstUtil.customerAddressID,
          //     jsonDecode(response.body)[0]['id']);
        } else {
          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();
        await showToast(commonData.error);
      }
    } else {
      await pl.hide();
      await showToast(commonData.noInternet);
    }
    return null;
  }

  updateCustomerApi(
    ProgressLoader pl,
    String email,
  ) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.Request(
            'PUT', Uri.parse('${urls.v3baseUrl}${urls.customers}'));

        request.body = json.encode([
          {
            "email": email,
            "id": SpUtil.getInt(SpConstUtil.customerID),
            "authentication": {"force_password_reset": false},
            "accepts_product_review_abandoned_cart_emails": true,
            "origin_channel_id": 1,
            "channel_ids": [1]
          }
        ]);
        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== updateCustomerApi response ======*** ${response.body}\n");
        debugPrint(
            "***====== updateCustomerApi statusCode ======*** ${response.statusCode}\n");

        if (response.statusCode == 200) {
        } else {
          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();
        await showToast(commonData.error);
      }
    } else {
      await pl.hide();
      await showToast(commonData.noInternet);
    }
    return null;
  }

  deleteCustomerApi(ProgressLoader pl, BuildContext context, bool isDarkMode,
      VoidCallback toggleTheme) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.Request(
            'DELETE',
            Uri.parse(
                '${urls.v3baseUrl}${urls.customers}?id:in=${SpUtil.getInt(SpConstUtil.customerID)}'));

        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== deleteCustomerApi response ======*** ${response.body}\n");
        debugPrint(
            "***====== deleteCustomerApi statusCode ======*** ${response.statusCode}\n");

        if (response.statusCode == 204) {
          await showToast("Delete account successfully...");
          await Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginScreen(
                toggleTheme: toggleTheme,
              ),
            ),
          );
        } else {
          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();
        await showToast(commonData.error);
      }
    } else {
      await pl.hide();
      await showToast(commonData.noInternet);
    }
    return null;
  }

  Future<ProductsMainCategoryModel?> searchProductsApi(
      ProgressLoader pl, int page, String searchkeyword) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.Request(
            'GET',
            Uri.parse(
                '${urls.v3baseUrl}${urls.catalogproducts}?is_visible=true&include=images,primary_image,primary_image,variants,options&limit=10&page=$page&keyword=$searchkeyword'));

        debugPrint("***====== searchProductsApi request ======*** $request");
        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());

        debugPrint(
            "***====== searchProductsApi response ======*** ${response.body}\n");

        if (response.statusCode == 200) {
          return ProductsMainCategoryModel.fromJson(jsonDecode(response.body));
        } else {
          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();

        featuredProductBloc.featuredproductsstreamController.sink
            .addError(commonData.error);
      }
    } else {
      await pl.hide();

      featuredProductBloc.featuredproductsstreamController.sink
          .addError(commonData.noInternet);
    }
    return null;
  }

  Future<GetWishListModel?> getWishListApi(ProgressLoader pl) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.Request(
            'GET',
            Uri.parse(
                '${urls.v3baseUrl}${urls.wishlists}?customer_id=${SpUtil.getInt(SpConstUtil.customerID)}'));

        debugPrint("***====== getWishListApi request ======*** $request");
        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());

        debugPrint(
            "***====== getWishListApi response ======*** ${response.body}\n");

        if (response.statusCode == 200) {
          return GetWishListModel.fromJson(jsonDecode(response.body));
        } else {
          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();

        getWishlistBloc.getWishliststreamController.sink
            .addError(commonData.error);
      }
    } else {
      await pl.hide();

      getWishlistBloc.getWishliststreamController.sink
          .addError(commonData.noInternet);
    }
    return null;
  }

  Future createWishListApi(ProgressLoader pl, productid) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.Request(
            'POST', Uri.parse('${urls.v3baseUrl}${urls.wishlists}'));
        request.body = json.encode({
          "customer_id": SpUtil.getInt(SpConstUtil.customerID),
          "is_public": false,
          "name": "TOBACCO MONSTER 100ML E-LIQUID",
          "items": [
            {"product_id": productid}
          ]
        });

        debugPrint("***====== createWishListApi request ======*** $request");
        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());

        debugPrint(
            "***====== createWishListApi response ======*** ${response.body}\n");

        if (response.statusCode == 201) {
          debugPrint(
              "***====== 200 createWishListApi request ======*** $response.body");
        } else {
          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();

        await showToast(commonData.error);
      }
    } else {
      await pl.hide();
      await showToast(commonData.noInternet);
    }
    return null;
  }

  Future addToitemsWishListApi(ProgressLoader pl, wishlistid, productid) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.Request(
            'POST',
            Uri.parse(
                '${urls.v3baseUrl}${urls.wishlists}/$wishlistid/${urls.items}'));
        request.body = json.encode({
          "items": [
            {"product_id": productid}
          ]
        });

        debugPrint(
            "***====== addToitemsWishListApi request ======*** $request");
        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());

        debugPrint(
            "***====== addToitemsWishListApi response ======*** ${response.body}\n");

        if (response.statusCode == 201) {
          debugPrint(
              "***====== 200 addToitemsWishListApi request ======*** $response.body");
        } else {
          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();

        await showToast(commonData.error);
      }
    } else {
      await pl.hide();
      await showToast(commonData.noInternet);
    }
    return null;
  }

  Future deleteitemsWishListApi(
      ProgressLoader pl, wishlistid, productid, itemid) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.Request(
            'DELETE',
            Uri.parse(
                '${urls.v3baseUrl}${urls.wishlists}/$wishlistid/${urls.items}/$itemid'));

        debugPrint(
            "***====== deleteitemsWishListApi request ======*** $request");
        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());

        debugPrint(
            "***====== deleteitemsWishListApi response ======*** ${response.body}\n");

        if (response.statusCode == 201) {
          debugPrint(
              "***====== 200 deleteitemsWishListApi request ======*** $response.body");
        } else {
          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();

        await showToast(commonData.error);
      }
    } else {
      await pl.hide();
      await showToast(commonData.noInternet);
    }
    return null;
  }

  Future<PriceListModel?> priceListApi() async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.MultipartRequest(
            'POST',
            Uri.parse(
                'https://phantomscannabliss.com/bigcommerce/mobile_app/pricelist.php'));
        debugPrint("==== request =====> pricelistapi ====> $request");
        request.fields.addAll(
            {'customer_id': '${SpUtil.getInt(SpConstUtil.customerID)}'});

        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== priceListApi response.body ======*** ${response.body}\n");
        if (response.statusCode == 200) {
          if (jsonDecode(response.body)['pricelist'] !=
              "Not found this customer") {
            await SpUtil.putString(
                SpConstUtil.priceList, jsonDecode(response.body)['pricelist']);
          }

          return PriceListModel.fromJson(jsonDecode(response.body));
        }
      } catch (e) {
        // await pl.hide();
        await showToast(commonData.error);
      }
    } else {
      // await pl.hide();
      await showToast(commonData.noInternet);
    }
    return null;
  }
  // Future<PriceListModel?> priceListApi() async {
  //   bool internet = await checkInternet();
  //   if (internet) {
  //     try {
  //       var headers = {
  //         'Accept': 'application/json',
  //         'Content-Type': 'application/json'
  //       };
  //       var request = http.MultipartRequest(
  //           'POST',
  //           Uri.parse(
  //               'https://phantomscannabliss.com/bigcommerce/pricelist.php'));
  //       request.fields.addAll(
  //           {'customer_id': "${SpUtil.getInt(SpConstUtil.customerID)}"});
  //       request.headers.addAll(headers);
  //       debugPrint(
  //           "====priceListApi ====> request fields ====>${request.fields}");

  //       http.Response response =
  //           await http.Response.fromStream(await request.send());
  //       debugPrint("=====pricelist response.body ======>>${response.body}");
  //       if (response.statusCode == 200) {
  //         // await pl.hide();
  //         await SpUtil.putString(
  //             SpConstUtil.priceList, jsonDecode(response.body)['pricelist']);
  //         await SpUtil.putString(
  //             SpConstUtil.imgUrl, jsonDecode(response.body)['imgurl']);
  //         return PriceListModel.fromJson(jsonDecode(response.body));
  //       }
  //     } catch (e) {
  //       // await pl.hide();
  //       await showToast(commonData.error);
  //     }
  //   } else {
  //     // await pl.hide();
  //     await showToast(commonData.noInternet);
  //   }
  //   return null;
  // }

  Future<GetMyOrdersModel?> getMyOrdersApi(ProgressLoader pl, int limit) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'authToken': '${SpUtil.getString(SpConstUtil.authTokenV3)}'
        };
        var request = http.Request(
            'GET',
            Uri.parse(
                'https://api-b2b.bigcommerce.com/api/v3/io/orders?companyId=${SpUtil.getString(SpConstUtil.companyID)}&orderBy=DESC&offset=0&showExtra=0'));

        debugPrint("***====== getMyOrdersApi request ======*** $request");
        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());

        debugPrint(
            "***====== getMyOrdersApi response ======*** ${response.body}\n");

        if (response.statusCode == 200) {
          return GetMyOrdersModel.fromJson(jsonDecode(response.body));
        } else {
          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();

        getAllOrdersBloc.getAllOrderstreamController.sink
            .addError(commonData.error);
      }
    } else {
      await pl.hide();

      getAllOrdersBloc.getAllOrderstreamController.sink
          .addError(commonData.noInternet);
    }
    return null;
  }

  Future<GetMyOrdersDetailsModel?> getMyOrderDetailsApi(
      ProgressLoader pl, var orderID) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'authToken': '${SpUtil.getString(SpConstUtil.authTokenV2)}'
        };
        var request = http.Request(
            'GET',
            Uri.parse(
                'https://api-b2b.bigcommerce.com/api/v2/io/orders/$orderID/details'));

        debugPrint("***====== getMyOrderDetailsApi request ======*** $request");
        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());

        debugPrint(
            "***====== getMyOrderDetailsApi response ======*** ${response.body}\n");

        if (response.statusCode == 200) {
          return GetMyOrdersDetailsModel.fromJson(jsonDecode(response.body));
        } else {
          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();

        getAllOrdersBloc.getAllOrderstreamController.sink
            .addError(commonData.error);
      }
    } else {
      await pl.hide();

      getAllOrdersBloc.getAllOrderstreamController.sink
          .addError(commonData.noInternet);
    }
    return null;
  }

  Future<GeOrderProductsModel?> getOrderProductApi(
      ProgressLoader pl, var orderID) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'authToken': '${SpUtil.getString(SpConstUtil.authTokenV3)}'
        };
        var request = http.Request(
            'GET',
            Uri.parse(
                'https://api-b2b.bigcommerce.com/api/v3/io/orders/$orderID/products'));

        debugPrint("***====== getOrderProductApi request ======*** $request");
        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());

        debugPrint(
            "***====== getOrderProductApi response ======*** ${response.body}\n");

        if (response.statusCode == 200) {
          return GeOrderProductsModel.fromJson(jsonDecode(response.body));
        } else {
          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();

        getOrdersProductsBloc.getOrdersProductstreamController.sink
            .addError(commonData.error);
      }
    } else {
      await pl.hide();

      getOrdersProductsBloc.getOrdersProductstreamController.sink
          .addError(commonData.noInternet);
    }
    return null;
  }

  // Future<CheckoutModel?> checkoutApi(
  //     ProgressLoader pl,
  //     String cartid,
  //     BuildContext context,
  //     void Function() toggleTheme,
  //     List<Map<String, dynamic>> lineItems) async {
  //   bool internet = await checkInternet();
  //   if (internet) {
  //     try {
  //       var headers = {
  //         'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
  //         'Accept': 'application/json',
  //         'Content-Type': 'application/json'
  //       };
  //       var request = http.Request(
  //           'GET',
  //           Uri.parse(
  //               '${urls.v3baseUrl}${urls.checkouts}/$cartid?include=cart.line_items.physical_items.options,cart.line_items.digital_items.options,consignments.available_shipping_options,promotions.banners'));

  //       debugPrint("====checkoutApi request ===>$request");
  //       request.headers.addAll(headers);

  //       http.Response response =
  //           await http.Response.fromStream(await request.send());

  //       debugPrint("====checkoutApi response ===>${response.body}");

  //       if (response.statusCode == 200) {
  //         debugPrint(
  //             "==== iiii ====>>${jsonDecode(response.body)['data']['consignments']}");
  //         CheckoutModel checkoutModel =
  //             CheckoutModel.fromJson(jsonDecode(response.body));
  //         await Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => ShippingAddressScreen(
  //                       checkoutModel: checkoutModel,
  //                       toggleTheme: toggleTheme,
  //                     )));
  //         // await Navigator.push(
  //         //     context,
  //         //     MaterialPageRoute(
  //         //         builder: (context) => ShippingAddressScreen(
  //         //               checkoutModel: checkoutModel,
  //         //               toggleTheme: toggleTheme,
  //         //             )));
  //         // checkoutconsignmentsApi(pl, cartid, lineItems, context, toggleTheme);
  //         return CheckoutModel.fromJson(jsonDecode(response.body));
  //       } else {
  //         debugPrint(response.reasonPhrase);
  //       }
  //     } catch (e) {
  //       await pl.hide();

  //       await showToast(commonData.error);
  //     }
  //   } else {
  //     await pl.hide();
  //     await showToast(commonData.noInternet);
  //   }
  //   return null;
  // }

  Future<ConsignmentsModel?> checkoutconsignmentsApi(
      ProgressLoader pl,
      String cartid,
      List<Map<String, dynamic>> lineItems,
      BuildContext context,
      void Function() toggleTheme) async {
    debugPrint("==== lineItems ===>$lineItems");

    bool internet = await checkInternet();
    if (internet) {
      // try {
      var headers = {
        'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      var request = http.Request(
          'POST',
          Uri.parse(
              '${urls.v3baseUrl}${urls.checkouts}/$cartid/${urls.consignments}?include=cart.line_items.physical_items.options,cart.line_items.digital_items.options,consignments.available_shipping_options,promotions.banners'));

      debugPrint(
          "***====== checkoutconsignmentsApi request ======*** $request");
      request.body = json.encode([
        {
          "line_items": lineItems,
          "shipping_address": {
            "first_name": SpUtil.getString(SpConstUtil.firstName)!,
            "last_name": SpUtil.getString(SpConstUtil.lastName)!,
            "email": SpUtil.getString(SpConstUtil.userEmail)!,
            "company": SpUtil.getString(SpConstUtil.company)!,
            "address1": SpUtil.getString(SpConstUtil.address1)!,
            "address2": SpUtil.getString(SpConstUtil.address2)!,
            "city": SpUtil.getString(SpConstUtil.city)!,
            "state_or_province": SpUtil.getString(SpConstUtil.stateOrProvince)!,
            "country": SpUtil.getString(SpConstUtil.country)!,
            "country_code": SpUtil.getString(SpConstUtil.countryCode)!,
            "postal_code": SpUtil.getString(SpConstUtil.postalCode)!,
            "phone": SpUtil.getString(SpConstUtil.phone)!,
          },
        }
      ]);
      debugPrint(
          "***====== checkoutconsignmentsApi request body ======*** ${request.body}");
      request.headers.addAll(headers);

      http.Response response =
          await http.Response.fromStream(await request.send());

      debugPrint(
          "***====== checkoutconsignmentsApi response ======*** ${response.body}\n");

      if (response.statusCode == 200) {
        // await apis.checkoutApi(pl, cartid, context, toggleTheme);
        ConsignmentsModel checkoutModel =
            ConsignmentsModel.fromJson(jsonDecode(response.body));
        if (checkoutModel
            .data!.consignments![0].availableShippingOptions!.isNotEmpty) {
          await checkoutconsignmentsUpdateApi(
            pl,
            checkoutModel.data!.consignments![0].id!,
            cartid,
            toggleTheme,
            checkoutModel
                .data!.consignments![0].availableShippingOptions![2].id!,
            context,
          );
        } else {
          showToast(
              "Unfortunately one or more items in your cart can't be shipped to your location. Please choose a different delivery address.");
        }

        return ConsignmentsModel.fromJson(jsonDecode(response.body));
      } else {
        debugPrint(response.reasonPhrase);
      }
      // } catch (e) {
      //   await pl.hide();

      //   await showToast(commonData.error);
      // }
    } else {
      await pl.hide();
      await showToast(commonData.noInternet);
    }
    return null;
  }

  Future<CheckoutConsignmentsUpdateModel?> checkoutconsignmentsUpdateApi(
    ProgressLoader pl,
    String consignmentsid,
    String cartid,
    void Function() toggleTheme,
    String shippingOptionID,
    BuildContext context,
  ) async {
    debugPrint("***====== checkoutconsignmentsUpdateApi ======*** ");
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.Request(
            'PUT',
            Uri.parse(
                '${urls.v3baseUrl}checkouts/$cartid/consignments/$consignmentsid?includes=consignments.available_shipping_options'));

        debugPrint(
            "***====== checkoutconsignmentsUpdateApi request ======*** $request");
        request.body = json.encode({"shipping_option_id": shippingOptionID});
        debugPrint(
            "***====== checkoutconsignmentsUpdateApi request body ======*** ${request.body}");
        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());
        debugPrint(
            "***====== checkoutconsignmentsUpdateApi response.statusCode ======*** ${response.statusCode}\n");

        debugPrint(
            "***====== checkoutconsignmentsUpdateApi response ======*** ${response.body}\n");

        if (response.statusCode == 200) {
          await pl.hide();
          // await checkoutApi(pl, cartid, context, toggleTheme, lineItems);

          CheckoutConsignmentsUpdateModel checkoutModel =
              CheckoutConsignmentsUpdateModel.fromJson(
                  jsonDecode(response.body));

          debugPrint("***====== checkoutModel ======*** $checkoutModel");
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ShippingAddressScreen(
                        checkoutModel: checkoutModel,
                        toggleTheme: toggleTheme,
                      )));
          return CheckoutConsignmentsUpdateModel.fromJson(
              jsonDecode(response.body));
        } else {
          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();

        await showToast(commonData.error);
      }
    } else {
      await pl.hide();
      await showToast(commonData.noInternet);
    }
    return null;
  }

  Future<BillingCheckoutModel?> checkoutBillingApi(
      ProgressLoader pl,
      String cartid,
      String firstName,
      String lastName,
      String email,
      String company,
      String address1,
      String address2,
      String city,
      String stateorprovince,
      String stateorprovincecode,
      String countryCode,
      String postalCode,
      String phone,
      BuildContext context,
      void Function() toggleTheme) async {
    bool internet = await checkInternet();
    if (internet) {
      try {
        var headers = {
          'X-Auth-Token': '${SpUtil.getString(SpConstUtil.accessToken)}',
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
        var request = http.Request(
            'POST',
            Uri.parse(
                '${urls.v3baseUrl}${urls.checkouts}/$cartid/${urls.billingaddress}?include=cart.lineItems.physicalItems.options%2Ccart.lineItems.digitalItems.options%2Ccustomer%2Cpromotions.banners'));

        debugPrint("***====== checkoutBillingApi request ======*** $request");

        request.body = json.encode({
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "company": company,
          "address1": address1,
          "address2": address2,
          "city": city,
          "state_or_province": stateorprovince,
          "state_or_province_code": stateorprovincecode,
          "country_code": countryCode,
          "postal_code": postalCode,
          "phone": phone,
          "custom_fields": []
        });
        request.headers.addAll(headers);

        http.Response response =
            await http.Response.fromStream(await request.send());

        debugPrint(
            "***====== checkoutBillingApi response ======*** ${response.body}\n");

        if (response.statusCode == 200) {
          return BillingCheckoutModel.fromJson(jsonDecode(response.body));
        } else {
          debugPrint(response.reasonPhrase);
        }
      } catch (e) {
        await pl.hide();

        await showToast(commonData.error);
      }
    } else {
      await pl.hide();
      await showToast(commonData.noInternet);
    }
    return null;
  }
}

Apis apis = Apis();
