import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:base_project_flutter/views/dummy.dart';
import 'package:base_project_flutter/views/homePage/components/confirmride.dart';
import 'package:base_project_flutter/views/homePage/components/coupon.dart';
import 'package:base_project_flutter/views/homePage/components/coupons.dart';
import 'package:base_project_flutter/views/homePage/components/orderPlaced.dart';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../api_services/servicesApi.dart';
import '../../../constants/constants.dart';
import '../../../constants/imageConstant.dart';
import '../../../globalFuctions/globalFunctions.dart';
import '../../../globalWidgets/buttonIconWidget.dart';
import '../../../globalWidgets/buttonWidget.dart';
import '../../../globalWidgets/locationcard.dart';
import '../../../globalWidgets/priceListWidget.dart';
import '../../../providers/riderProvider.dart';
import '../../../responsive.dart';
import '../../RideBooking/RideEstimateInfo.dart';
import 'paymentSelection.dart';
import 'package:intl/intl.dart';
import 'package:awesome_number_picker/awesome_number_picker.dart';

class OneWay extends StatefulWidget {
  const OneWay({Key? key}) : super(key: key);

  @override
  State<OneWay> createState() => _OneWayState();
}

class _OneWayState extends State<OneWay> {
  int _currentHorizontalIntValue = 10;
  int integerValue = 0;
  double decimalValue = 0;
  var onSelected;
  bool _isChecked = false;
  List hoursList = [1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5, 5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12];

  String _formatTime(String time) {
    final parsedTime = TimeOfDay(
      hour: int.parse(time.split(':')[0]),
      minute: int.parse(time.split(':')[1]),
    );
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, parsedTime.hour, parsedTime.minute);
    final formattedTime = DateFormat.jm().format(dateTime);
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    final tripOptionsProvider = Provider.of<TripOptionsProvider>(context);

    String estimateFare = tripOptionsProvider.estimateFare.toString();
    String couponDiscount = tripOptionsProvider.couponDiscount.toString();

    // double parsedEstimateFare = 0.0;
    // double parsedCouponDiscount = 0.0;
    // try {
    //   parsedEstimateFare = double.parse(estimateFare);
    // } catch (e) {
    //   print('Error parsing estimateFare: $e');
    //   // Handle the error here, such as providing a fallback value or showing an error message
    //   // For example:
    //   // parsedEstimateFare = 0.0;
    // }
    // if (couponDiscount != null) {
    //   couponDiscount = couponDiscount.trim();
    //   try {
    //     parsedCouponDiscount = double.parse(couponDiscount);
    //   } catch (e) {
    //     if (couponDiscount == '0' || couponDiscount == 'null') {
    //       parsedCouponDiscount = 0.0;
    //       tripOptionsProvider
    //           .setCouponDiscount(parsedCouponDiscount.toString());
    //     } else {
    //       print('Error parsing couponDiscount: $e');
    //       // Handle the error as needed
    //     }
    //   }
    // } else {
    //   // Handle the case where couponDiscount is null
    //   // For example:
    //   parsedCouponDiscount = 0.0;
    // }
    // final double finalFare = parsedEstimateFare - parsedCouponDiscount;

    // tripOptionsProvider.setFinalFare(finalFare);

    return WillPopScope(
      onWillPop: () {
        tripOptionsProvider.resetProviderValues();
        return Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 0));
      },
      child: Scaffold(
        backgroundColor: tWhite,
        appBar: AppBar(
          backgroundColor: tWhite,
          centerTitle: true,
          title: Text(
            tripOptionsProvider.riderType == RIDER_TYPE_ONEWAY ? 'one_way'.tr : 'round'.tr,
            style: GoogleFonts.mulish(
              color: tSecondaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              tripOptionsProvider.resetProviderValues();
              Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 0));
            },
            child: Padding(
              padding: EdgeInsets.all(isTab(context) ? 10 : 13.0),
              child: BackIconWidget(),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 1.h,
                ),
                Container(
                    decoration: BoxDecoration(color: tWhite, boxShadow: [tBoxShadow], borderRadius: BorderRadius.circular(8)),
                    child: LocationCards(
                        status: '${tripOptionsProvider.riderType}',
                        pickupAddress: '${tripOptionsProvider.pickupAddress}',
                        dropAddress: '${tripOptionsProvider.dropAddress}',
                        tripStatus: '${tripOptionsProvider.tripType}')),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.w),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 3.h),
                    decoration: BoxDecoration(color: tWhite, borderRadius: BorderRadius.circular(10), boxShadow: [tBoxShadow]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              // expand: false,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) => Padding(padding: EdgeInsets.symmetric(horizontal: 0), child: Clock()),
                            );
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Image.asset(
                                  Images.CALENDER,
                                  scale: 3,
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Container(
                                  width: 35.w,
                                  child: Text(
                                    Twl.dateActual(tripOptionsProvider.pickupDate) + ',' + '${tripOptionsProvider.pickupTime}',
                                    maxLines: 2,
                                    style: GoogleFonts.mulish(
                                      color: tSecondaryColor,
                                      fontSize: isTab(context) ? 9.sp : 11.sp,
                                      fontWeight: FontWeight.w700,
                                      // fontFamily:
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  Images.EDIT_ICON,
                                  scale: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 4.h,
                          width: 0.3.w,
                          color: tSecondaryColor,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              Images.CAR,
                              scale: 4.5,
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Column(
                              children: [
                                Text(
                                  // '${tripOptionsProvider.carType}' +
                                  '${tripOptionsProvider.carModel}',
                                  style: GoogleFonts.mulish(
                                    color: tSecondaryColor,
                                    fontSize: isTab(context) ? 9.sp : 11.sp,
                                    fontWeight: FontWeight.w700,
                                    // fontFamily:
                                  ),
                                ),
                                SizedBox(
                                  width: 1.h,
                                ),
                                Text(
                                  // '${tripOptionsProvider.carType}' +
                                  tripOptionsProvider.carType.toString() == '1' ? '(Automatic)' : '(Manual)',
                                  style: GoogleFonts.mulish(
                                    color: tSecondaryColor,
                                    fontSize: isTab(context) ? 9.sp : 11.sp,
                                    fontWeight: FontWeight.w700,
                                    // fontFamily:
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                GestureDetector(
                  onTap: () {
                    tripOptionsProvider.setFinalFare(estimateFare);
                    showModalBottomSheet(
                      isScrollControlled: true,
                      //  expand: false,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                          child: Container(
                              height: 90.h,
                              // height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                              child: RentalVehicleInfo())),
                    );

                    // showModalBottomSheet(
                    //   isScrollControlled: true,
                    //   //  expand: false,
                    //   context: context,
                    //   backgroundColor: Colors.transparent,
                    //   builder: (context) => Padding(
                    //       padding: EdgeInsets.symmetric(horizontal: 0),
                    //       child: Container(
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(8)),
                    //           child: ConfirmRide())),
                    // );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 3.h),
                    decoration: BoxDecoration(color: tWhite, boxShadow: [tBackbtnBoxShadow], borderRadius: BorderRadiusDirectional.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'estimate_fare'.tr,
                                  style: GoogleFonts.mulish(
                                    color: tSecondaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: isTab(context) ? 8.sp : 16.sp,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      size: 15,
                                      color: tDarkOrangeColor,
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            tripOptionsProvider.isLoading
                                ? Column(
                                    children: [
                                      CircularProgressIndicator(
                                        color: tPrimaryColor,
                                      ),
                                    ],
                                  )
                                : RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: double.tryParse(tripOptionsProvider.estimateFare) != null
                                              ? currencySymbol + '${double.parse(tripOptionsProvider.estimateFare).toStringAsFixed(2)} '
                                              : '',
                                          style: GoogleFonts.mulish(
                                            color: tPrimaryColor,
                                            // decoration:
                                            //     TextDecoration.lineThrough,
                                            fontWeight: FontWeight.w800,
                                            fontSize: isTab(context) ? 12.sp : 16.sp,
                                          ),
                                        ),
                                        // TextSpan(
                                        //   text: '  ' +
                                        //       currencySymbol +
                                        //       '${tripOptionsProvider.calculateEstimateFinalFare().toStringAsFixed(2)}',
                                        //   style: GoogleFonts.mulish(
                                        //     color: tPrimaryColor,
                                        //     fontWeight: FontWeight.w800,
                                        //     fontSize:
                                        //         isTab(context) ? 16.sp : 20.sp,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  // height: 26.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 3.h),
                  decoration: BoxDecoration(color: tWhite, boxShadow: [tBackbtnBoxShadow], borderRadius: BorderRadiusDirectional.circular(10)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'estimate_usage'.tr,
                            style: GoogleFonts.mulish(
                              color: tSecondaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: isTab(context) ? 8.sp : 16.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      NumberPicker(
                        haptics: false,
                        textStyle: TextStyle(color: tPrimaryColor, fontWeight: FontWeight.w800, fontSize: 15.sp),
                        selectedTextStyle: TextStyle(color: tDarkNavyblue, fontWeight: FontWeight.w800, fontSize: 15.sp),
                        value: tripOptionsProvider.usageHours,
                        minValue: 1,
                        maxValue: 15,
                        step: 1,
                        itemHeight: 50,
                        itemWidth: 50,
                        axis: Axis.horizontal,
                        onChanged: (value) async {
                          tripOptionsProvider.setUsageHours(value);
                          //Hit estimate price api here on change

                          setState(() => tripOptionsProvider.usageHours = value);
                          tripOptionsProvider.getEstimate(context);
                        },

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: tappbarclr),
                        ),
                        // decoration: BoxDecoration(
                        // color: tWhite,

                        // color: tPrimaryColor,

                        // ),
                      ),
                      Text(
                        'hours'.tr,
                        style: GoogleFonts.mulish(
                          color: tSecondaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: isTab(context) ? 8.sp : 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 3.h,
                // ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 1.h),
                //   decoration: BoxDecoration(
                //       color: tWhite,
                //       boxShadow: [tBackbtnBoxShadow],
                //       borderRadius: BorderRadiusDirectional.circular(10)),
                //   child: Row(children: [
                //     Checkbox(
                //       activeColor: tPrimaryColor,
                //       value: _isChecked,
                //       onChanged: (value) {
                //         setState(() {
                //           _isChecked = value!;
                //         });
                //       },
                //     ),
                //     Container(
                //       width: 80.w,
                //       child: RichText(
                //         text: TextSpan(
                //           text: 'get_damage_protection'.tr,
                //           style: GoogleFonts.mulish(
                //             color: tSecondaryColor,
                //             fontWeight: FontWeight.w600,
                //             fontSize: isTab(context) ? 8.sp : 12.sp,
                //           ),
                //           children: <TextSpan>[
                //             TextSpan(
                //               text: '100_gst'.tr,
                //               style: GoogleFonts.mulish(
                //                 color: tSecondaryColor,
                //                 fontWeight: FontWeight.w800,
                //                 fontSize: isTab(context) ? 8.sp : 12.sp,
                //               ),
                //             ),
                //             TextSpan(
                //               text: 't_c_apply'.tr,
                //               style: GoogleFonts.mulish(
                //                 color: tPrimaryColor,
                //                 fontWeight: FontWeight.w600,
                //                 fontSize: isTab(context) ? 8.sp : 12.sp,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     )
                //   ]),
                // ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (tripOptionsProvider.couponCode != null && tripOptionsProvider.couponCode.isNotEmpty) {
                          tripOptionsProvider.removeCoupon(context);
                        } else {
                          Twl.forceNavigateTo(context, CouponsPage());
                        }
                      },
                      child: Container(
                        width: 45.w,
                        decoration: BoxDecoration(color: tWhite, boxShadow: [tBackbtnBoxShadow], borderRadius: BorderRadiusDirectional.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Row(
                            children: [
                              SizedBox(width: 1.w),
                              Image.asset(
                                Images.COUPON,
                                scale: isTab(context) ? 3 : 3,
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Text(
                                tripOptionsProvider.couponCode != null && tripOptionsProvider.couponCode.isNotEmpty
                                    ? tripOptionsProvider.couponCode
                                    : 'coupon'.tr,
                                style: GoogleFonts.mulish(
                                  color: tSecondaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: isTab(context) ? 8.sp : 12.sp,
                                ),
                              ),
                              Spacer(),
                              tripOptionsProvider.couponCode.isNotEmpty
                                  ? Icon(
                                      Icons.clear,
                                      color: tPrimaryColor,
                                      size: isTab(context) ? 40 : 30,
                                    )
                                  : Icon(
                                      Icons.keyboard_arrow_right,
                                      color: tPrimaryColor,
                                      size: isTab(context) ? 40 : 30,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      // onTap: () {
                      //   Twl.forceNavigateTo(context, PaymentSelection());
                      // },
                      child: Container(
                        width: 45.w,
                        decoration: BoxDecoration(color: tWhite, boxShadow: [tBackbtnBoxShadow], borderRadius: BorderRadiusDirectional.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              SizedBox(width: 1.w),
                              Image.asset(
                                Images.CURRENCY,
                                scale: isTab(context) ? 3 : 3,
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Center(
                                child: Text(
                                  'cash'.tr,
                                  style: GoogleFonts.mulish(
                                    color: tSecondaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: isTab(context) ? 8.sp : 12.sp,
                                  ),
                                ),
                              ),
                              // Spacer(),
                              // Icon(
                              //   Icons.keyboard_arrow_right,
                              //   color: tPrimaryColor,
                              //   size: isTab(context) ? 40 : 30,
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                tripOptionsProvider.isLoading
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: SizedBox(
                            width: isTab(context) ? 60.w : 50.w,
                            height: isTab(context) ? 6.h : 7.h,
                            child: ButtonWidget(
                                borderSide: BorderSide(
                                  color: tPrimaryColor,
                                ),
                                // borderRadius: BorderRadius.circular(15),
                                borderRadius: 14.0,
                                color: tPrimaryColor,
                                textcolor: Colors.black,
                                child: Text(
                                  'next'.tr,
                                  style: TextStyle(
                                      letterSpacing: 1, color: tWhite, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 10.sp : 16.sp),
                                ),
                                onTap: (startLoading, stopLoading, btnState) async {
                                  startLoading();
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    //  expand: false,
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 0),
                                        child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)), child: ConfirmRide())),
                                  );
                                  stopLoading();
                                }),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
