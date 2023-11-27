import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/globalWidgets/buttonIconWidget.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/taxiservices/searchlocation/searchlocation.dart';
import 'package:base_project_flutter/taxiservices/selectVehicle.dart';
import 'package:base_project_flutter/views/Bookings/components/rideDetailsView/components/rideInfo.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:base_project_flutter/views/homePage/components/OneWay.dart';
import 'package:base_project_flutter/views/homePage/couponbottomsheet.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../globalWidgets/buttonwidget.dart';
import '../../../providers/riderProvider.dart';

class CouponsPage extends StatefulWidget {
  const CouponsPage({
    Key? key,
    this.boolcouponpage,
  }) : super(key: key);
  final bool? boolcouponpage;
  @override
  _CouponsPageState createState() => _CouponsPageState();
}

class _CouponsPageState extends State<CouponsPage> {
  bool showBottomSheet = false;
  final TextEditingController _couponCodeController = TextEditingController();

  final _inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(
      color: tlightGray,
      width: 1,
    ),
  );
  UserAPI userAPI = UserAPI();
  List<dynamic> couponsData = [];
  bool isLoading = false;
  bool descTextShowFlag = false;
  int currentPage = 0;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchCoupons();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchCoupons();
      }
    });
  }

  Future<void> fetchCoupons() async {
    if (isLoading) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      dynamic response =
          await userAPI.fetchCouponsList(context, currentPage.toString());
      List<dynamic> newCoupons = response['details'] ?? [];
      setState(() {
        couponsData.addAll(newCoupons);
        currentPage++;
        isLoading = false;
      });
    } catch (e) {
      // Handle error
      print('Error fetching coupons: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void openBottomSheet() {
    setState(() {
      showBottomSheet = true;
    });
  }

  void closeBottomSheet() {
    setState(() {
      showBottomSheet = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tripOptionsProvider = Provider.of<TripOptionsProvider>(context);

    return WillPopScope(
      onWillPop: () {
        return widget.boolcouponpage != true
            ? Twl.forceNavigateTo(context, OneWay())
            : Twl.forceNavigateTo(context, SearchLocation());
      },
      child: Scaffold(
        backgroundColor: tWhite,
        appBar: AppBar(
          elevation: 1,
          titleSpacing: 7,
          backgroundColor: tYellow,
          leading: GestureDetector(
              onTap: () {
                widget.boolcouponpage != true
                    ? Twl.forceNavigateTo(context, OneWay())
                    : Twl.forceNavigateTo(context, SearchLocation());

                // Twl.forceNavigateTo(context, OneWay());
              },
              child: Padding(
                padding: EdgeInsets.all(isTab(context) ? 10 : 12.0),
                child: BackIconWidget(),
              )),
          title: Text(
            'apply_coupons'.tr,
            style: TextStyle(
                color: tDarkNavyblue,
                fontSize: isTab(context) ? 10.sp : 16.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                color: tlightGray.withOpacity(0.2),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: TextFormField(
                  controller: _couponCodeController,
                  style: TextStyle(
                    fontSize: isTab(context) ? 10.sp : 12.sp,
                  ),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                      fillColor: tWhite,
                      filled: true,
                      hintText: 'enter_coupon_code'.tr,
                      hintStyle: GoogleFonts.mulish(
                        color: tGray,
                        fontWeight: FontWeight.w600,
                        fontSize: isTab(context) ? 8.sp : 12.sp,
                      ),
                      border: _inputBorder,
                      focusedBorder: _inputBorder,
                      enabledBorder: _inputBorder,
                      disabledBorder: _inputBorder,
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(5),
                        child: SizedBox(
                          width: isTab(context) ? 20.w : 25.w,
                          height: isTab(context) ? 5.h : 5.h,
                          child: ButtonWidget(
                            borderRadius: 8.0,
                            color: tPrimaryColor,
                            child: Text(
                              'apply'.tr,
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: tWhite,
                                  fontWeight: FontWeight.w700,
                                  fontSize: isTab(context) ? 9.sp : 12.sp),
                            ),
                            onTap:
                                (startLoading, stopLoading, btnState) async {},
                            borderSide: BorderSide(
                              color: tYellow,
                            ),
                          ),
                        ),
                      )),
                )),
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'available_coupons'.tr,
                style: GoogleFonts.mulish(
                  color: tDarkNavyblue,
                  fontWeight: FontWeight.w600,
                  fontSize: isTab(context) ? 10.sp : 14.sp,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: couponsData.length + 1,
                  itemBuilder: (context, index) {
                    if (index == couponsData.length) {
                      if (isLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    }

                    var coupon = couponsData[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: tWhite,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [tBoxShadow]),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                coupon['name'] ?? '',
                                // couponDetails.code.toString(),
                                style: GoogleFonts.mulish(
                                  color: tDarkNavyblue,
                                  fontWeight: FontWeight.w700,
                                  fontSize: isTab(context) ? 9.sp : 14.sp,
                                ),
                              ),
                              SizedBox(
                                width: isTab(context) ? 20.w : 25.w,
                                height: isTab(context) ? 5.h : 5.h,
                                child: ButtonWidget(
                                  borderRadius: 8.0,
                                  color: tPrimaryColor,
                                  child: Text(
                                    'apply'.tr,
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        color: tWhite,
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            isTab(context) ? 9.sp : 12.sp),
                                  ),
                                  onTap: (startLoading, stopLoading,
                                      btnState) async {
                                    startLoading();
                                    Map<String, String> param = {
                                      'coupon_id': coupon['id'].toString(),
                                      'estimate_price': tripOptionsProvider
                                          .estimateFare
                                          .toString(),
                                    };
                                    bool success = await tripOptionsProvider
                                        .applyCoupon(context, param);
                                    if (success) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'coupon_applied_successfully'.tr),
                                        ),
                                      );
                                      widget.boolcouponpage != true
                                          ? Twl.forceNavigateTo(
                                              context, OneWay())
                                          : Twl.forceNavigateTo(
                                              context, SearchLocation());

                                      // Twl.navigateTo(context, OneWay());
                                    } else {
                                      // Handle error or display error message
                                    }
                                    stopLoading();
                                  },
                                  borderSide: BorderSide(
                                    color: tPrimaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Get " + coupon['discount'].toString() + "% off",
                            style: GoogleFonts.mulish(
                              color: tGreen,
                              fontWeight: FontWeight.w600,
                              fontSize: isTab(context) ? 7.sp : 10.sp,
                            ),
                          ),
                          SizedBox(
                            height: 1.1.h,
                          ),
                          DottedLine(
                            direction: Axis.horizontal,
                            lineThickness: 0.5,
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width / 1,
                                child: Text(
                                  coupon['description'] ?? '',
                                  // 'Use code T20RIDE & get 60% off on ride maximum discount you get ₹100',
                                  // couponDetails.description.toString(),
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: tDarkOrangeColor,
                                      fontSize: isTab(context) ? 7.sp : 10.sp),
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    // isScrollControlled: true,
                                    // expand: false,
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                      ),
                                    ),
                                    builder: (context) => Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        child: Couponsbottomsheet(
                                          item: coupon,
                                        )),
                                  );
                                },
                                child: Text(
                                  'read_more'.tr,
                                  style: GoogleFonts.mulish(
                                    color: tRed,
                                    fontWeight: FontWeight.w600,
                                    fontSize: isTab(context) ? 8.sp : 10.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
