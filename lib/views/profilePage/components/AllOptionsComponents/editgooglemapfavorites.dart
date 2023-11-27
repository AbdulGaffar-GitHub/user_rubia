// // ignore_for_file: unused_local_variable

import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/views/profilePage/Components/AllOptionsComponents/FavoritesLocation.dart';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../../api_services/userApi.dart';
import '../../../../globalFuctions/globalFunctions.dart';
import '../../../../globalFuctions/googleMaps.dart';
import '../../../../globalWidgets/buttonWidget.dart';
import '../../../../globalWidgets/googleMapPage.dart';
import '../../../../globalWidgets/googleMapScreen.dart';
import '../../../../globalWidgets/textformfieldWidget.dart';
import '../../../../responsive.dart';
import 'package:intl/intl.dart';

import 'editFavoritesLocation.dart';

class editfavAddressGoogleMapPage extends StatefulWidget {
  editfavAddressGoogleMapPage(
      {Key? key,
      this.favLat,
      this.favLng,
      this.favAddress,
      this.favPincode,
      this.favAddressType,
      this.editfavoriteData})
      : super(key: key);
  final favLat;
  final favLng;
  final favAddress;
  final favPincode;
  final favAddressType;
  final editfavoriteData;
  static final kInitialPosition = LatLng(17.3850, 78.4867);

  @override
  _editfavAddressGoogleMapPageState createState() =>
      _editfavAddressGoogleMapPageState();
}

class _editfavAddressGoogleMapPageState
    extends State<editfavAddressGoogleMapPage> {
  PickResult? selectedPlace;
  late double lat;
  late double lng;
  late String formattedAddress;
  String? postalCode;
  String? pinCode;
  late String streetName1;
  late String streetName2;
  late String streetName3;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchFavLocation();
  }

  var favLocationDetails;
  var resNOK;
  fetchFavLocation() async {
    var response = await UserAPI().favoriteList(
      context,
    );
    if (response != null && response['status'] == 'OK') {
      setState(() {
        favLocationDetails = response['details'];
        print(favLocationDetails);
      });
    } else {
      resNOK = response['status'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: PlacePicker(
        apiKey: mapKey,
        hintText: 'find_a_place'.tr,
        searchingText: 'please wait'.tr,
        selectText: 'select_location'.tr,
        outsideOfPickAreaText: 'place_not_in_area'.tr,
        initialPosition: GoogleMapPage.kInitialPosition,
        useCurrentLocation: true,
        selectInitialPosition: true,
        usePinPointingSearch: true,
        usePlaceDetailSearch: true,
        onPlacePicked: (result) async {
          selectedPlace = result;
          print(result.toString());
          print(selectedPlace!.geometry!.location.lat);
          print(selectedPlace!.geometry!.location.lng);
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString(
              "formattedAddress", selectedPlace!.formattedAddress!);
          sharedPreferences.setDouble(
              "lattitude", selectedPlace!.geometry!.location.lat);
          sharedPreferences.setDouble(
              "longitude", selectedPlace!.geometry!.location.lng);
          formattedAddress = sharedPreferences.getString('formattedAddress')!;
          lat = sharedPreferences.getDouble('lattitude')!;
          lng = sharedPreferences.getDouble('longitude')!;
          print(selectedPlace!.addressComponents![0].types.length);
          print(formattedAddress);
          print(lat);
          print(lng);
          final coordinates = new Coordinates(lat, lng);

          try {
            var addresses = await Geocoder.google(mapKey)
                .findAddressesFromCoordinates(coordinates);
            print(addresses);

            var first = addresses.first;
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setDouble('pickUplat', lat);
            sharedPreferences.setDouble('pickUplng', lng);
            sharedPreferences.setString('pickUpAddress', formattedAddress);
            sharedPreferences.setString('FeatureName', first.featureName);
            var featureName = sharedPreferences.getString('FeatureName');
            sharedPreferences.setString('AddressLine', first.addressLine);
            var addressLine = sharedPreferences.getString('AddressLine');
            sharedPreferences.setString('Locality', first.locality);
            var locality = sharedPreferences.getString('Locality');
            sharedPreferences.setString('pickUpPinCode', first.postalCode);
            var pinCode = sharedPreferences.getString('pickUpPinCode');
            print(featureName);
            print(addressLine);
            print(locality);
            print(sharedPreferences.getString('pickUpAddress').toString());
            print('pinCode');
            print(pinCode);
            if (addresses.first.postalCode != null) {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  context: context,
                  builder: (context) => Container(
                        decoration: BoxDecoration(
                            color: tWhite,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        // height: MediaQuery.of(context).size.height / 2,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 2.h,
                              ),
                              favLocationDetails == null
                                  ? Container()
                                  : ListView.builder(
                                      itemCount: 1,
                                      physics: ScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var favLocationDetail =
                                            favLocationDetails[index];
                                        return GestureDetector(
                                          onTap: () {
                                            // showModalBottomSheet(
                                            //     isScrollControlled: true,
                                            //     backgroundColor: tWhite,
                                            //     shape: RoundedRectangleBorder(
                                            //         borderRadius:
                                            //             BorderRadius.only(
                                            //                 topLeft: Radius
                                            //                     .circular(30),
                                            //                 topRight:
                                            //                     Radius.circular(
                                            //                         30))),
                                            //     context: context,
                                            //     builder: (_) {
                                            //       return SelectAddresstitleBottomSheet(
                                            //         favAddress:
                                            //             sharedPreferences
                                            //                 .getString(
                                            //                     'pickUpAddress')
                                            //                 .toString(),
                                            //         favPincode:
                                            //             pinCode.toString(),
                                            //         favLat: lat.toString(),
                                            //         favLng: lng.toString(),
                                            //       );
                                            //     });
                                          },
                                          child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 4.w,
                                                  vertical: 0.6.h),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.w,
                                                  vertical: isTab(context)
                                                      ? 2.h
                                                      : 3.h),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: tReferColor,
                                                  boxShadow: [
                                                    tBackbtnBoxShadow
                                                  ]),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: tWhite),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  isTab(context)
                                                                      ? 10
                                                                      : 8.0),
                                                          child: Icon(
                                                            Icons.location_on,
                                                            color:
                                                                tDarkNavyblue,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 2.w,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                // Text(
                                                                //   // 'Other'.tr,
                                                                //   favLocationDetail[
                                                                //       'address_type'],
                                                                //   style: GoogleFonts.mulish(
                                                                //       color:
                                                                //           tSecondaryColor,
                                                                //       fontWeight:
                                                                //           FontWeight
                                                                //               .w700,
                                                                //       fontSize: isTab(
                                                                //               context)
                                                                //           ? 10.sp
                                                                //           : 12.sp),
                                                                // ),
                                                              ],
                                                            ),
                                                            Text(
                                                              formattedAddress,
                                                              // favLocationDetail[
                                                              //     'address'],
                                                              // '102 Spline Arcade, Aayyappa Soci..',
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts.mulish(
                                                                  color:
                                                                      tSecondaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: isTab(
                                                                          context)
                                                                      ? 8.sp
                                                                      : 11.sp),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            '',
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts.mulish(
                                                                color:
                                                                    tSecondaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: isTab(
                                                                        context)
                                                                    ? 8.sp
                                                                    : 10.sp),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )),
                                        );
                                      }),
                              SizedBox(
                                height: 2.h,
                              ),
                              Center(
                                child: SizedBox(
                                  width: isTab(context) ? 30.w : 50.w,
                                  height: isTab(context) ? 6.h : 7.h,
                                  child: ButtonWidget(
                                    borderSide:
                                        BorderSide(color: tPrimaryColor),
                                    color: tPrimaryColor,
                                    borderRadius: isTab(context) ? 10.0 : 8.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('save_as_favorite'.tr,
                                          style: GoogleFonts.mulish(
                                              color: tWhite,
                                              fontWeight: FontWeight.w700,
                                              fontSize: isTab(context)
                                                  ? 9.sp
                                                  : 14.sp)),
                                    ),
                                    onTap: (startLoading, stopLoading,
                                        btnState) async {
                                      Twl.forceNavigateTo(
                                          context,
                                          EditFavouritesLocation(
                                            editfavoriteData: formattedAddress,
                                            editmapdata: favLocationDetails[0],
                                          ));
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                            ],
                          ),
                        ),
                      ));
            } else {
              //
              return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('check_location'.tr),
                    content: Text('We_unable_to_get_your_Pincode'.tr),
                    actions: <Widget>[
                      TextButton(
                        child: Text('ok'),
                        onPressed: () {
                          Twl.navigateBack(context);
                        },
                      ),
                    ],
                  );
                },
              );
            }
          } catch (e) {
            throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(
                  'we_are_unable_to_find_your_pin_code_please_drag_the_place_picker'
                      .tr),
            ));
          }
        },
        region: 'in',
      )),
    );
  }
}
