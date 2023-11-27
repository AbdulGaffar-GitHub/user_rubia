import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/globalWidgets/googleMapScreen.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/Bookings/components/vehicleHistory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../constants/constants.dart';
import '../../globalFuctions/globalFunctions.dart';
import '../bottomNavigation.dart/bottomNavigation.dart';
import 'components/bookingHistoryList.dart';

class BookingPageView extends StatefulWidget {
  BookingPageView(
      {Key? key,
      this.selectedType,
      this.status = '',
      this.selectedServiceTypeId})
      : super(key: key);
  final selectedType;
  final String status;
  final String? selectedServiceTypeId;

  @override
  State<BookingPageView> createState() => _BookingPageViewState();
}

class _BookingPageViewState extends State<BookingPageView> {
  ScrollController _scrollController = ScrollController();
  List<dynamic> bookingsData = [];
  bool showBottomSheet = false;

  int page = 0;
  int totalPages = 0;
  int totalCount = 0;
  UserAPI userAPI = UserAPI();
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(_scrollListener);
    // fetchBookings(widget.selectedServiceTypeId);
  }

  int selectedServiceTypeId = 1; // Default value

  void changeSelectedServiceType(int serviceTypeId) {
    setState(() {
      selectedServiceTypeId = serviceTypeId;
    });
    Navigator.pop(context); // Close the bottom sheet
  }

  void _showServiceTypeBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (context) {
        return Container(
          height: 35.h, // Adjust the height as needed
          child: Column(
            children: [
              ListTile(
                title: Text(
                  'DRIVER',
                  style: GoogleFonts.mulish(
                    color: tPrimaryColor,
                    fontSize: isTab(context) ? 10.sp : 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () => changeSelectedServiceType(1),
              ),
              ListTile(
                title: Text(
                  'TAXI',
                  style: GoogleFonts.mulish(
                    color: tPrimaryColor,
                    fontSize: isTab(context) ? 10.sp : 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () => changeSelectedServiceType(2),
              ),
              ListTile(
                title: Text(
                  'AUTO',
                  style: GoogleFonts.mulish(
                    color: tPrimaryColor,
                    fontSize: isTab(context) ? 10.sp : 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () => changeSelectedServiceType(3),
              ),
              ListTile(
                title: Text(
                  'BIKE',
                  style: GoogleFonts.mulish(
                    color: tPrimaryColor,
                    fontSize: isTab(context) ? 10.sp : 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () => changeSelectedServiceType(4),
              ),
            ],
          ),
        );
      },
    );
  }

  bool isBottomSheetOpen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        titleSpacing: 7,
        title: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'ride_history'.tr,
            style: GoogleFonts.mulish(
              color: tDarkNavyblue,
              fontWeight: FontWeight.w700,
              fontSize: isTab(context) ? 10.sp : 17.sp,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                // IconButton(
                //   icon: Icon(Icons.filter_list),
                //   onPressed: _showServiceTypeBottomSheet,
                // ),
                Text(
                  getServiceTypeName(selectedServiceTypeId.toString()),
                  style: GoogleFonts.mulish(
                    color: tDarkNavyblue,
                    fontSize: isTab(context) ? 10.sp : 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: _showServiceTypeBottomSheet,
                  color: tPrimaryColor,
                ),
                // Icon(
                //   isBottomSheetOpen
                //       ? Icons.keyboard_arrow_down
                //       : Icons.keyboard_arrow_up,
                //   size: isTab(context) ? 45 : 30,
                //   color: tPrimaryColor,
                // ),
              ],
            ),
          ),
        ],
        backgroundColor: tYellow,
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            Container(
              decoration: BoxDecoration(color: tWhite, boxShadow: [tBoxShadow]),
              child: TabBar(
                labelColor: tWhite,
                labelPadding: EdgeInsets.symmetric(
                    horizontal: 0.9.w, vertical: isTab(context) ? 10 : 4),
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelColor: tPrimaryColor,
                indicator: BoxDecoration(
                  color: tPrimaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                tabs: [
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Active_Rides".tr,
                          style: TextStyle(fontSize: isTab(context) ? 22 : 16),
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Completed".tr,
                          style: TextStyle(fontSize: isTab(context) ? 22 : 16),
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Cancelled".tr,
                          style: TextStyle(fontSize: isTab(context) ? 22 : 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                  children: [
                    BookingHistoryList(
                        status: '',
                        selectedServiceTypeId:
                            selectedServiceTypeId.toString()),
                    BookingHistoryList(
                        status: STATUS_RIDE_COMPLETED,
                        selectedServiceTypeId:
                            selectedServiceTypeId.toString()),
                    BookingHistoryList(
                        status: STATUS_CANCELLED,
                        selectedServiceTypeId:
                            selectedServiceTypeId.toString()),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

String getServiceTypeName(String? serviceTypeId) {
  if (serviceTypeId == null) {
    return 'UNKNOWN';
  }

  switch (int.tryParse(serviceTypeId)) {
    case 1:
      return 'DRIVER';
    case 2:
      return 'TAXI';
    case 3:
      return 'AUTO';
    case 4:
      return 'BIKE';
    default:
      return 'UNKNOWN';
  }
}
