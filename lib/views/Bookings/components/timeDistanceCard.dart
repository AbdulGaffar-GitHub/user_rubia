import 'package:base_project_flutter/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'package:badges/badges.dart';
import '../../../../../constants/constants.dart';

class TimeAndDistanceCardWidget extends StatefulWidget {
  const TimeAndDistanceCardWidget({
    Key? key,
    this.completeDetails,
  }) : super(key: key);
  final completeDetails;

  @override
  State<TimeAndDistanceCardWidget> createState() =>
      _TimeAndDistanceCardWidgetState();
}

class _TimeAndDistanceCardWidgetState extends State<TimeAndDistanceCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Text(
                    'distance'.tr,
                    style: GoogleFonts.mulish(
                      color: tDarkOrangeColor,
                      fontSize: isTab(context) ? 11.sp : 13.sp,
                      fontWeight: FontWeight.w600,
                      // fontFamily:
                    ),
                  ),
                  // Column(
                  //   children: [
                  //     Icon(
                  //       Icons.info_outline,
                  //       size: 15,
                  //       color: tDate,
                  //     ),
                  //     SizedBox(height: 0.5.h)
                  //   ],
                  // ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                children: [
                  widget.completeDetails['total_distance'] != null
                      ? Text(
                          widget.completeDetails['total_distance'].toString(),
                          // '5',
                          style: GoogleFonts.mulish(
                            color: tDarkNavyblue,
                            fontSize: isTab(context) ? 11.sp : 16.sp,
                            fontWeight: FontWeight.w800,
                            // fontFamily:
                          ),
                        )
                      : Text(
                          '0',
                          // '5',
                          style: GoogleFonts.mulish(
                            color: tDarkNavyblue,
                            fontSize: isTab(context) ? 11.sp : 16.sp,
                            fontWeight: FontWeight.w800,
                            // fontFamily:
                          ),
                        ),
                  Text(
                    ' kms',
                    style: GoogleFonts.mulish(
                      color: tDarkNavyblue,
                      fontSize: isTab(context) ? 8.sp : 11.sp,
                      fontWeight: FontWeight.w800,
                      // fontFamily:
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Container(
          //   height: 8.h,
          //   width: 0.3.w,
          //   color: tlightDivider,
          // ),
          Column(
            children: [
              Text(
                'Time'.tr,
                style: GoogleFonts.mulish(
                  color: tDarkOrangeColor,
                  fontSize: isTab(context) ? 11.sp : 13.sp,
                  fontWeight: FontWeight.w600,
                  // fontFamily:
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                children: [
                  widget.completeDetails['usage_hours'] != null
                      ? Text(
                          widget.completeDetails['usage_hours'].toString(),
                          // '2.2 ',
                          style: GoogleFonts.mulish(
                            color: tDarkNavyblue,
                            fontSize: isTab(context) ? 11.sp : 16.sp,
                            fontWeight: FontWeight.w800,
                            // fontFamily:
                          ),
                        )
                      : Text(
                          '0',
                          // '2.2 ',
                          style: GoogleFonts.mulish(
                            color: tDarkNavyblue,
                            fontSize: isTab(context) ? 11.sp : 16.sp,
                            fontWeight: FontWeight.w800,
                            // fontFamily:
                          ),
                        ),
                  Text(
                    ' mins ',
                    style: GoogleFonts.mulish(
                      color: tDarkNavyblue,
                      fontSize: isTab(context) ? 8.sp : 11.sp,
                      fontWeight: FontWeight.w800,
                      // fontFamily:
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Container(
          //   height: 8.h,
          //   width: 0.3.w,
          //   color: tlightDivider,
          // ),
          Column(
            children: [
              Text(
                'Amount'.tr,
                style: GoogleFonts.mulish(
                  color: tDarkOrangeColor,
                  fontSize: isTab(context) ? 11.sp : 13.sp,
                  fontWeight: FontWeight.w600,
                  // fontFamily:
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              widget.completeDetails['final_price'] != null
                  ? Text(
                      currencySymbol +
                          widget.completeDetails['final_price'].toString(),
                      style: GoogleFonts.mulish(
                        color: tDarkNavyblue,
                        fontSize: isTab(context) ? 11.sp : 16.sp,
                        fontWeight: FontWeight.w800,
                        // fontFamily:
                      ),
                    )
                  : Text('0',
                      style: GoogleFonts.mulish(
                        color: tDarkNavyblue,
                        fontSize: isTab(context) ? 11.sp : 16.sp,
                        fontWeight: FontWeight.w800,
                        // fontFamily:
                      )),
            ],
          ),
        ],
      ),
    );
  }
}
