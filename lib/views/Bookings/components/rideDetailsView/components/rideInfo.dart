import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/providers/riderProvider.dart';
import 'package:base_project_flutter/views/RideBooking/RideEstimateInfo.dart';
import 'package:base_project_flutter/views/RideBooking/rideBill.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../constants/constants.dart';
import '../../../../../constants/imageConstant.dart';
import '../../../../../globalFuctions/globalFunctions.dart';
import '../../../../../globalWidgets/addressLocationCard.dart';
import '../../../../../globalWidgets/button.dart';
import '../../../../../globalWidgets/buttonIconWidget.dart';
import '../../../../../globalWidgets/buttonWidget.dart';
import '../../../../../globalWidgets/locationcard.dart';
import '../../../../../globalWidgets/rideDriverCard.dart';
import '../../../../../responsive.dart';
import '../../../../bottomNavigation.dart/bottomNavigation.dart';
import '../../../../profilePage/Components/support.dart';
import '../../riderDetailsPayment.dart';
import '../rideDetailsView.dart';

class RideInfo extends StatefulWidget {
  const RideInfo({Key? key, this.bookingDetails}) : super(key: key);

  final bookingDetails;

  @override
  State<RideInfo> createState() => _RideInfoState();
}

final TextEditingController _reasonController = TextEditingController();

class _RideInfoState extends State<RideInfo> {
  var details;
  var rideDetails;
  var resNOK;
  var viewbookingDetails;
  var usageText;
  usagehour() {
    double? usageHours = double.tryParse(
      widget.bookingDetails['usage_hours'].toString(),
    );

    if (usageHours != null) {
      if (usageHours >= 1) {
        int wholeHours = usageHours.toInt();
        int wholeMinutes = ((usageHours - wholeHours) * 60).toInt();
        if (wholeMinutes > 0) {
          usageText = '$wholeHours hrs $wholeMinutes mins ';
        } else {
          usageText = '$wholeHours hrs ';
        }
      } else {
        int usageMinutes = (usageHours * 60).toInt();
        usageText = '$usageMinutes mins ';
      }
    } else {
      usageText = 'Usage hours not available'; // Handle the case where 'usage_hours' is null
    }
  }

  getRideInfo() async {
    details = await UserAPI().rideInfo(context, widget.bookingDetails['id'].toString());
    if (details != null && details['status'] == 'OK') {
      setState(() {
        rideDetails = details['details'];
        print('rideDetailssssssss');
        print(rideDetails);
      });
      usagehour();
    } else {
      setState(() {
        resNOK = details['status'];
      });
    }
  }

  getViewBooking() async {
    details = await UserAPI().viewBooking(context, widget.bookingDetails['id'].toString());
    if (details != null && details['status'] == 'OK') {
      setState(() {
        viewbookingDetails = details['details'];
        print('rideDetailssssssss');
        print(viewbookingDetails);
      });
    } else {
      setState(() {
        resNOK = details['status'];
      });
    }
  }

  @override
  void initState() {
    getViewBooking();
    getRideInfo();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Status: ${widget.bookingDetails['status']}');
    print(
        'Should Show Cancel Button: ${widget.bookingDetails['status'] != STATUS_USER_CANCELLED && widget.bookingDetails['status'] != STATUS_START_RIDE}');
    // double? usageHours = double.tryParse(rideDetails['usage_hours'] ?? '');

    // String usageText;

    // if (usageHours != null) {
    //   if (usageHours >= 1) {
    //     int wholeHours = usageHours.toInt();
    //     int wholeMinutes = ((usageHours - wholeHours) * 60).toInt();
    //     if (wholeMinutes > 0) {
    //       usageText = '$wholeHours hrs $wholeMinutes mins ';
    //     } else {
    //       usageText = '$wholeHours hrs';
    //     }
    //   } else {
    //     int usageMinutes = (usageHours * 60).toInt();
    //     usageText = '$usageMinutes mins ';
    //   }
    // } else {
    //   usageText = ''; // Handle the case where 'usage_hours' is null
    // }
    final tripOptionsProvider = Provider.of<TripOptionsProvider>(context);

    return WillPopScope(
      onWillPop: () {
        return Twl.forceNavigateTo(
            context,
            RideDetailsPayment(
              bookingDetails: widget.bookingDetails,
            ));
      },
      child: Scaffold(
        backgroundColor: tWhite,
        appBar: AppBar(
          elevation: 1,
          titleSpacing: 7,
          backgroundColor: tappbarclr,
          leading: GestureDetector(
              onTap: () {
                Twl.forceNavigateTo(
                    context,
                    RideDetailsPayment(
                      bookingDetails: widget.bookingDetails,
                    ));
                // Twl.forceNavigateTo(
                //     context,
                //     BottomNavigation(
                //       tabIndexId: 1,
                //     ));
              },
              child: Padding(
                padding: EdgeInsets.all(isTab(context) ? 10 : 12.0),
                child: BackIconWidget(),
              )),
          title: Text(
            // 'Ride_Id '.tr + ': ' + rideDetails['id'].toString(),
            (rideDetails != null ? 'Ride_Id '.tr + ': ' + rideDetails['id'].toString() : 'Ride_Id '.tr + ': ' + ''),
            style: TextStyle(
              color: tSecondaryColor,
              fontFamily: "mulish",
              fontSize: isTab(context) ? 10.sp : 17.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: rideDetails == null
            ? Container(
                child: Align(
                    alignment: Alignment.center,
                    child: SpinKitThreeBounce(
                      color: tPrimaryColor,
                      size: 20.0,
                    )),
              )
            : SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   color: tappbarclr,
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(
                  //         horizontal: 3.5.w, vertical: 1.3.h),
                  //     child: Text(
                  //       'Ride_Id '.tr + ':' + rideDetails['id'].toString(),
                  //       style: TextStyle(
                  //           color: tSecondaryColor,
                  //           fontWeight: FontWeight.w600,
                  //           fontSize: 12.sp),
                  //     ),
                  //   ),
                  // ),
                  Column(
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      GestureDetector(
                        // onTap: () {
                        //   Twl.navigateTo(context, RideDetailsView(rideDetails:widget.bookingDetails));
                        // },
                        child: rideDetails['status'] != STATUS_WAITING_FOR_DRIVER
                            ? RideDriverCard(rideDetails: rideDetails)
                            : Text(
                                'waiting_for_driver_'.tr,
                                style: TextStyle(color: tPrimaryColor, fontWeight: FontWeight.w600, fontSize: 12.sp),
                              ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      GestureDetector(
                        //   onTap: () {
                        //   Twl.navigateTo(context, RideDetailsView(rideDetails:widget.bookingDetails));
                        // },
                        child: Container(
                          decoration: BoxDecoration(color: tWhite, boxShadow: [tBoxShadow], borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(isTab(context) ? 12 : 8),
                                        decoration: BoxDecoration(color: tBackground, shape: BoxShape.circle),
                                        child: Image.asset(
                                          Images.GREENLOCATIONICON,
                                          scale: isTab(context) ? 2 : 3.5,
                                        )),
                                    if (rideDetails['rider_type'] == 1)
                                      DottedLine(
                                        direction: Axis.vertical,
                                        lineLength: 30,
                                        lineThickness: 1.0,
                                        dashLength: 4.0,
                                        dashColor: tDotted,
                                        dashGapLength: 4.0,
                                        dashGapRadius: 0.0,
                                      ),
                                    if (rideDetails['rider_type'] == 1)
                                      Container(
                                          padding: EdgeInsets.all(isTab(context) ? 12 : 8),
                                          decoration: BoxDecoration(color: tBackground, shape: BoxShape.circle),
                                          child: Image.asset(
                                            Images.REDLOCATIONICON,
                                            scale: isTab(context) ? 2 : 3.5,
                                          )),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        rideDetails['pickup_address'].toString(),
                                        // 'Shrvan assigned as a driver',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.mulish(
                                          color: tDarkNavyblue,
                                          fontWeight: FontWeight.w600,
                                          fontSize: isTab(context) ? 9.sp : 11.sp,
                                        ),
                                      ),
                                      // TextFormField(
                                      //   controller: _searchController
                                      //   ..text = widget.locationData['pickup_address'].toString(),
                                      //   // onTap: () {
                                      //   //   Twl.forceNavigateTo(context, PickupAddressGoogleMapPage(status: widget.status,));
                                      //   // },
                                      //   decoration: InputDecoration(
                                      //     hintStyle: GoogleFonts.mulish(
                                      //       color: tDarkNavyblue,
                                      //       fontSize: isTab(context) ? 9.sp : 11.sp,
                                      //       fontWeight: FontWeight.w600,
                                      //     ),
                                      //     hintText: 'Pickup Location',
                                      //     fillColor: tBackground,
                                      //     filled: false,
                                      //     border: InputBorder.none,
                                      //   ),
                                      // ),
                                      // VerticalDivider(
                                      //   width: 10,
                                      //   color: tRed,
                                      //   indent: 30,
                                      // ),
                                      if (rideDetails['rider_type'] == 1)
                                        Divider(
                                          height: 4.h,
                                          thickness: 0.9,
                                          color: tDividerColor,
                                        ),
                                      // TextFormField(
                                      //   controller: _destinationController
                                      //     ..text = widget.locationData['drop_address'].toString(),
                                      //   // ..text = widget.dropAddress.toString(),
                                      //   // onTap: () {
                                      //   //   Twl.forceNavigateTo(
                                      //   //       context,
                                      //   //       DropGoogleMap(
                                      //   //         status: widget.status,
                                      //   //       ));
                                      //   // },
                                      //   decoration: InputDecoration(
                                      //     hintStyle: GoogleFonts.mulish(
                                      //       color: tDarkNavyblue,
                                      //       fontSize: isTab(context) ? 9.sp : 11.sp,
                                      //       fontWeight: FontWeight.w600,
                                      //     ),
                                      //     hintText: 'Drop Location',
                                      //     fillColor: tBackground,
                                      //     filled: false,
                                      //     border: InputBorder.none,
                                      //   ),
                                      // )
                                      if (rideDetails['rider_type'] == 1)
                                        Text(
                                          rideDetails['drop_address'].toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          // 'Shrvan assigned as a driver',
                                          style: GoogleFonts.mulish(
                                            color: tDarkNavyblue,
                                            fontWeight: FontWeight.w600,
                                            fontSize: isTab(context) ? 9.sp : 11.sp,
                                          ),
                                        )
                                      // Container(
                                      //     child: Text(
                                      //   'Secunderabad Railway Station, Secunderabad, Telangana (500081)',
                                      //   // rideDetails.dropAddress.toString(),
                                      //   textAlign: TextAlign.start,
                                      //   style: GoogleFonts.mulish(
                                      //     color: tDarkNavyblue,
                                      //     fontWeight: FontWeight.w600,
                                      //     fontSize: isTab(context) ? 8.sp : 10.sp,
                                      //   ),
                                      // )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //  LocationCards(rideDetails: rideDetails)
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            // expand: false,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                                child: Container(
                                    height: 100.h,
                                    // height: MediaQuery.of(context).size.height / 1,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                    child: RideBill(viewbookingDetails: viewbookingDetails))),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.5.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'estimate_fare'.tr,
                                    style: GoogleFonts.mulish(
                                      color: tSecondaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: isTab(context) ? 8.sp : 14.sp,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        size: 15,
                                        color: tDate,
                                      ),
                                      SizedBox(height: 2.h)
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                currencySymbol + rideDetails['estimate_price'].toString(),
                                style: GoogleFonts.inter(
                                  color: tPrimaryColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: isTab(context) ? 16.sp : 20.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                        decoration: BoxDecoration(color: tWhite, borderRadius: BorderRadius.circular(10), boxShadow: [tBoxShadow]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  Images.CALENDER,
                                  scale: isTab(context) ? 2 : 3.5,
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Text(
                                  Twl.dateActualFormate(rideDetails['pickup_date']).toString() + ', ' + rideDetails['pickup_time'].toString(),
                                  style: GoogleFonts.mulish(
                                    color: tSecondaryColor,
                                    fontSize: isTab(context) ? 12.sp : 12.sp,
                                    fontWeight: FontWeight.w700,
                                    // fontFamily:
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 5.h,
                              width: 0.4.w,
                              color: tSecondaryColor,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  Images.TIMER,
                                  scale: isTab(context) ? 2 : 3.5,
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                rideDetails['usage_hours'] == null
                                    ? Container()
                                    : Text(
                                        usageText,
                                        style: GoogleFonts.mulish(
                                          color: tSecondaryColor,
                                          fontSize: isTab(context) ? 12.sp : 12.sp,
                                          fontWeight: FontWeight.w700,
                                          // fontFamily:
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
                        decoration: BoxDecoration(color: tWhite, borderRadius: BorderRadius.circular(10), boxShadow: [tBoxShadow]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  Images.OUT_STATION,
                                  scale: isTab(context) ? 7 : 7.5,
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                rideDetails['trip_type'] == 1
                                    ? Text(
                                        'in_city'.tr,
                                        style: GoogleFonts.mulish(
                                          color: tSecondaryColor,
                                          fontSize: isTab(context) ? 12.sp : 12.sp,
                                          fontWeight: FontWeight.w700,
                                          // fontFamily:
                                        ),
                                      )
                                    : Text(
                                        'out_station'.tr,
                                        style: GoogleFonts.mulish(
                                          color: tSecondaryColor,
                                          fontSize: isTab(context) ? 12.sp : 12.sp,
                                          fontWeight: FontWeight.w700,
                                          // fontFamily:
                                        ),
                                      ),
                              ],
                            ),
                            Container(
                              height: 5.h,
                              width: 0.4.w,
                              color: tSecondaryColor,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  Images.ROUND_TRIP,
                                  scale: isTab(context) ? 2 : 3.5,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                rideDetails['rider_type'] == 1
                                    ? Text(
                                        'one_way'.tr,
                                        style: GoogleFonts.mulish(
                                          color: tSecondaryColor,
                                          fontSize: isTab(context) ? 12.sp : 12.sp,
                                          fontWeight: FontWeight.w700,
                                          // fontFamily:
                                        ),
                                      )
                                    : Text(
                                        'round'.tr,
                                        style: GoogleFonts.mulish(
                                          color: tSecondaryColor,
                                          fontSize: isTab(context) ? 12.sp : 12.sp,
                                          fontWeight: FontWeight.w700,
                                          // fontFamily:
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.w),
                        decoration: BoxDecoration(color: tWhite, boxShadow: [tBackbtnBoxShadow], borderRadius: BorderRadiusDirectional.circular(10)),
                        child: Row(
                          children: [
                            Image.asset(
                              Images.CAR,
                              scale: isTab(context) ? 2 : 3.5,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              rideDetails['car_model'],
                              style: GoogleFonts.mulish(
                                color: tSecondaryColor,
                                fontSize: isTab(context) ? 12.sp : 12.sp,
                                fontWeight: FontWeight.w700,
                                // fontFamily:
                              ),
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Text(
                              rideDetails['car_type'].toString() == '1' ? '(Automatic)' : '(Manual)',
                              style: GoogleFonts.mulish(
                                color: tSecondaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: isTab(context) ? 9.sp : 11.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      CustomerSupport(),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: SizedBox(
                              width: isTab(context) ? 50.w : 50.w,
                              height: isTab(context) ? 6.h : 7.h,
                              child: widget.bookingDetails['status'] != STATUS_USER_CANCELLED && widget.bookingDetails['status'] != STATUS_START_RIDE
                                  ? ButtonWidget(
                                      borderSide: BorderSide(
                                        color: tCancelRidebtn,
                                      ),
                                      color: tCancelRidebtn,
                                      child: Text(
                                        "cancel_ride".tr,
                                        style: GoogleFonts.mulish(
                                          color: tWhite,
                                          fontWeight: FontWeight.w800,
                                          fontSize: isTab(context) ? 10.sp : 16.sp,
                                        ),
                                      ),
                                      borderRadius: 8.0,
                                      onTap: (startLoading, stopLoading, btnState) async {
                                        showModalBottomSheet(
                                          isScrollControlled: true,
                                          // expand: false,
                                          context: context,
                                          backgroundColor: Colors.transparent,
                                          builder: (context) => Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 0),
                                              child: CancelRideBottomSheet(bookingDetails: widget.bookingDetails)),
                                        );
                                      })
                                  : Container()),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                    ],
                  ),
                ]),
              ),
      ),
    );
  }
}

class CancelRideBottomSheet extends StatefulWidget {
  const CancelRideBottomSheet({Key? key, this.bookingDetails}) : super(key: key);
  final bookingDetails;

  @override
  State<CancelRideBottomSheet> createState() => _CancelRideBottomSheetState();
}

class _CancelRideBottomSheetState extends State<CancelRideBottomSheet> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: MediaQuery.of(context).viewInsets,
        decoration: BoxDecoration(
            color: tWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [tBoxShadow]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 4.h,
          ),
          Container(
            // width: 80.w,
            //  padding: EdgeInsets.symmetric(),
            child: Text(
              'confirm_your_cancellation'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(color: tSecondaryColor, fontFamily: "mulish", fontSize: isTab(context) ? 10.sp : 15.sp, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Container(
            width: 80.w,
            child: Text(
              'Cancellation of rides is subject to a fee as per our policy.',
              textAlign: TextAlign.center,
              style: TextStyle(color: tDarkOrangeColor, fontFamily: "mulish", fontSize: isTab(context) ? 10.sp : 11.sp, fontWeight: FontWeight.w400),
            ),
          ),
          // Spacer(),
          SizedBox(
            height: 9.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Checkbox(
                activeColor: tPrimaryColor,
                value: _isChecked,
                onChanged: (value) {
                  setState(() {
                    _isChecked = value!;
                  });
                },
              ),
              Container(
                // width: 80.w,
                child: Text(
                  'i_agree_to_the'.tr,
                  style: GoogleFonts.mulish(
                    color: tSecondaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: isTab(context) ? 8.sp : 12.sp,
                  ),
                ),
              ),
              Container(
                // width: 80.w,
                child: Text(
                  'terms_conditions'.tr,
                  style: GoogleFonts.mulish(
                    color: tappbarclr,
                    fontWeight: FontWeight.w600,
                    fontSize: isTab(context) ? 8.sp : 12.sp,
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox(
                width: isTab(context) ? 50.w : 50.w,
                height: isTab(context) ? 6.h : 7.h,
                child: ButtonWidget(
                    borderSide: BorderSide(
                      color: tCancelRidebtn,
                    ),
                    color: tCancelRidebtn,
                    child: Text(
                      "cancel_ride".tr,
                      style: GoogleFonts.mulish(
                        color: tWhite,
                        fontWeight: FontWeight.w800,
                        fontSize: isTab(context) ? 10.sp : 16.sp,
                      ),
                    ),
                    borderRadius: 8.0,
                    onTap: (startLoading, stopLoading, btnState) async {
                      if (_isChecked == true) {
                        Twl.navigateBack(context);
                        showModalBottomSheet(
                            // expand: false,
                            isScrollControlled: true,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => CancelReasonWidget(bookingDetails: widget.bookingDetails));
                      } else {
                        stopLoading();
                        Twl.createAlert(context, 'Oops', 'Accept Terms & Conditions');
                        stopLoading();
                      }
                    }),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class CancelReasonWidget extends StatefulWidget {
  const CancelReasonWidget({Key? key, this.bookingDetails}) : super(key: key);
  final bookingDetails;

  @override
  State<CancelReasonWidget> createState() => _CancelReasonWidgetState();
}

class _CancelReasonWidgetState extends State<CancelReasonWidget> {
  TextEditingController _descriptionController = TextEditingController();
  var reasonSelectedValue;
  var selectedIndex;
  bool selectedDropDown = false;
  // final List<String> reasonsList = [
  //   'unsafe_Pickup_area'.tr,
  //   "unable_To_Swipe_Arrived".tr,
  //   'wrong_Pickup_Location'.tr,
  //   'long_Pickup'.tr,
  // ];
  List reasonsList = [
    {
      "id": 0,
      "value": false,
      "title": "unsafe_Pickup_area".tr,
    },
    {
      "id": 1,
      "value": false,
      "title": "unable_To_Swipe_Arrived".tr,
    },
    {
      "id": 2,
      "value": false,
      "title": "wrong_Pickup_Location".tr,
    },
    {
      "id": 3,
      "value": false,
      "title": "long_Pickup".tr,
    },
  ];
  var selectedCancelReason;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: MediaQuery.of(context).viewInsets,
        decoration: BoxDecoration(
            color: tWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [tBoxShadow]),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'cancel_ride'.tr,
                  style: GoogleFonts.lexend(color: tSecondaryColor, fontWeight: FontWeight.w600, fontSize: isTab(context) ? 8.sp : 13.sp),
                ),
              ),
              SizedBox(
                height: 0.8.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Please_select_Reason'.tr,
                  style: GoogleFonts.lexend(color: tDarkOrangeColor, fontWeight: FontWeight.w600, fontSize: isTab(context) ? 8.sp : 11.sp),
                ),
              ),
              Divider(
                color: tDividerColor,
                height: 3.5.h,
                thickness: 0.9,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 0,
                ),
                child: Column(
                  children: List.generate(
                    reasonsList.length,
                    (index) => Theme(
                      data: Theme.of(context).copyWith(unselectedWidgetColor: tSecondaryColor, disabledColor: Colors.green),
                      child: RadioListTile(
                        value: index,
                        activeColor: tPrimaryColor,
                        groupValue: selectedIndex,
                        onChanged: (ind) {
                          setState(() => selectedIndex = ind);
                          print('selectedIndex');
                          print(reasonsList[index]["title"]);
                          print(reasonsList[index]["id"]);
                        },
                        title: Text(
                          reasonsList[index]["title"],
                          style: GoogleFonts.lexend(color: tBlack, fontSize: isTab(context) ? 10.sp : 13.sp, fontWeight: FontWeight.w500),
                        ),
                        //groupValue: value,
                        // controlAffinity:
                        //     ListTileControlAffinity.leading,
                        // contentPadding: EdgeInsets.zero,
                        // activeColor: tSecondaryColor,
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(8)),
                        // dense: true,
                        // title: Text(
                        //   checkListItems[index]["title"],
                        //   style: TextStyle(
                        //       color: tBlack,
                        //       fontSize: isTab(context) ? 10.sp : 12.sp,
                        //       fontWeight: FontWeight.w500),
                        // ),
                        // value: checkListItems[index]["value"],
                        // onChanged: (value) {
                        //   setState(() {
                        //     selectedIndex = index;
                        //     fromtimeSelectedValue =
                        //         checkListItems[selectedIndex]["title"];
                        //     print(fromtimeSelectedValue);

                        //     checkListItems[index]["value"] = value;

                        //   });
                        // },
                      ),
                    ),
                  ),
                ),

                //  ListTile(
                //   trailing: Theme(
                //     data: Theme.of(context)
                //         .copyWith(unselectedWidgetColor: tPrimaryColor),
                //     child: Radio(
                //       activeColor: tPrimaryColor,
                //       value: index,
                //       groupValue: reasonSelectedValue,
                //       onChanged: (value) {
                //         setState(() {
                //           reasonSelectedValue = value as int;
                //           selectedCancelReason = reasonsList[index];
                //           print(selectedCancelReason.toString());
                //         });
                //       },
                //     ),
                //   ),
                //   title: Text(
                //     reasonsList[index]["title"].toString(),
                //     style: GoogleFonts.lexend(
                //         color: tSecondaryColor,
                //         fontWeight: FontWeight.w600,
                //         fontSize: isTab(context) ? 8.sp : 11.sp),
                //   ),
                // ),
              ),
              // ListView.builder(
              //   shrinkWrap: true,
              //   itemCount: reasonsList.length,
              //   scrollDirection: Axis.vertical,
              //   physics: ScrollPhysics(),
              //   itemBuilder: (context, index) {
              //     return
              //      GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             selectedIndex = index;
              //             reasonSelectedValue = index;
              //             selectedCancelReason = reasonsList[index];
              //             print(selectedCancelReason.toString());
              //           });
              //         },
              //         child: Container(
              //           margin: EdgeInsets.symmetric(
              //             vertical: 0,
              //           ),
              //           child: Column(
              //             children: List.generate(
              //               reasonsList.length,
              //               (index) => Theme(
              //                 data: Theme.of(context).copyWith(
              //                     unselectedWidgetColor: tSecondaryColor,
              //                     disabledColor: Colors.green),
              //                 child: RadioListTile(
              //                   value: index,
              //                   activeColor: tPrimaryColor,
              //                   groupValue: selectedIndex,
              //                   onChanged: (ind) {
              //                     setState(() => selectedIndex = ind);
              //                   },
              //                   title: Text(
              //                     reasonsList[index]["title"],
              //                     style: GoogleFonts.lexend(
              //                         color: tBlack,
              //                         fontSize: isTab(context) ? 10.sp : 13.sp,
              //                         fontWeight: FontWeight.w500),
              //                   ),
              //groupValue: value,
              // controlAffinity:
              //     ListTileControlAffinity.leading,
              // contentPadding: EdgeInsets.zero,
              // activeColor: tSecondaryColor,
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(8)),
              // dense: true,
              // title: Text(
              //   checkListItems[index]["title"],
              //   style: TextStyle(
              //       color: tBlack,
              //       fontSize: isTab(context) ? 10.sp : 12.sp,
              //       fontWeight: FontWeight.w500),
              // ),
              // value: checkListItems[index]["value"],
              // onChanged: (value) {
              //   setState(() {
              //     selectedIndex = index;
              //     fromtimeSelectedValue =
              //         checkListItems[selectedIndex]["title"];
              //     print(fromtimeSelectedValue);

              //     checkListItems[index]["value"] = value;

              //   });
              // },
              //       ),
              //     ),
              //   ),
              // ),

              //  ListTile(
              //   trailing: Theme(
              //     data: Theme.of(context)
              //         .copyWith(unselectedWidgetColor: tPrimaryColor),
              //     child: Radio(
              //       activeColor: tPrimaryColor,
              //       value: index,
              //       groupValue: reasonSelectedValue,
              //       onChanged: (value) {
              //         setState(() {
              //           reasonSelectedValue = value as int;
              //           selectedCancelReason = reasonsList[index];
              //           print(selectedCancelReason.toString());
              //         });
              //       },
              //     ),
              //   ),
              //   title: Text(
              //     reasonsList[index]["title"].toString(),
              //     style: GoogleFonts.lexend(
              //         color: tSecondaryColor,
              //         fontWeight: FontWeight.w600,
              //         fontSize: isTab(context) ? 8.sp : 11.sp),
              //   ),
              // ),
              //         ));
              //   },
              // ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: TextFormField(
                  controller: _descriptionController,
                  maxLines: isTab(context) ? 4 : 3,
                  decoration: InputDecoration(
                      fillColor: tWhite,
                      filled: true,
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(width: 1.5, color: tgreen)),
                      // hintText: 'Write Reason ( Optional )',
                      hintStyle: TextStyle(color: tGray, fontSize: isTab(context) ? 7.sp : 10.sp, fontWeight: FontWeight.w400),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: tgreen, width: 1.5))),
                ),
              ),
              SizedBox(
                height: 2.5.h,
              ),
              // Center(
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(horizontal: 18.w),
              //     child: Button(
              //         textcolor: tWhite,
              //         borderSide: BorderSide(color: tPrimaryColor),
              //         bottonText: 'Submit'.tr,
              //         color: tPrimaryColor,
              //         onTap: (startLoading, stopLoading, btnState) async {}),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: SizedBox(
                    width: isTab(context) ? 50.w : 60.w,
                    height: isTab(context) ? 6.h : 7.h,
                    child: ButtonWidget(
                        borderSide: BorderSide(
                          color: tPrimaryColor,
                        ),
                        color: tPrimaryColor,
                        child: Text(
                          "Submit".tr,
                          style: GoogleFonts.mulish(
                            color: tWhite,
                            fontWeight: FontWeight.w800,
                            fontSize: isTab(context) ? 10.sp : 16.sp,
                          ),
                        ),
                        borderRadius: 8.0,
                        onTap: (startLoading, stopLoading, btnState) async {
                          String reason;
                          if (selectedIndex != null) {
                            reason = reasonsList[selectedIndex]["title"];
                          } else {
                            reason = _descriptionController.text;
                            print(reason);
                          }

                          // var res = await UserAPI()
                          //     .cancelRide(
                          //         context,
                          //         widget.appointmentDetails.id.toString(),
                          //         STATUS_CANCELLED_BY_OWNER.toString(),
                          //         reason,
                          //         _reasonController.text);
                          var res = await UserAPI().cancelRide(context, widget.bookingDetails['id'].toString(), reason.toString()
                              // STATUS_USER_CANCELLED.toString()
                              );
                          print(res);
                          _descriptionController.clear();
                          if (res != null && res['status'] == 'OK') {
                            stopLoading();
                            setState(() {
                              Twl.forceNavigateTo(
                                  context,
                                  BottomNavigation(
                                    tabIndexId: 1,
                                  ));
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Service has been rejected'),
                            ));
                          }
                          // else {
                          //   stopLoading();
                          //   print('hello');
                          //   return Twl.createAlert(
                          //       context, "error", ' errormsg');
                          // }
                          else {
                            stopLoading();

                            return Twl.createAlert(context, 'Oops', res['error']);
                          }
                          stopLoading();
                        }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
