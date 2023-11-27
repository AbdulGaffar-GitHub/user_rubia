import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../../constants/constants.dart';
import '../../../../../responsive.dart';

class AmountCardWidget extends StatelessWidget {
  const AmountCardWidget({
    Key? key,
    this.rideDetails,
  }) : super(key: key);
  final rideDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: tWhite,
          boxShadow: [tBoxShadow],
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Row(
            //   children: [
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           '',
            //           // 'amount'.tr,
            //           style: TextStyle(
            //               color: tDarkNavyblue,
            //               fontSize: isTab(context) ? 8.sp : 12.sp,
            //               fontWeight: FontWeight.w600),
            //           maxLines: 2,
            //           overflow: TextOverflow.ellipsis,
            //         ),
            //       ],
            //     ),
            //     Spacer(),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         rideDetails['gst'] != null
            //             ? Container(
            //                 child: Text(
            //                     '+ ' + currencySymbol + rideDetails['gst'],
            //                     // rideDetails['total_fare'].toString(),
            //                     style: TextStyle(
            //                         fontSize: isTab(context) ? 8.sp : 12.sp,
            //                         color: tDarkNavyblue,
            //                         fontWeight: FontWeight.bold)))
            //             : Container()
            //       ],
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: 1.h,
            // ),
            // Row(
            //   children: [
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           'gst'.tr,
            //           // 'amount'.tr,
            //           style: TextStyle(
            //               color: tDarkNavyblue,
            //               fontSize: isTab(context) ? 8.sp : 12.sp,
            //               fontWeight: FontWeight.w600),
            //           maxLines: 2,
            //           overflow: TextOverflow.ellipsis,
            //         ),
            //       ],
            //     ),
            //     Spacer(),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         rideDetails != null
            //             ? Container(
            //                 child: Text(
            //                     '+ ' +
            //                                 currencySymbol +
            //                                 rideDetails['gst'].toString() !=
            //                             null
            //                         ? rideDetails['gst'].toString()
            //                         : '',
            //                     // rideDetails['total_fare'].toString(),
            //                     style: TextStyle(
            //                         fontSize: isTab(context) ? 8.sp : 12.sp,
            //                         color: tDarkNavyblue,
            //                         fontWeight: FontWeight.bold)))
            //             : Container()
            //       ],
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: 1.h,
            // ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'sub_total'.tr,
                      // 'amount'.tr,
                      style: TextStyle(
                          color: tDarkNavyblue,
                          fontSize: isTab(context) ? 8.sp : 12.sp,
                          fontWeight: FontWeight.w600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    rideDetails != null
                        ? Container(
                            child: Text(
                                currencySymbol +
                                    rideDetails['subtotal'].toString(),
                                // rideDetails['total_fare'].toString(),
                                style: TextStyle(
                                    fontSize: isTab(context) ? 8.sp : 12.sp,
                                    color: tDarkNavyblue,
                                    fontWeight: FontWeight.bold)))
                        : Text('hello')
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Discount'.tr,
                      // 'amount'.tr,
                      style: TextStyle(
                          color: tDarkNavyblue,
                          fontSize: isTab(context) ? 8.sp : 12.sp,
                          fontWeight: FontWeight.w600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    rideDetails != null
                        ? Container(
                            child: Text(
                                '-' +
                                    currencySymbol +
                                    rideDetails['coupon_discount'].toString(),
                                style: TextStyle(
                                    fontSize: isTab(context) ? 8.sp : 12.sp,
                                    color: tDarkNavyblue,
                                    fontWeight: FontWeight.bold)))
                        : Text('hello')
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Divider(
              color: tlightGray,
              thickness: 1,
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'total_amount'.tr,
                      style: TextStyle(
                          color: tDarkNavyblue,
                          fontSize: isTab(context) ? 8.sp : 12.sp,
                          fontWeight: FontWeight.w600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: Text(
                            currencySymbol +
                                rideDetails['price_detail']['estimatePrice']
                                    .toString(),
                            style: TextStyle(
                                fontSize: isTab(context) ? 8.sp : 12.sp,
                                color: tDarkNavyblue,
                                fontWeight: FontWeight.bold))),
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
