import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';
import 'package:base_project_flutter/providers/riderProvider.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/RideBooking/RideEstimateInfo.dart';
import 'package:base_project_flutter/views/homePage/components/coupons.dart';
import 'package:base_project_flutter/views/homePage/components/orderPlaced.dart';
import 'package:base_project_flutter/views/homePage/components/paymentSelection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../globalFuctions/globalFunctions.dart';
import '../../../globalWidgets/buttonWidget.dart';

class ConfirmRide extends StatefulWidget {
  const ConfirmRide({Key? key}) : super(key: key);

  @override
  State<ConfirmRide> createState() => _ConfirmRideState();
}

class _ConfirmRideState extends State<ConfirmRide> {
  @override
  Widget build(BuildContext context) {
    final tripOptionsProvider = Provider.of<TripOptionsProvider>(context);
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
        // height: MediaQuery.of(context).size.height * 0.5,
        child: Column(children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
            decoration: BoxDecoration(
                color: tWhite,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [tBoxShadow]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 30.0),
                              child: Container(
                                  height: 90.h,
                                  // height: MediaQuery.of(context).size.height / 1,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: RentalVehicleInfo())),
                        );
                        // showDialog(
                        //   context: context,
                        //   builder: (context) => AlertDialog(
                        //     // title: Text('invalid_time'.tr),
                        //     content: Text('prices_may_vary'.tr),
                        //     actions: [
                        //       ElevatedButton(
                        //         onPressed: () {
                        //           Navigator.pop(context);
                        //         },
                        //         style: ElevatedButton.styleFrom(
                        //           backgroundColor: tPrimaryColor,
                        //         ),
                        //         child: Text(
                        //           'ok'.tr,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // );
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Text(
                              'estimate_fare'.tr,
                              style: GoogleFonts.mulish(
                                color: tSecondaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: isTab(context) ? 8.sp : 16.sp,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Column(
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
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        Text(
                          '  ' +
                              currencySymbol +
                              '${tripOptionsProvider.estimateFare}',
                          style: GoogleFonts.mulish(
                            color: tPrimaryColor,
                            fontWeight: FontWeight.w800,
                            fontSize: isTab(context) ? 16.sp : 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.5.w),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
              decoration: BoxDecoration(
                  color: tWhite,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [tBoxShadow]),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          Images.CALENDER,
                          scale: 3,
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        tripOptionsProvider.pickupDate == null ||
                                tripOptionsProvider.pickupDate == ""
                            ? Container()
                            : Container(
                                width: 35.w,
                                child: Text(
                                  Twl.dateActualFormate(
                                          tripOptionsProvider.pickupDate) +
                                      ',' +
                                      '${tripOptionsProvider.pickupTime}',
                                  maxLines: 2,
                                  style: GoogleFonts.mulish(
                                    color: tSecondaryColor,
                                    fontSize: isTab(context) ? 9.sp : 11.sp,
                                    fontWeight: FontWeight.w700,
                                    // fontFamily:
                                  ),
                                ),
                              ),
                      ],
                    ),
                    // Container(
                    //   height: 6.h,
                    //   width: 0.4.w,
                    //   color: tSecondaryColor,
                    // ),
                    VerticalDivider(
                      color: tSecondaryColor,
                      thickness: 1.5,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          Images.TIMER,
                          scale: 3,
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Text(
                          tripOptionsProvider.usageHours.toString() + " Hrs",
                          style: GoogleFonts.mulish(
                            color: tSecondaryColor,
                            fontSize: isTab(context) ? 12.sp : 12.sp,
                            fontWeight: FontWeight.w700,
                            // fontFamily:
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 0.6.h,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         if (tripOptionsProvider.couponCode != null &&
          //             tripOptionsProvider.couponCode.isNotEmpty) {
          //           tripOptionsProvider.removeCoupon(context);
          //         } else {
          //           Twl.forceNavigateTo(context, CouponsPage());
          //         }
          //       },
          //       child: Container(
          //         width: 45.w,
          //         decoration: BoxDecoration(
          //             color: tWhite,
          //             boxShadow: [tBackbtnBoxShadow],
          //             borderRadius: BorderRadiusDirectional.circular(6)),
          //         child: Padding(
          //           padding: EdgeInsets.all(14.0),
          //           child: Row(
          //             children: [
          //               SizedBox(width: 1.w),
          //               Image.asset(
          //                 Images.COUPON,
          //                 scale: isTab(context) ? 3 : 4,
          //               ),
          //               SizedBox(
          //                 width: 1.w,
          //               ),
          //               Text(
          //                 tripOptionsProvider.couponCode != null &&
          //                         tripOptionsProvider.couponCode.isNotEmpty
          //                     ? tripOptionsProvider.couponCode
          //                     : 'coupon'.tr,
          //                 style: GoogleFonts.mulish(
          //                   color: tSecondaryColor,
          //                   fontWeight: FontWeight.w600,
          //                   fontSize: isTab(context) ? 8.sp : 10.sp,
          //                 ),
          //               ),
          //               Spacer(),
          //               tripOptionsProvider.couponCode.isNotEmpty
          //                   ? Icon(
          //                       Icons.clear,
          //                       color: tPrimaryColor,
          //                       size: isTab(context) ? 40 : 30,
          //                     )
          //                   : Icon(
          //                       Icons.keyboard_arrow_right,
          //                       color: tPrimaryColor,
          //                       size: isTab(context) ? 40 : 30,
          //                     ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //     GestureDetector(
          //       onTap: () {
          //         Twl.forceNavigateTo(context, PaymentSelection());
          //       },
          //       child: Container(
          //         width: 45.w,
          //         decoration: BoxDecoration(
          //             color: tWhite,
          //             boxShadow: [tBackbtnBoxShadow],
          //             borderRadius: BorderRadiusDirectional.circular(6)),
          //         child: Padding(
          //           padding: EdgeInsets.all(14.0),
          //           child: Row(
          //             children: [
          //               SizedBox(width: 1.w),
          //               Image.asset(
          //                 Images.CURRENCY,
          //                 scale: isTab(context) ? 3 : 4,
          //               ),
          //               SizedBox(
          //                 width: 1.w,
          //               ),
          //               Text(
          //                 'cash'.tr,
          //                 style: GoogleFonts.mulish(
          //                   color: tSecondaryColor,
          //                   fontWeight: FontWeight.w600,
          //                   fontSize: isTab(context) ? 8.sp : 12.sp,
          //                 ),
          //               ),
          //               Spacer(),
          //               Icon(
          //                 Icons.keyboard_arrow_right,
          //                 color: tPrimaryColor,
          //                 size: isTab(context) ? 40 : 30,
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 3.h,
          // ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: SizedBox(
                width: isTab(context) ? 60.w : 50.w,
                height: isTab(context) ? 6.h : 7.h,
                child: ButtonWidget(
                    borderSide: BorderSide(
                      color: tPrimaryColor,
                    ),
                    // borderRadius: BorderRadius.circular(15),
                    borderRadius: 8.0,
                    color: tPrimaryColor,
                    textcolor: Colors.black,
                    child: Text(
                      "Confirm_Ride".tr,
                      style: TextStyle(
                          letterSpacing: 1,
                          color: tWhite,
                          fontWeight: FontWeight.w700,
                          fontSize: isTab(context) ? 10.sp : 16.sp),
                    ),
                    onTap: (startLoading, stopLoading, btnState) async {
                      tripOptionsProvider.setSaveBooking(true);
                      startLoading();
                      var response =
                          await tripOptionsProvider.getEstimate(context);
                      if (response['status'] == 'OK') {
                        Twl.navigateTo(context, OrderPlaced());
                        // tripOptionsProvider.resetProviderValues();
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('error'.tr),
                            content: Text('failed_to_save_try_again'.tr),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                child: Text('ok'.tr),
                              ),
                            ],
                          ),
                        );
                      }
                    }),
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
        ]),
      ),
    );
  }
}
