import 'package:base_project_flutter/api_services/servicesApi.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

import '../api_services/userApi.dart';
import '../globalFuctions/globalFunctions.dart';
import '../globalWidgets/buttonWidget.dart';
import '../providers/riderProvider.dart';
import 'homePage/components/OneWay.dart';

class Clock extends StatefulWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  DateTime selectedDate = DateTime.now(); // TO tracking date

  int currentDateSelectedIndex = 0; //For Horizontal Date
  var selectedIndex;
  ScrollController scrollController =
      ScrollController(); //To Track Scroll of ListView

  List<String> listOfMonths = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  List<String> listOfDays = [
    'Mon',
    'Tue',
    'Wed',
    'Thr',
    'Fri',
    'Sat',
    'Sun',
  ];
  var selectedindex;
  double _animatedHeight = 0.0;
  final _formKey = new GlobalKey<FormState>();
  var slotBookingDate = DateTime.now();
  bool isLoading = false;

  bool isInitialized = false;

  String? result;
  // bool isLoading = true;
  dynamic walletAmount;
  var resNOK;
  fetchBalance() async {
    var response = await UserAPI().walletAmount(
      context,
    );
    if (response != null && response['status'] == 'OK') {
      setState(() {
        walletAmount = response['details'];
        print(walletAmount);
      });
    } else {
      resNOK = response['status'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final tripOptionsProvider = Provider.of<TripOptionsProvider>(context);

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 1.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 2.h),
            decoration: BoxDecoration(
                boxShadow: [tBackbtnBoxShadow],
                color: tWhite,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Column(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      Text(
                        'select_date'.tr,
                        style: TextStyle(
                            fontSize: isTab(context) ? 8.sp : 12.sp,
                            fontWeight: FontWeight.w700,
                            color: tSecondaryColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                      height: isTab(context) ? 15.h : 120,
                      child: Consumer<TripOptionsProvider>(
                        builder: (context, tripOptionsProvider, _) {
                          if (!isInitialized) {
                            DateTime selectedDate =
                                DateTime.now().add(Duration(days: 0));
                            String formattedDate =
                                Twl.dateFormate(selectedDate);
                            tripOptionsProvider
                                .setPickupDateTime(formattedDate);
                            currentDateSelectedIndex = 0;
                            selectedIndex = 0;
                            isInitialized = true;
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              // setState(() {
                              //   // Update any other state variables here
                              // });
                            });
                          }
                          return ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(width: 1);
                            },
                            itemCount: 30,
                            controller: scrollController,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  tripOptionsProvider.setPickupTime('');
                                  DateTime selectedDate =
                                      DateTime.now().add(Duration(days: index));
                                  String formattedDate =
                                      Twl.dateFormate(selectedDate);
                                  tripOptionsProvider
                                      .setPickupDateTime(formattedDate);

                                  setState(() {
                                    currentDateSelectedIndex = index;
                                    selectedIndex = index;
                                    print(selectedIndex);
                                    print(formattedDate);
                                  });
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: isTab(context) ? 18.w : 17.w,
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(left: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: selectedIndex == index
                                            ? tPrimaryColor
                                            : tGray.withOpacity(0.1),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height:
                                                isTab(context) ? 2.h : 0.6.h,
                                          ),
                                          Text(
                                            listOfMonths[DateTime.now()
                                                        .add(Duration(
                                                            days: index))
                                                        .month -
                                                    1]
                                                .toString(),
                                            style: TextStyle(
                                              fontSize:
                                                  isTab(context) ? 9.sp : 11.sp,
                                              fontWeight: FontWeight.w500,
                                              color: selectedIndex == index
                                                  ? tWhite
                                                  : tSecondaryColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 0.2.h,
                                          ),
                                          Text(
                                            DateTime.now()
                                                .add(Duration(days: index))
                                                .day
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: isTab(context)
                                                  ? 15.sp
                                                  : 17.sp,
                                              fontWeight: FontWeight.w600,
                                              color: selectedIndex == index
                                                  ? tWhite
                                                  : tSecondaryColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 0.2.h,
                                          ),
                                          Text(
                                            listOfDays[DateTime.now()
                                                        .add(Duration(
                                                            days: index))
                                                        .weekday -
                                                    1]
                                                .toString(),
                                            style: TextStyle(
                                              fontSize:
                                                  isTab(context) ? 8.sp : 10.sp,
                                              fontWeight: FontWeight.w500,
                                              color: selectedIndex == index
                                                  ? tWhite
                                                  : tSecondaryColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 0.8.h,
                                          ),
                                          Container(
                                            child: selectedIndex == index
                                                ? Icon(
                                                    Icons.circle,
                                                    size: selectedIndex == index
                                                        ? isTab(context)
                                                            ? 20
                                                            : 10
                                                        : null,
                                                    color: tSecondaryColor,
                                                  )
                                                : null,
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      )),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      Text(
                        'select_time'.tr,
                        style: TextStyle(
                            fontSize: isTab(context) ? 8.sp : 12.sp,
                            fontWeight: FontWeight.w700,
                            color: tSecondaryColor),
                      ),
                    ],
                  ),
                  new TimePickerSpinner(
                      time: DateTime.now().add(Duration(hours: 1)),
                      is24HourMode: true,
                      normalTextStyle: TextStyle(
                          fontSize: isTab(context) ? 9.sp : 12.sp,
                          color: tSecondaryColor),
                      highlightedTextStyle: TextStyle(
                          fontSize: 24,
                          color: tSecondaryColor,
                          fontWeight: FontWeight.w700),
                      // spacing: 50,
                      itemHeight: 80,
                      isForce2Digits: false,
                      minutesInterval: 15,
                      onTimeChange: (time) {
                        DateTime now = DateTime.now();
                        DateTime pickupDateTime =
                            DateTime.parse(tripOptionsProvider.pickupDate);

                        DateTime selectedDateTime = DateTime(
                          pickupDateTime.year,
                          pickupDateTime.month,
                          pickupDateTime.day,
                          time.hour,
                          time.minute,
                        );

                        if (selectedDateTime.isBefore(now)) {
                          tripOptionsProvider.setPickupTime('');
                          // Selected time is in the past

                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              // title: Text('invalid_time'.tr),
                              content: Text('please_select_future_time'.tr),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: tPrimaryColor,
                                  ),
                                  child: Text('ok'.tr),
                                ),
                              ],
                            ),
                          );
                        } else {
                          String formattedTime =
                              DateFormat('HH:mm').format(time);
                          print('Selected Time: $formattedTime');

                          tripOptionsProvider.setPickupTime(formattedTime);

                          setState(() {
                            var _dateTime = time;
                          });
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: tripOptionsProvider.pickupTime.isNotEmpty &&
                            tripOptionsProvider.pickupDate.isNotEmpty
                        ? Center(
                            child: SizedBox(
                              width: isTab(context) ? 60.w : 55.w,
                              height: isTab(context) ? 8.h : 7.h,
                              child: ButtonWidget(
                                  borderSide: BorderSide(
                                    color: tPrimaryColor,
                                  ),
                                  // borderRadius: BorderRadius.circular(15),
                                  borderRadius: 14.0,
                                  color: tPrimaryColor,
                                  textcolor: Colors.black,
                                  child: Text(
                                    'ok'.tr,
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        color: tWhite,
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            isTab(context) ? 10.sp : 16.sp),
                                  ),
                                  onTap: (startLoading, stopLoading,
                                      btnState) async {
                                    if (_formKey.currentState!.validate()) {
                                      startLoading();
                                      // print(time);
                                      print(slotBookingDate);
                                      print(selectedIndex);
                                      Map<String, String> param = {
                                        'rider_type': tripOptionsProvider
                                            .riderType
                                            .toString(),
                                        'trip_type': tripOptionsProvider
                                            .tripType
                                            .toString(),
                                        'pickup_latitude':
                                            tripOptionsProvider.pickupLatitude,
                                        'pickup_longitude':
                                            tripOptionsProvider.pickupLongitude,
                                        'car_type': tripOptionsProvider.carType
                                            .toString(),
                                        'car_model': tripOptionsProvider
                                            .carModel
                                            .toString(),
                                        'pickup_date': tripOptionsProvider
                                            .pickupDate
                                            .toString(),
                                        'pickup_time': tripOptionsProvider
                                            .pickupTime
                                            .toString(),
                                        'usage_hours': tripOptionsProvider
                                            .usageHours
                                            .toString(),
                                        'drop_latitude':
                                            tripOptionsProvider.dropLatitude,
                                        'drop_longitude':
                                            tripOptionsProvider.dropLongitude,
                                        'pickup_address':
                                            tripOptionsProvider.pickupAddress,
                                        'drop_address':
                                            tripOptionsProvider.dropAddress,
                                        'coupon_code':
                                            tripOptionsProvider.couponCode,
                                        'coupon_discount':
                                          tripOptionsProvider.couponDiscount,
                                        'is_vehicle_damage_protection':
                                            tripOptionsProvider
                                                .isVehicleDamageProtection,
                                        'payment_method':
                                            tripOptionsProvider.paymentMethod,
                                        'city_id': tripOptionsProvider
                                            .selectedCityId
                                            .toString()
                                      };
                                      var res = await ServicesAPI().getEstimate(
                                          context,
                                          param,
                                          tripOptionsProvider.isSaveBooking);
                                      if (res['status'] == 'OK') {
                                        tripOptionsProvider.setEstimatePrice(
                                            res['estimate'].toString());
                                        final calculateEstimate =
                                            res['calculateEstimate'];

                                        // Pass the calculateEstimate map to the setEstimate function
                                        tripOptionsProvider
                                            .setEstimate(calculateEstimate);
                                        stopLoading();
                                        Twl.navigateTo(context, OneWay());
                                      } else {
                                        stopLoading();
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(
                                        //   SnackBar(
                                        //     content: Text(res['error']),
                                        //   ),
                                        // );
                                        Twl.wallateShowDailogBox(
                                            context, walletAmount);
                                        print(res['error']);
                                      }
                                    }

                                    //  Twl.forceNavigateTo(context, OneWay());
                                  }),
                            ),
                          )
                        : Center(
                            child: Text("Please select Date and Time"),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
