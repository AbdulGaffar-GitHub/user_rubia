import 'dart:io';

import 'package:base_project_flutter/api_services/ApiHelper.dart';
import 'package:base_project_flutter/constants/apiConstants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/walletTransactionsModel.dart';

class UserAPI {
//Check API
  checkApi(String authCode) async {
    var client = http.Client();
    var url = apiBaseUrl + CHECK_API + authCode;
    var jsonMap;
    try {
      var response = await client.get(Uri.parse(url));
      print(response);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        jsonMap = json.decode(jsonString);
        return jsonMap;
      } else {
        print(response.statusCode);
      }
    } on SocketException {
      print("error");
    } catch (exception) {
      return jsonMap;
    }
  }

  //Send OTP
  sendOtp(
    BuildContext context,
    Map<String, String> param,
  ) async {
    var url = SEND_OTP;
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    return response;
  }

  //Verify OTP
  verifyOtp(
    BuildContext context,
    Map<String, String> param,
  ) async {
    var url = VERIFY_OTP;
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

//Emergency Contact
  emergenyContact(
    BuildContext context,
    Map<String, String> param,
  ) async {
    var headers = await ApiHelper().getHeader(context);
    var url = EMERGENCY_CONTACT_NUM + headers['auth_code'];

    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

//Apply referral
  applyReferral(
    BuildContext context,
    Map<String, String> param,
  ) async {
    var headers = await ApiHelper().getHeader(context);
    var url = APPLY_REFERRAL + headers['auth_code'];

    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  // CheckBoundary
  checkBoundary(
    BuildContext context,
    Map<String, String> param,
  ) async {
    var headers = await ApiHelper().getHeader(context);
    var url = CHECK_BOUNDARY + headers['auth_code'];

    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  //update latlng
  getUpdateLatLong(BuildContext context, String latitude, String longitude) async {
    var headers = await ApiHelper().getHeader(context);
    var url = UPDATE_LAT_LNG + headers['auth_code'];
    Map<String, String> params = {'latitude': latitude, 'longitude': longitude};
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  //personal Details
  personalDetails(
    BuildContext context,
    Map<String, String> param,
  ) async {
    var headers = await ApiHelper().getHeader(context);
    var url = PERSONAL_DETAILS + headers['auth_code'];

    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  updateProfilePic(BuildContext context, String profilePic) async {
    var headers = await ApiHelper().getHeader(context);
    var url = UPDATE_PROFILE_PIC + headers['auth_code'];

    Map<String, String> params = {
      'profile_image': profilePic,
    };
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  //LogOut
  getlogout(BuildContext context) async {
    var response;
    var jsonMap;
    var url;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var authCode = sharedPreferences.getString('authCode');
    var headers = await ApiHelper().getHeader(context);
    url = LOGOUT + headers['auth_code'];
    print(url);
    jsonMap = await ApiHelper().getTypeGet(context, url);
    response = jsonMap;
    await sharedPreferences.clear();
    sharedPreferences.remove(authCode!);
    print("User Signed Out");
    return response;
  }
//notifaction

  Future<dynamic> getMyNotifaction(
    BuildContext context,
    String page,
  ) async {
    var headers = await ApiHelper().getHeader(context);
    var uri = NOTIFICATION + headers['auth_code'] + '&page=' + page;
    // Map<String, String> params = param;
    var response = await ApiHelper().getTypeGet(
      context,
      uri,
    );
    print(response);
    return response;
  }

  //wallet
  // getWalletApi(BuildContext context) async {
  //   var jsonMap;
  //   var headers = await ApiHelper().getHeader(context);
  //   var uri = MY_WALLET_SUM + headers['auth_code'];
  //   jsonMap = await ApiHelper().getTypeGet(context, uri);
  //   var response = jsonMap;
  //   print(response);
  //   return response;
  // }
  emergencyContacts(
    BuildContext context,
  ) async {
    var headers = await ApiHelper().getHeader(context);
    var url = EMERGENCY_CONTACTS + headers['auth_code'];

    var response = await ApiHelper().getTypeGet(context, url);
    print(response);
    return response;
  }

  addEmergencyContacts(
    BuildContext context,
    Map<String, String> param,
  ) async {
    var headers = await ApiHelper().getHeader(context);
    var url = ADD_EMERGENCY + headers['auth_code'];

    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  editEmergencyContacts(
    BuildContext context,
    String id,
    Map<String, String> param,
  ) async {
    var headers = await ApiHelper().getHeader(context);
    var url = EDIT_EMERGENCY + headers['auth_code'] + '&id=' + id;

    Map<String, String> params = param;

    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  // refer and earn
  referEarnings(
    BuildContext context,
  ) async {
    var headers = await ApiHelper().getHeader(context);
    var url = REFER_EARN + headers['auth_code'];

    var response = await ApiHelper().getTypeGet(context, url);
    print(response);
    return response;
  }

  //VehicleType
  vehicleType(
    BuildContext context,
    String vehicleTypeId,
  ) async {
    var headers = await ApiHelper().getHeader(context);
    var url = VEHICLE_TYPES + headers['auth_code'];

    Map<String, String> params = {
      'type': vehicleTypeId,
    };

    var response = await ApiHelper().getTypePost(context, url, params);
    print("vehicleType");
    print(response);
    return response;
  }

  deleteEmergencyContacts(
    BuildContext context,
    String id,
  ) async {
    var headers = await ApiHelper().getHeader(context);
    var url = DELETE_EMERGENCY + headers['auth_code'] + '&id=' + id;

    Map<String, String> params = {
      'Id': id,
    };
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  // All transaction
  Future<WalletTransactionModel> allTranscations(BuildContext context, String page) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var startDate;
    var endDate;
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd 00:00:00');
    endDate = DateTime.now().add(Duration(days: 1));

    startDate = formatter.format(now);

    startDate = sharedPreferences.getString('startDate') != null ? sharedPreferences.getString('startDate') : startDate;
    endDate = sharedPreferences.getString('endDate') != null ? sharedPreferences.getString('endDate') : endDate;

    var jsonMap;
    var headers = await ApiHelper().getHeader(context);
    var url = ALL_TRANSACTIONS + headers['auth_code'];
    Map<String, String> params = {
      'page': page,
      'start_date': startDate.toString(),
      'end_date': endDate.toString(),
    };
    jsonMap = await ApiHelper().getTypePost(context, url, params);
    print(jsonMap);
    var response = WalletTransactionModel.fromJson(jsonMap);
    print(response);
    return response;
  }

  //All transaction without model
  walletTransactionWithoutModel(
    BuildContext context,
    String page,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var startDate;
    var endDate;
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd 00:00:00');
    endDate = DateTime.now().add(Duration(days: 1));

    startDate = formatter.format(now);

    startDate = sharedPreferences.getString('startDate') != null ? sharedPreferences.getString('startDate') : startDate;
    endDate = sharedPreferences.getString('endDate') != null ? sharedPreferences.getString('endDate') : endDate;

    var headers = await ApiHelper().getHeader(context);
    var url = ALL_TRANSACTIONS + headers['auth_code'];
    Map<String, String> params = {
      'page': page,
      'start_date': startDate.toString(),
      'end_date': endDate.toString(),
    };
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  //Available Balance wallet page
  Future<dynamic> walletAmount(
    BuildContext context,
  ) async {
    var jsonMap;
    var url;
    var headers = await ApiHelper().getHeader(context);
    url = WALLET_AMOUNT + headers['auth_code'];
    print(url);
    jsonMap = await ApiHelper().getTypeGet(context, url);
    print(jsonMap);
    return jsonMap;
  }
  //add money

  addMoneyApi(
    BuildContext context,
    Map<String, String> param,
  ) async {
    var headers = await ApiHelper().getHeader(context);
    var url = ADD_BALANCE + headers['auth_code'];
    print(url);
    print(param);
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  // favorite location list
  Future<dynamic> favoriteList(
    BuildContext context,
  ) async {
    var jsonMap;
    var url;
    var headers = await ApiHelper().getHeader(context);
    url = FAVORITE_LIST + headers['auth_code'];
    print(url);
    jsonMap = await ApiHelper().getTypeGet(context, url);
    print(jsonMap);
    return jsonMap;
  }

  // add favorite locatons
  createFavLocation(
    BuildContext context,
    Map<String, String> param,
  ) async {
    var headers = await ApiHelper().getHeader(context);
    var url = CREATE_FAVORITE + headers['auth_code'];

    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  //delete favourite location
  deleteFavLocations(
    BuildContext context,
    final favLocationId,
  ) async {
    var response;
    var jsonMap;
    var url;
    var headers = await ApiHelper().getHeader(
      context,
    );
    url = DELETE_FAVORITE + headers['auth_code'] + '&id=' + favLocationId;
    print(url);
    jsonMap = await ApiHelper().getTypeGet(context, url);
    response = jsonMap;
    print(response);
    return response;
  }

  //edit favorite location
  editFavLocation(BuildContext context, Map<String, String> param, editId) async {
    var headers = await ApiHelper().getHeader(context);
    var url = EDIT_FAVORITE + headers['auth_code'] + '&id=' + editId;

    Map<String, String> params = param;

    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  fetchCouponsList(BuildContext context, String page) async {
    var headers = await ApiHelper().getHeader(context);
    var url = COUPONS_LIST + headers['auth_code'] + '&page=' + page;
    Map<String, String> params = {};

    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  fetchBookingsList(BuildContext context, String page, String status, String vehicle_id) async {
    print("Hereeeee");

    var headers = await ApiHelper().getHeader(context);
    var url = BOOKINGS_LIST + headers['auth_code'] + '&page=' + page + "&status=" + status + "&vehicle_id=" + vehicle_id;
    Map<String, String> params = {};

    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  rideInfo(
    BuildContext context,
    String bookingId,
  ) async {
    print("Hereeeee");

    var headers = await ApiHelper().getHeader(context);
    var url = RIDE_INFO + headers['auth_code'];
    Map<String, String> params = {'booking_id': bookingId};

    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  viewBooking(
    BuildContext context,
    String bookingId,
  ) async {
    print("Hereeeee");

    var headers = await ApiHelper().getHeader(context);
    var url = VIEW_BOOKING + headers['auth_code'];
    Map<String, String> params = {'booking_id': bookingId};

    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  cancelRide(BuildContext context, String bookingId, String cancelReason) async {
    var headers = await ApiHelper().getHeader(context);
    var url = CANCEL_RIDE + headers['auth_code'];
    Map<String, String> params = {'booking_id': bookingId, 'cancel_reason': cancelReason};
    var response = await ApiHelper().getTypePost(context, url, params);
    print("response");
    print(response);
    return response;
  }

  // //booking list
  //   Future<dynamic> bookingList(
  //   BuildContext context,page,status
  // ) async {
  //   var jsonMap;
  //   var url;
  //   var headers = await ApiHelper().getHeader(context);
  //   url = BOOKINGS_LIST + headers['auth_code'] + '&page=' + page+'&status=';
  //   print(url);
  //   jsonMap = await ApiHelper().getTypeGet(context, url);
  //   print(jsonMap);
  //   return jsonMap;
  // }
  // rating and Review api
  myAddReview(BuildContext context, param) async {
    print("Hereeeee");

    var headers = await ApiHelper().getHeader(context);
    var url = ADD_REVIEW + headers['auth_code'];
    Map<String, String> params = param;

    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  Future<dynamic> reviewAndRating(
    BuildContext context,
    String page,
  ) async {
    var headers = await ApiHelper().getHeader(context);
    var uri = RATING_ADD_REVIEW + headers['auth_code'] + '&page=' + page;
    // Map<String, String> params = param;
    var response = await ApiHelper().getTypeGet(
      context,
      uri,
    );
    print(response);
    return response;
  }

  taxiRideInfo(
    BuildContext context,
    String rideId,
  ) async {
    var headers = await ApiHelper().getHeader(context);
    var uri = TAXI_RIDE_INFO + headers['auth_code'] + '&ride_id=' + rideId;
    // Map<String, String> params = param;
    var response = await ApiHelper().getTypeGet(
      context,
      uri,
    );
    print(response);
    return response;
  }

  getClearNotifaction(BuildContext context) async {
    var jsonMap;
    var headers = await ApiHelper().getHeader(context);
    var uri = NOTIFICATION_CLEAR + headers['auth_code'];
    jsonMap = await ApiHelper().getTypeGet(context, uri);
    var response = jsonMap;
    print(response);
    return response;
  }

  getBanners(BuildContext context) async {
    var jsonMap;
    var headers = await ApiHelper().getHeader(context);
    var uri = BANNER_WITH_CATEGORY + headers['auth_code'];
    jsonMap = await ApiHelper().getTypeGet(context, uri);
    var response = jsonMap;
    print(response);
    return response;
  }

  getVechiles(
    BuildContext context,
    Map<String, String> param,
  ) async {
    var headers = await ApiHelper().getHeader(context);
    var url = GET_VEHICLES + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  rideRequest(
    BuildContext context,
    Map<String, String> param,
  ) async {
    var headers = await ApiHelper().getHeader(context);
    var url = RIDE_REQUEST + headers['auth_code'];
    print(url);
    print(param);
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  Future<dynamic> rideCompletedDetails(BuildContext context, String rideId) async {
    var jsonMap;
    var headers = await ApiHelper().getHeader(context);
    var uri = RIDE_COMPLETION_DETAIL + headers['auth_code'];
    Map<String, String> params = {'ride_id': rideId};
    jsonMap = await ApiHelper().getTypePost(context, uri, params);
    print(jsonMap);
    return jsonMap;
  }

  //add rating
  addSkipperRating(
    BuildContext context,
    Map<String, String> param,
  ) async {
    var headers = await ApiHelper().getHeader(context);
    var url = SKIPPER_RATING + headers['auth_code'];
    print(url);
    print(param);
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  //cancel ride
  SkippercancelRide(
    BuildContext context,
    Map<String, String> param,
  ) async {
    var headers = await ApiHelper().getHeader(context);
    var url = SKIPPER_CANCEL_RIDE + headers['auth_code'];
    print(url);
    print(param);
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  downloadInvoice(
    BuildContext context,
    Map<String, String> param,
  ) async {
    var headers = await ApiHelper().getHeader(context);
    var url = DOWNLOAD_INNVOICE + headers['auth_code'];
    print(url);
    return url;
  }
}
