import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../constants/constants.dart';
import '../../../../../../../responsive.dart';

class OTPCard extends StatefulWidget {
  const OTPCard({Key? key, this.rideData}) : super(key: key);
  final rideData;
  @override
  State<OTPCard> createState() => _OTPCardState();
}

class _OTPCardState extends State<OTPCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Container(
              decoration: BoxDecoration(
                  color: tWhite,
                  boxShadow: [tBoxShadow],
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'OTP',
                        style: GoogleFonts.mulish(
                            color: tBlack,
                            fontWeight: FontWeight.w600,
                            fontSize: isTab(context) ? 8.sp : 12.sp),
                      ),
                    ),
                    SizedBox(
                      width: 1.8.w,
                    ),
                    Text(
                      widget.rideData['otp'].toString(),
                      style: GoogleFonts.mulish(
                          color: tBlack,
                          fontWeight: FontWeight.w700,
                          fontSize: isTab(context) ? 10.sp : 17.sp),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
