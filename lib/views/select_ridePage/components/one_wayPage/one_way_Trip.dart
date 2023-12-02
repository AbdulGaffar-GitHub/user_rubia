import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../providers/riderProvider.dart';

class OneWayTrip extends StatefulWidget {
  const OneWayTrip({Key? key}) : super(key: key);

  @override
  State<OneWayTrip> createState() => _OneWayTripState();
}

class _OneWayTripState extends State<OneWayTrip> {
  List<String> images = [Images.IN_CITY, Images.OUT_STATION];
  List<String> destinationText = ['in_city'.tr, 'out_station'.tr];
  var rides;
  var vehicleStatus = 1;
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final tripOptionsProvider = Provider.of<TripOptionsProvider>(context);

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 2.h),
          padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 0.h),
          decoration: BoxDecoration(
            color: tWhite,
            boxShadow: [tBoxShadow],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            height: 18.h,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 2,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    if (index == 0) {
                      tripOptionsProvider.setTripType(TRIP_TYPE_INTERCITY);
                      setState(() {
                        vehicleStatus = TRIP_TYPE_INTERCITY;
                      });
                      print('vehicleStatus');
                      print(vehicleStatus);
                      print('vehicleStatus');
                    } else {
                      tripOptionsProvider.setTripType(TRIP_TYPE_OUTSTATION);
                      setState(() {
                        vehicleStatus = TRIP_TYPE_OUTSTATION;
                      });
                      print('vehicleStatus');
                      print(vehicleStatus);
                      print('vehicleStatus');
                    }
                  },
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 2.h),
                    child: Container(
                      width: 40.w,
                      decoration: BoxDecoration(
                          color: tWhite,
                          boxShadow: [tBoxShadow],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: selectedIndex == index
                                  ? tPrimaryColor
                                  : tWhite,
                              width: 3)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            images[index],
                            scale: isTab(context) ? 2 : 4,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(destinationText[index],
                              style: GoogleFonts.mulish(
                                  color: tDarkNavyblue,
                                  fontWeight: FontWeight.w800,
                                  fontSize: isTab(context) ? 10.sp : 13.sp)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
