import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/views/RideBooking/selectLocationPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants.dart';
import '../../globalWidgets/buttonIconWidget.dart';
import '../../globalWidgets/buttonWidget.dart';
import '../../providers/riderProvider.dart';
import '../../responsive.dart';
import '../bottomNavigation.dart/bottomNavigation.dart';
import '../select_ridePage/components/one_wayPage/one_way_Trip.dart';

class SelectRideType extends StatefulWidget {
  const SelectRideType({Key? key}) : super(key: key);

  @override
  State<SelectRideType> createState() => _SelectRideTypeState();
}

class _SelectRideTypeState extends State<SelectRideType>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tripOptionsProvider = Provider.of<TripOptionsProvider>(context);

    return DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: () {
          return Twl.forceNavigateTo(
              context,
              BottomNavigation(
                tabIndexId: 0,
              ));
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            titleSpacing: 7,
            backgroundColor: tWhite,
            leading: GestureDetector(
                onTap: () {
                  tripOptionsProvider.resetProviderValues();
                  Twl.forceNavigateTo(
                      context,
                      BottomNavigation(
                        tabIndexId: 0,
                      ));
                },
                child: Padding(
                  padding: EdgeInsets.all(isTab(context) ? 10 : 12.0),
                  child: BackIconWidget(),
                )),
            centerTitle: true,
            title: Text('select_ride_type'.tr,
                style: GoogleFonts.mulish(
                    color: tDarkNavyblue,
                    fontWeight: FontWeight.w800,
                    fontSize: isTab(context) ? 10.sp : 17.sp)),
          ),
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
                children: [
                  Expanded(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 9.w),
                          height: 60,
                          decoration: BoxDecoration(
                            color: tWhite,
                            boxShadow: [tBoxShadow],
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                          child: TabBar(
                            onTap: (index) {
                              // print(index);

                              if (index == 0) {
                                print(index);
                                print('RIDER_TYPE_ONEWAY ');
                                tripOptionsProvider
                                    .setRiderType(RIDER_TYPE_ONEWAY);
                              } else {
                                print(index);
                                print('RIDER TYPE ROUNDTRIP');
                                tripOptionsProvider
                                    .setRiderType(RIDER_TYPE_ROUNDTRIP);
                              }
                            },
                            labelColor: tWhite,
                            unselectedLabelColor: tPrimaryColor,
                            // indicatorWeight: 10,
                            labelPadding: EdgeInsets.all(5),
                            indicatorPadding: EdgeInsets.all(4),
                            // controller: _tabController,
                            // give the indicator a decoration (color and border radius)
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: tPrimaryColor,
                            ),

                            tabs: [
                              Tab(
                                child: Text(
                                  'one_way'.tr,
                                  style: TextStyle(
                                      // color: tDarkNavyblue,
                                      fontSize: isTab(context) ? 10.sp : 12.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'round'.tr,
                                  style: TextStyle(
                                      // color: tDarkNavyblue,
                                      fontSize: isTab(context) ? 10.sp : 12.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 4.5,
                    child: TabBarView(
                      children: [
                        // first tab bar view widget
                        Center(child: OneWayTrip()),

                        // second tab bar view widget
                        Center(child: OneWayTrip()),
                      ],
                    ),
                  ),
                  Center(
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

                          Twl.navigateTo(context, SelectLocationPage());

                          setState(() {});

                          stopLoading();
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
