import 'package:base_project_flutter/api_services/ApiHelper.dart';
import 'package:base_project_flutter/constants/apiConstants.dart';
import 'package:flutter/material.dart';

class ServicesAPI {
  Future<dynamic> getServices(
    BuildContext context,
  ) async {
    var jsonMap;
    var headers = await ApiHelper().getHeader(context);
    var uri = SERVICES + headers['auth_code'];

    jsonMap = await ApiHelper().getTypeGet(context, uri);
    print(jsonMap);
    return jsonMap;
  }

  getEstimate(
    BuildContext context,
    Map<String, String> param,
    bool isSaveBooking 
  ) async {
    var headers = await ApiHelper().getHeader(context);
    var url = GET_ESTIMATE + headers['auth_code']+'&saveBooking='+isSaveBooking.toString();

    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  //Apply coupon 
   applyCoupon(
    BuildContext context,
    Map<String, String> param,
 
  ) async {
    var headers = await ApiHelper().getHeader(context);
    var url = APPLY_COUPON + headers['auth_code'];

    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
  //Apply coupon 
   removeCoupon(
    BuildContext context,
    Map<String, String> param,
 
  ) async {
    var headers = await ApiHelper().getHeader(context);
    var url = REMOVE_COUPON + headers['auth_code'];

    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
}
