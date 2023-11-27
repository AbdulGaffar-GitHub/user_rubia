import 'package:base_project_flutter/views/RideBooking/selectRideType.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants.dart';
import '../../globalFuctions/globalFunctions.dart';
import '../../globalWidgets/buttonIconWidget.dart';
import '../../globalWidgets/buttonWidget.dart';
import '../../globalWidgets/locationcard.dart';
import '../../providers/riderProvider.dart';
import '../../responsive.dart';
import '../dummy.dart';
import '../select_ridePage/components/one_wayPage/components/automatic_page.dart';

class SelectLocationPage extends StatefulWidget {
  const SelectLocationPage({Key? key}) : super(key: key);

  @override
  State<SelectLocationPage> createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  @override
  Widget build(BuildContext context) {
    final tripOptionsProvider = Provider.of<TripOptionsProvider>(context);
    if (tripOptionsProvider.pickupAddress == null ||
        tripOptionsProvider.pickupAddress.isEmpty) {
      tripOptionsProvider.getCurrentLocation(context);
    }
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            titleSpacing: 7,
            backgroundColor: tWhite,
            leading: GestureDetector(
                onTap: () {
                  tripOptionsProvider.resetProviderValues();
                  Twl.forceNavigateTo(context, SelectRideType());
                },
                child: Padding(
                  padding: EdgeInsets.all(isTab(context) ? 10 : 12.0),
                  child: BackIconWidget(),
                )),
            centerTitle: true,
            title: tripOptionsProvider.riderType == RIDER_TYPE_ONEWAY
                ? Text('one_way'.tr,
                    style: GoogleFonts.mulish(
                        color: tDarkNavyblue,
                        fontWeight: FontWeight.w800,
                        fontSize: isTab(context) ? 10.sp : 17.sp))
                : Text('round'.tr,
                    style: GoogleFonts.mulish(
                        color: tDarkNavyblue,
                        fontWeight: FontWeight.w800,
                        fontSize: isTab(context) ? 10.sp : 17.sp))),
        body: Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              onMapCreated: (controller) {
                //method called when map is created
                setState(() {
                  controller = controller;
                });
              },
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              myLocationEnabled: true,
              initialCameraPosition: const CameraPosition(
                target: LatLng(17.448294, 78.391487),
                zoom: 17.0,
              ),
              // markers: Set<Marker>.of(markers.values),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.5.w),
                  child: Container(
                      decoration: BoxDecoration(
                          color: tWhite,
                          boxShadow: [tBoxShadow],
                          borderRadius: BorderRadius.circular(8)),
                      child: LocationCards(
                          //  status: '${tripOptionsProvider.riderType}',
                          pickupAddress: '${tripOptionsProvider.pickupAddress}',
                          dropAddress: '${tripOptionsProvider.dropAddress}',
                          tripStatus: '${tripOptionsProvider.tripType}')),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: (tripOptionsProvider.riderType ==
                                    RIDER_TYPE_ONEWAY &&
                                tripOptionsProvider.pickupAddress != null &&
                                tripOptionsProvider.dropAddress != null &&
                                tripOptionsProvider.pickupAddress.isNotEmpty &&
                                tripOptionsProvider.dropAddress.isNotEmpty) ||
                            (tripOptionsProvider.riderType ==
                                    RIDER_TYPE_ROUNDTRIP &&
                                tripOptionsProvider.pickupAddress != null &&
                                tripOptionsProvider.pickupAddress.isNotEmpty)
                        ? SizedBox(
                            height: 60,
                            width: MediaQuery.of(context).size.width / 1.25,
                            child: AppBar(
                              backgroundColor: tWhite,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              bottom: TabBar(
                                onTap: (index) async {
                                  if (index == 0) {
                                    tripOptionsProvider
                                        .setCarType(CAR_TYPE_AUTOMATIC);
                                    setState(() {
                                      // Update the vehicle type or perform any other necessary action
                                    });
                                  } else {
                                    tripOptionsProvider
                                        .setCarType(CAR_TYPE_MANUAL);
                                    setState(() {
                                      // Update the vehicle type or perform any other necessary action
                                    });
                                  }
                                },
                                labelColor: tWhite,
                                unselectedLabelColor: tPrimaryColor,
                                labelPadding: EdgeInsets.all(5),
                                indicatorPadding: EdgeInsets.all(4),
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: tPrimaryColor,
                                ),
                                tabs: [
                                  Tab(
                                    child: Text(
                                      'automatic'.tr,
                                      style: TextStyle(
                                        fontSize:
                                            isTab(context) ? 10.sp : 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      'manual'.tr,
                                      style: TextStyle(
                                        fontSize:
                                            isTab(context) ? 10.sp : 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(),
                  ),
                ),
                (tripOptionsProvider.riderType == RIDER_TYPE_ONEWAY &&
                            tripOptionsProvider.pickupAddress != null &&
                            tripOptionsProvider.dropAddress != null &&
                            tripOptionsProvider.pickupAddress.isNotEmpty &&
                            tripOptionsProvider.dropAddress.isNotEmpty) ||
                        (tripOptionsProvider.riderType ==
                                RIDER_TYPE_ROUNDTRIP &&
                            tripOptionsProvider.pickupAddress != null &&
                            tripOptionsProvider.pickupAddress.isNotEmpty)
                    ? Container(
                        height: MediaQuery.of(context).size.height / 5,
                        child: TabBarView(
                          children: [
                            // first tab bar view widget
                            Center(child: AutomaticTabPage(vehicleType: 1)),

                            // second tab bar viiew widget
                            Center(child: AutomaticTabPage(vehicleType: 2)),
                          ],
                        ),
                      )
                    : Container(),
                (tripOptionsProvider.riderType == RIDER_TYPE_ONEWAY &&
                            tripOptionsProvider.pickupAddress != null &&
                            tripOptionsProvider.dropAddress != null &&
                            tripOptionsProvider.pickupAddress.isNotEmpty &&
                            tripOptionsProvider.dropAddress.isNotEmpty) ||
                        (tripOptionsProvider.riderType ==
                                RIDER_TYPE_ROUNDTRIP &&
                            tripOptionsProvider.pickupAddress != null &&
                            tripOptionsProvider.pickupAddress.isNotEmpty)
                    ? Center(
                        child: SizedBox(
                          width: isTab(context) ? 30.w : 50.w,
                          height: isTab(context) ? 6.h : 7.h,
                          child: ButtonWidget(
                            borderSide: BorderSide(color: tPrimaryColor),
                            color: tPrimaryColor,
                            borderRadius: isTab(context) ? 16.0 : 14.0,
                            child: Text('next'.tr,
                                style: GoogleFonts.mulish(
                                    color: tWhite,
                                    fontWeight: FontWeight.w700,
                                    fontSize: isTab(context) ? 9.sp : 14.sp)),
                            onTap: (startLoading, stopLoading, btnState) async {
                              startLoading();
                              //Open select time and date popup here

                              showModalBottomSheet(
                                isScrollControlled: true,
                                // expand: false,
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) => Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    child: Clock()),
                              );

                              setState(() {});
                              stopLoading();
                            },
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
