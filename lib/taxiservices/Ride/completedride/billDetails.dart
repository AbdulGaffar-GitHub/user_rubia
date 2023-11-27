import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';
import 'package:base_project_flutter/responsive.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sizer/sizer.dart';

class BillDetailsCardWidgt extends StatefulWidget {
  const BillDetailsCardWidgt({Key? key, this.rideData, this.rideDetails})
      : super(key: key);
  final rideData;
  final rideDetails;

  @override
  State<BillDetailsCardWidgt> createState() => _BillDetailsCardWidgtState();
}

class _BillDetailsCardWidgtState extends State<BillDetailsCardWidgt> {
  @override
  Widget build(BuildContext context) {
    return widget.rideDetails == null
        ? SpinKitThreeBounce(
            color: tPrimaryColor,
            size: 20.0,
          )
        : Container(
            decoration: BoxDecoration(
              color: tWhite,
              boxShadow: [tBoxShadow],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Distance',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: tBlack,
                            fontWeight: FontWeight.w400,
                            fontSize: isTab(context) ? 9.sp : 12.sp),
                      ),
                      Text(
                        widget.rideDetails['distance'].toString() + ' km',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: tBlack,
                            fontWeight: FontWeight.w600,
                            fontSize: isTab(context) ? 9.sp : 12.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Duration',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: tBlack,
                            fontWeight: FontWeight.w400,
                            fontSize: isTab(context) ? 9.sp : 12.sp),
                      ),
                      Text(
                        widget.rideDetails['time'].toString() + ' mins',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: tBlack,
                            fontWeight: FontWeight.w600,
                            fontSize: isTab(context) ? 9.sp : 12.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Amount',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: tBlack,
                            fontWeight: FontWeight.w400,
                            fontSize: isTab(context) ? 9.sp : 12.sp),
                      ),
                      Text(
                        currencySymbol +
                            widget.rideDetails['final_price'].toString(),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: tBlack,
                            fontWeight: FontWeight.w600,
                            fontSize: isTab(context) ? 9.sp : 12.sp),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}

class RideStatusCardWidgt extends StatefulWidget {
  const RideStatusCardWidgt({Key? key, this.rideData, this.rideDetails})
      : super(key: key);
  final rideData;
  final rideDetails;

  @override
  State<RideStatusCardWidgt> createState() => _RideStatusCardWidgtState();
}

class _RideStatusCardWidgtState extends State<RideStatusCardWidgt> {
  @override
  Widget build(BuildContext context) {
    return widget.rideDetails == null
        ? SpinKitThreeBounce(
            color: tPrimaryColor,
            size: 20.0,
          )
        : Container(
            decoration: BoxDecoration(
              color: tWhite,
              boxShadow: [tBoxShadow],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ride Status',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: tBlack,
                            fontWeight: FontWeight.w400,
                            fontSize: isTab(context) ? 9.sp : 12.sp),
                      ),
                      Text(
                        widget.rideData['status'] == 1
                            ? "New Request"
                            : widget.rideData['status'] == 2
                                ? "Ride Booked"
                                : widget.rideData['status'] == 9
                                    ? "Complete Ride"
                                    : "Complete Totally",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: tBlack,
                            fontWeight: FontWeight.w600,
                            fontSize: isTab(context) ? 9.sp : 12.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment Type',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: tBlack,
                            fontWeight: FontWeight.w400,
                            fontSize: isTab(context) ? 9.sp : 12.sp),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: tPrimaryColor, shape: BoxShape.circle),
                        // child: Padding(
                        //   padding: EdgeInsets.all(isTab(context) ? 16 : 10.0),
                        //   child: _data.cashhMode == 'cash'
                        //       ? Image.asset(
                        //           Images.CASHICON,
                        //           scale: isTab(context) ? 2.5 : 3.5,
                        //         )
                        //       : _data.cashhMode == 'online'
                        //           ? Image.asset(
                        //               Images.QRICON,
                        //               scale: isTab(context) ? 2.5 : 3.8,
                        //             )
                        //           : Image.asset(
                        //               Images.WALLETICON,
                        //               scale: isTab(context) ? 2.5 : 3.5,
                        //             ),
                        // ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Change payment method here
                          // widget.onlinePayment != true
                          // _data.cashhMode == 'cash' ||
                          widget.rideData['payment_method'] == '1'
                              ? Text(
                                  'Cash mode',
                                  style: GoogleFonts.mulish(
                                      color: tBlack,
                                      fontWeight: FontWeight.w600,
                                      fontSize: isTab(context) ? 9.sp : 12.sp),
                                )
                              :
                              //_data.cashhMode == 'online' ||
                              widget.rideData['payment_method'] == '4'
                                  ? Text(
                                      'Online mode',
                                      style: GoogleFonts.mulish(
                                          color: tBlack,
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              isTab(context) ? 9.sp : 12.sp),
                                    )
                                  : Text(
                                      'Wallet pay',
                                      style: GoogleFonts.mulish(
                                          color: tBlack,
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              isTab(context) ? 9.sp : 12.sp),
                                    ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}

class PayAtDrop extends StatefulWidget {
  const PayAtDrop({
    Key? key,
    this.rideData,
    this.getVechileDetails,
    this.rideId,
    this.selectedIndex,
  }) : super(key: key);
  final rideData;

  final getVechileDetails;
  final rideId;
  final selectedIndex;
  @override
  State<PayAtDrop> createState() => _PayAtDropState();
}

class _PayAtDropState extends State<PayAtDrop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: tWhite,
          // boxShadow: [tBoxShadow],
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration:
                  BoxDecoration(color: tPrimaryColor, shape: BoxShape.circle),
              child: Padding(
                padding: EdgeInsets.all(isTab(context) ? 16 : 10.0),
                child:
                    // _data.cashhMode == 'cash'
                    widget.rideData['payment_method'] == '1'
                        ? Image.asset(
                            Images.CASHICON,
                            scale: isTab(context) ? 2.5 : 3.5,
                          )
                        :
                        // _data.cashhMode == 'online'
                        widget.rideData['payment_method'] == '4'
                            ? Image.asset(
                                Images.QRICON,
                                scale: isTab(context) ? 2.5 : 3.8,
                              )
                            : Image.asset(
                                Images.WALLETICON,
                                scale: isTab(context) ? 2.5 : 3.5,
                              ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Change payment method here
                // widget.onlinePayment != true
                // _data.cashhMode == 'cash'
                widget.rideData['payment_method'] == '1'
                    ? Text(
                        'Cash mode',
                        style: GoogleFonts.mulish(
                            color: tBlack,
                            fontWeight: FontWeight.w600,
                            fontSize: isTab(context) ? 9.sp : 12.sp),
                      )
                    :
                    // _data.cashhMode == 'online'
                    widget.rideData['payment_method'] == '4'
                        ? Text(
                            'Online mode',
                            style: GoogleFonts.mulish(
                                color: tBlack,
                                fontWeight: FontWeight.w600,
                                fontSize: isTab(context) ? 9.sp : 12.sp),
                          )
                        : Text(
                            'Wallet pay',
                            style: GoogleFonts.mulish(
                                color: tBlack,
                                fontWeight: FontWeight.w600,
                                fontSize: isTab(context) ? 9.sp : 12.sp),
                          ),
                SizedBox(
                  height: 0.4.h,
                ),
                Text(
                  'Change payment Method',
                  // style: TextStyle(
                  //     color: tGray,
                  //     fontWeight: FontWeight.w500,
                  //     fontSize: isTab(context) ? 7.sp : 9.sp),
                  style: GoogleFonts.mulish(
                      color: tGray,
                      fontWeight:
                          isTab(context) ? FontWeight.w500 : FontWeight.w600,
                      fontSize: isTab(context) ? 6.sp : 9.sp),
                ),
              ],
            ),
            Spacer(),
            Icon(
              Icons.keyboard_arrow_right,
              size: isTab(context) ? 40 : 30,
            )
          ],
        ),
      ),
    );
  }
}
