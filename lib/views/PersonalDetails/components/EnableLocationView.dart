// ignore_for_file: deprecated_member_use
import 'package:android_intent_plus/android_intent.dart';
// import 'package:app_settings/app_settings.dart';

import 'package:base_project_flutter/api_services/userApi.dart';

import 'package:base_project_flutter/constants/constants.dart';

import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart' as locater;
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

class EnableLocationView extends StatefulWidget {
  EnableLocationView({Key? key, this.authCode}) : super(key: key);
  final authCode;
  @override
  _EnableLocationViewState createState() => _EnableLocationViewState();
}

class _EnableLocationViewState extends State<EnableLocationView> {
  // LatLng? _center;
  locater.Position? currentLocation;
  String? _currentAddress;
  bool isLoading = false;
  bool deliveryAddress = true;
  SharedPreferences? sharedPreferences;
  bool isLocationEnabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _checkGps();
    // locateUser();
    print('....Object');
    getUserLocation();
  }

  Future _checkGps() async {
    if (!(await locater.Geolocator.isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('cannot_get_current_location'.tr),
              content: Text('enable_gps_try_again'.tr),
              actions: <Widget>[
                ElevatedButton(
                  child: Text('ok'.tr),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tPrimaryColor,
                  ),
                  onPressed: () {
                    final AndroidIntent intent = AndroidIntent(
                        action: 'android.settings.LOCATION_SOURCE_SETTINGS');

                    intent.launch();

                    Navigator.of(context).pop();
                    getUserLocation();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future locateUser() async {
    setState(() {
      isLoading = true;
    });
    // if ((await locater.Geolocator.isLocationServiceEnabled())) {
    locater.Position position = await locater.Geolocator.getCurrentPosition(
        desiredAccuracy: locater.LocationAccuracy.high);
    final coordinates = new Coordinates(position.latitude, position.longitude);
    try {
      var addresses = await Geocoder.google(mapKey)
          .findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      setState(() {
        _currentAddress =
            "${first.locality}, ${first.featureName},${first.postalCode}, ${first.addressLine}";
      });
      //check delivery

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setDouble('lattitude', position.latitude);
      var lat = sharedPreferences.getDouble('lattitude');
      sharedPreferences.setDouble('longitude', position.longitude);
      var long = sharedPreferences.getDouble('longitude');
      sharedPreferences.setString('FeatureName', first.featureName);
      var featureName = sharedPreferences.getString('FeatureName');
      sharedPreferences.setString('AddressLine', first.addressLine);
      var addressLine = sharedPreferences.getString('AddressLine');
      sharedPreferences.setString('Locality', first.locality);
      var locality = sharedPreferences.getString('Locality');
      print('lat');
      print(lat);
      print('long');
      print(long);
      print('featureName');
      print(featureName);
      print('addressLine');
      print(addressLine);
      print('locality');
      print(locality);
      setState(() {
        isLoading = true;
      });
      var res = await UserAPI()
          .getUpdateLatLong(context, lat.toString(), long.toString());
      if (res != null && res['status'] == 'OK') {
        Twl.navigateTo(context, BottomNavigation());
      } else {
        Twl.createAlert(context, 'oops'.tr, res['error']);
      }
    } catch (e) {
      Twl.createAlert(context, 'error', e.toString());
      // Get.snackbar("error", e.toString());
    }
    // } else {
    //    _checkGps();
    // }
    //  await _checkGps();
  }

  getUserLocation() async {
    setState(() {
      isLoading = false;
    });
    currentLocation = await locateUser();

    // print('center $_center');
  }

  determinePosition() async {
    locater.LocationPermission permission;
    permission = await locater.Geolocator.checkPermission();
    if (permission == locater.LocationPermission.denied) {
      permission = await locater.Geolocator.requestPermission();
      if (permission == locater.LocationPermission.deniedForever) {
        //  locater.LocationPermission permission = await locater.Geolocator.requestPermission();
        await openAppSettings();
        return Future.error('location_not_available'.tr);
      }
    } else {
      return getUserLocation();
    }
    return await getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Twl.willpopAlert(context);
      },
      child: Scaffold(
        // backgroundColor: tLocation,
        body: Stack(
          children: [
            Center(
              child: isLoading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        if (currentLocation != null)
                          //Text(currentLocation.toString()),
                          Center(
                              child: Container(
                                  height: 30.h,
                                  width: 60.w,
                                  child: Lottie.asset(
                                      'assets/lottie/location_layer.json'))),
                        if (_currentAddress != null)
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: tDefaultPadding * 2),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: tDefaultPadding * 2),
                                decoration: BoxDecoration(
                                    color: tWhite,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    // Image.asset(
                                    //   'Images.LocationenableIcon',
                                    //   width: 30.w,
                                    // ),
                                    Center(
                                        child: Container(
                                            height: 30.h,
                                            width: 60.w,
                                            child: Lottie.asset(
                                                'assets/lottie/location_layer.json'))),
                                    SizedBox(
                                      height: tDefaultPadding,
                                    ),
                                    Text(
                                      deliveryAddress
                                          ? 'got_your_location'.tr
                                          : 'Unable to fetch this address'.tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize:
                                              isDesktop(context) ? 3.sp : 14.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: tDefaultPadding,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: tDefaultPadding * 2),
                                      child: Text(
                                        _currentAddress!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: isDesktop(context)
                                                ? 3.sp
                                                : 10.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    SizedBox(
                                      height: tDefaultPadding,
                                    ),
                                    deliveryAddress
                                        ? Container()
                                        : GestureDetector(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      tDefaultPadding * 2,
                                                  vertical:
                                                      tDefaultPadding / 2),
                                              decoration: BoxDecoration(
                                                  // gradient: tPrimaryGradientColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: Text(
                                                'change_location'.tr,
                                                style: TextStyle(
                                                  color: tWhite,
                                                ),
                                              ),
                                            ),
                                            onTap: () async {
                                              // Twl.navigateTo(
                                              //     context, GoogleMapPage());
                                            },
                                          )
                                  ],
                                ),
                              ),
                            ),
                          )
                        else
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: tDefaultPadding * 2),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: tDefaultPadding * 2),
                                decoration: BoxDecoration(
                                    color: tWhite,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    // Image.asset(
                                    //   'Images.LocationenableIcon',
                                    //   width: 30.w,
                                    // ),
                                    Center(
                                        child: Container(
                                            height: 30.h,
                                            width: 60.w,
                                            child: Lottie.asset(
                                                'assets/lottie/location_layer.json'))),
                                    SizedBox(
                                      height: tDefaultPadding,
                                    ),
                                    Text(
                                      'enable_your_location'.tr,
                                      style: TextStyle(
                                          fontSize:
                                              isDesktop(context) ? 3.sp : 14.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: tDefaultPadding,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: tDefaultPadding * 2),
                                      child: Text(
                                        'allow_to_use_location'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: isDesktop(context)
                                                ? 3.sp
                                                : 10.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    SizedBox(
                                      height: tDefaultPadding,
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: tDefaultPadding * 2,
                                            vertical: tDefaultPadding / 2),
                                        decoration: BoxDecoration(
                                            color: tPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Text(
                                          'enable_location'.tr,
                                          style: TextStyle(
                                            color: tWhite,
                                          ),
                                        ),
                                      ),
                                      onTap: () async {
                                        await determinePosition();
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        isLocationEnabled != null ? Container() : Container(),
                        //  ElevatedButton(
                        //     // elevation: 0,
                        //     // color: Colors.white,
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: tPrimaryColor,
                        //     ),
                        //     child: Text('app_settings'.tr),
                        //     onPressed: () => AppSettings.openAppSettings(
                        //         type: AppSettingsType.location),
                        //   ),
                      ],
                    )
                  : CircularProgressIndicator(),
            ),
            if (kIsWeb)
              Positioned(
                top: 20,
                right: 15,
                child: Container(
                  alignment: Alignment.centerRight,
                  // width: 30.w,
                  child: GestureDetector(
                    onTap: () {
                      Twl.navigateTo(context, BottomNavigation());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: isTab(context) ? 100 : 60,
                      height: isTab(context) ? 40 : 25,
                      decoration: BoxDecoration(
                          color: tWhite,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'skip'.tr,
                        style: TextStyle(color: tPrimaryColor, fontSize: 12.sp),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
