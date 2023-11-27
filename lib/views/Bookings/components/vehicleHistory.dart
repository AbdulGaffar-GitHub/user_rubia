// vehicle_history_bottom_sheet.dart

import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import '../../../constants/constants.dart';
import '../../../providers/earningsProvider.dart';
import '../../../responsive.dart';
import '../../bottomNavigation.dart/bottomNavigation.dart';

class VehicleHistoryBottomSheet extends StatefulWidget {
  final onServiceTypeSelected;
  final onServiceId;
  final Function fetchBookings;

  const VehicleHistoryBottomSheet(
      {Key? key,
      required this.onServiceTypeSelected,
      this.onServiceId,
      required this.fetchBookings})
      : super(key: key);

  @override
  State<VehicleHistoryBottomSheet> createState() =>
      _VehicleHistoryBottomSheetState();
}

class _VehicleHistoryBottomSheetState extends State<VehicleHistoryBottomSheet> {
  String filterValue = "All";

  @override
  Widget build(BuildContext context) {
    return Consumer<EarningsProvider>(builder: (context, provider, _) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: tWhite,
          height: MediaQuery.of(context).size.height / 1.8,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 18.w,
                      height: 0.7.h,
                      decoration: BoxDecoration(
                          color: tPrimaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  ListTile(
                    title: Text(
                      'DRIVER',
                      style: TextStyle(
                          color: tSecondaryColor,
                          fontSize: isTab(context) ? 9.sp : 12.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      widget.onServiceTypeSelected('DRIVER');
                      widget.onServiceId('1');
                      widget.fetchBookings(widget.onServiceId).toString();
                      Navigator.of(context).pop({
                        'serviceType': 'DRIVER',
                        'serviceId': '1',
                      });
                    },
                  ),
                  ListTile(
                    title: Text(
                      'TAXI',
                      style: TextStyle(
                          color: tSecondaryColor,
                          fontSize: isTab(context) ? 9.sp : 12.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      widget.onServiceTypeSelected('TAXI');
                      widget.onServiceId('2');
                      widget.fetchBookings(widget.onServiceId).toString();
                      Navigator.of(context).pop({
                        'serviceType': 'TAXI',
                        'serviceId': '2',
                      });
                    },
                  ),
                  ListTile(
                    title: Text(
                      'AUTO',
                      style: TextStyle(
                          color: tSecondaryColor,
                          fontSize: isTab(context) ? 9.sp : 12.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      widget.onServiceTypeSelected('AUTO');
                      widget.onServiceId('3');
                      widget.fetchBookings(widget.onServiceId).toString();
                      Navigator.of(context).pop({
                        'serviceType': 'AUTO',
                        'serviceId': '3',
                      });
                    },
                  ),
                  ListTile(
                    title: Text(
                      'BIKE',
                      style: TextStyle(
                          color: tSecondaryColor,
                          fontSize: isTab(context) ? 9.sp : 12.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      widget.onServiceTypeSelected('BIKE');
                      widget.onServiceId('4');
                      widget.fetchBookings(widget.onServiceId).toString();
                      Navigator.of(context).pop({
                        'serviceType': 'BIKE',
                        'serviceId': '4',
                      });
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
