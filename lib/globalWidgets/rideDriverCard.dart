import 'package:base_project_flutter/constants/constants.dart';

import 'package:base_project_flutter/responsive.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class RideDriverCard extends StatefulWidget {
  const RideDriverCard({Key? key, this.rideDetails}) : super(key: key);
  final rideDetails;

  @override
  State<RideDriverCard> createState() => _RideDriverCardState();
}

class _RideDriverCardState extends State<RideDriverCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 2.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 1.5.h),
          decoration: BoxDecoration(
              color: tWhite,
              boxShadow: [tBoxShadow],
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.rideDetails['driver_image'] == ''
                  ? Container()
                  : Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: tDarkNavyblue, width: 2)),
                      child: CircleAvatar(
                        backgroundColor: tWhite,
                        backgroundImage:
                            NetworkImage(widget.rideDetails['driver_image']),
                        radius: isTab(context) ? 20 : 25,
                      ),
                    ),
              SizedBox(
                width: 3.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.rideDetails['driver_name'],
                    style: GoogleFonts.mulish(
                        color: tDarkNavyblue,
                        fontWeight: FontWeight.w700,
                        fontSize: isTab(context) ? 9.sp : 12.sp),
                  ),
                  SizedBox(
                    height: 0.6.h,
                  ),
                  Text(
                    'Driver',
                    style: GoogleFonts.mulish(
                        color: tDarkOrangeColor,
                        fontWeight: FontWeight.w700,
                        fontSize: isTab(context) ? 7.sp : 9.sp),
                  ),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  print(
                    widget.rideDetails['driver_contact'],
                  );
                  launch("tel://" +
                      widget.rideDetails['driver_contact'].toString());
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration:
                      BoxDecoration(color: tDarkGreen, shape: BoxShape.circle),
                  child: Icon(
                    Icons.call,
                    size: isTab(context) ? 15 : 22,
                    color: tWhite,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
