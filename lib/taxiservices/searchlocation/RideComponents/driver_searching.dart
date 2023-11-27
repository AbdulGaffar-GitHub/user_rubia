import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/providers/riderProvider.dart';
import 'package:base_project_flutter/views/homePage/homePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/constants.dart';
import '../../../globalFuctions/globalFunctions.dart';
import '../../../globalWidgets/buttonWidget.dart';
import '../../../responsive.dart';
import '../../../views/bottomNavigation.dart/bottomNavigation.dart';
import '../../rideservices/riderServices.dart';

class DriverSearch extends StatefulWidget {
  const DriverSearch({
    Key? key,
    this.rideData,
  }) : super(key: key);
  final rideData;
  @override
  State<DriverSearch> createState() => _DriverSearchState();
}

class _DriverSearchState extends State<DriverSearch> {
  @override
  Widget build(BuildContext context) {
    final tripOptionsProvider = Provider.of<TripOptionsProvider>(context);
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.of(context).size.height / 2.5,
          decoration: BoxDecoration(
            color: tWhite,
          ),
          // height: 50.h,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      boxShadow: [tBoxShadow],
                      color: tBlack),
                ),

                Lottie.asset(
                  'assets/lottie/Searching_Floating_Hand.json',
                  height: 15.h,
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 7.w),
                  width: double.infinity,
                  height: 1.8.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: LinearPercentIndicator(
                      animation: true,
                      lineHeight: 10.0,
                      animationDuration: 15000,
                      percent: 0.9,
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: tPrimaryColor,
                      backgroundColor: tWhite,
                    ),
                  ),
                ),

                SizedBox(
                  height: 1.h,
                ),

                // SizedBox(
                //   height: 5.h,
                // ),
                Text('Please hold! we are searching for',
                    maxLines: 2,
                    style: TextStyle(
                        color: tBlack,
                        fontSize: isTab(context) ? 10.sp : 14.sp,
                        fontWeight: FontWeight.w500)),
                Text(' nearby skipper for you',
                    maxLines: 2,
                    style: TextStyle(
                        color: tBlack,
                        fontSize: isTab(context) ? 10.sp : 14.sp,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  height: isTab(context) ? 5.h : 2.h,
                ),
                Center(
                  child: SizedBox(
                    width: isTab(context) ? 50.w : 80.w,
                    child: ButtonWidget(
                        borderSide: BorderSide(
                          color: tPrimaryColor,
                        ),
                        // borderRadius: BorderRadius.circular(15),
                        borderRadius: isTab(context) ? 40.0 : 30.0,
                        color: tPrimaryColor,
                        child: Text(
                          "Cancel Ride",
                          style: GoogleFonts.mulish(
                            color: tWhite,
                            fontWeight: FontWeight.w700,
                            fontSize: isTab(context) ? 10.sp : 16.sp,
                          ),
                        ),
                        onTap: (startLoading, stopLoading, btnState) async {
                          startLoading();
                          Map<String, String> param = {
                            'ride_id': widget.rideData['ride_id'].toString()
                          };
                          print(param);
                          var res =
                              await UserAPI().SkippercancelRide(context, param);
                          print(res);
                          if (res != null && res['status'] == 'OK') {
                            RideService().removeDocument(
                                uid: widget.rideData['ride_id'].toString());
                            RideService().removeSkipperRequest(context);
                            Twl.forceNavigateTo(
                                context,
                                BottomNavigation(
                                  tabIndexId: 0,
                                ));
                            tripOptionsProvider.resetProviderValues();
                          } else {
                            stopLoading();
                            Twl.createAlert(
                                context, 'Oops', res['error'].toString());
                          }

                          stopLoading();
                        }),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
