import 'package:base_project_flutter/views/homePage/components/OneWay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/constants.dart';

import 'package:dotted_line/dotted_line.dart';

import '../../../globalFuctions/globalFunctions.dart';
import '../../../globalWidgets/buttonIconWidget.dart';
import '../../../globalWidgets/buttonWidget.dart';
import '../../../responsive.dart';

List getVechilesIndex = [];

class ApplyCoupon extends StatefulWidget {
  const ApplyCoupon(
      {Key? key, this.getVechileDetails, this.rideId, this.selectedIndex})
      : super(key: key);
  final getVechileDetails;
  final rideId;
  final selectedIndex;

  @override
  State<ApplyCoupon> createState() => _ApplyCuponPageState();
}

class _ApplyCuponPageState extends State<ApplyCoupon> {
  final TextEditingController _couponCodeController = TextEditingController();

  final _inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(
      color: tlightGray,
      width: 1,
    ),
  );
  // late Future<COUPOAN.CouponsListModel> myCoupons;
  // void initState() {
  //   super.initState();
  //   myCoupons = HomeApi().fetchCouponsList(context, '0');
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Twl.forceNavigateTo(context, OneWay());
        // Twl.forceNavigateTo(
        //     context,
        //     RideBookingPage(
        //       getVechileDetails: widget.getVechileDetails,
        //       rideId: widget.rideId,
        //       selectedIndex: widget.selectedIndex,
        //     ));
      },
      child: Scaffold(
          backgroundColor: tWhite,
          appBar: AppBar(
            elevation: 1,
            titleSpacing: 7,
            backgroundColor: tYellow,
            leading: GestureDetector(
                onTap: () {
                 Twl.forceNavigateTo(context, OneWay());
                  // Twl.forceNavigateTo(
                  //     context,
                  //     RideBookingPage(
                  //       getVechileDetails: widget.getVechileDetails,
                  //       rideId: widget.rideId,
                  //       selectedIndex: widget.selectedIndex,
                  //     ));
                },
                child: Padding(
                  padding: EdgeInsets.all(isTab(context) ? 10 : 12.0),
                  child: BackIconWidget(),
                )),
            title: Text(
              "Apply Coupons",
              style: TextStyle(
                  color: tDarkNavyblue,
                  fontSize: isTab(context) ? 10.sp : 16.sp,
                  fontWeight: FontWeight.w600),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
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
                          hintText: 'Enter Coupon Code',
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
                                  "Apply",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      color: tWhite,
                                      fontWeight: FontWeight.w700,
                                      fontSize: isTab(context) ? 9.sp : 12.sp),
                                ),
                                onTap: (startLoading, stopLoading,
                                    btnState) async {
                                  // startLoading();
                                  // Map<String, String> param = {
                                  //   'pickup_pincode': pickupPincode,
                                  //   'drop_pincode': dropPincode,
                                  //   'pickup_latitude': pickupLat,
                                  //   'pickup_longitude': pickupLng,
                                  //   'drop_latitude': dropLat,
                                  //   'drop_longitude': dropLng,
                                  //   'coupon_code': '',
                                  // };
                                  // print(param);
                                  // var res = await HomeApi()
                                  //     .getVechiles(context, param);
                                  // if (res != null && res['status'] == 'OK') {
                                  //   Twl.forceNavigateTo(
                                  //       context,
                                  //       RideBookingPage(
                                  //           getVechileDetails: res['details']));
                                  // } else {
                                  //   return showDialog(
                                  //     context: context,
                                  //     builder: (BuildContext context) {
                                  //       return AlertDialog(
                                  //         title: Text("Oops"),
                                  //         content:
                                  //             Text(res['error'].toString()),
                                  //         actions: <Widget>[
                                  //           TextButton(
                                  //             child: Text('ok'),
                                  //             onPressed: () {
                                  //               Twl.navigateBack(context);
                                  //             },
                                  //           ),
                                  //         ],
                                  //       );
                                  //     },
                                  //   );
                                  // }
                                  // stopLoading();
                                },
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
                    'Available coupons',
                    style: GoogleFonts.mulish(
                      color: tDarkNavyblue,
                      fontWeight: FontWeight.w600,
                      fontSize: isTab(context) ? 10.sp : 14.sp,
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      // controller: scrollController,
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        // var couponDetails = couponList[index];
                        return 
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              color: tWhite,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [tBoxShadow]),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'T20RIDE',
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
                                        "Apply",
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
                                        // Map<String, String> param = {
                                        //   'pickup_pincode': pickupPincode.toString(),
                                        //   'drop_pincode': dropPincode.toString(),
                                        //   'pickup_latitude': pickupLat.toString(),
                                        //   'pickup_longitude': pickupLng.toString(),
                                        //   'drop_latitude': dropLat.toString(),
                                        //   'drop_longitude': dropLng.toString(),
                                        //   'coupon_code': couponDetails.code.toString(),
                                        // };
                                        // print(param);
                                        // var res = await HomeApi().getVechiles(context, param);
                                        // if (res != null && res['status'] == 'OK') {
                                        //   for (var i = 0; i <= res['details'].length - 1; i++) {
                                        //     // getVechilesIndex.add(res['details'][i]['coupon_code']);
                                        //     print(res['details'][i]['coupon_code'].toString());
                                        //     if (res['details'][i]['coupon_code'] != null) {
                                        //       Twl.forceNavigateTo(
                                        //           context,
                                        //           RideBookingPage(
                                        //               selectedIndex: widget.selectedIndex,
                                        //               getVechileDetails: res['details']));
                                        //       ScaffoldMessenger.of(context)
                                        //           .showSnackBar(SnackBar(
                                        //         content: Text('Coupon added sucessfully'),
                                        //       ));
                                        //     } else {
                                        //       stopLoading();
                                        //       Twl.createAlert(context, 'Oops',
                                        //           res['details'][i]['error'].toString());
                                        //       stopLoading();
                                        //     }
                                        //   }
                                        // } else {
                                        //   return showDialog(
                                        //     context: context,
                                        //     builder: (BuildContext context) {
                                        //       return AlertDialog(
                                        //         title: Text("Oops"),
                                        //         content: Text(res['error'].toString()),
                                        //         actions: <Widget>[
                                        //           TextButton(
                                        //             child: Text('ok'),
                                        //             onPressed: () {
                                        //               Twl.navigateBack(context);
                                        //             },
                                        //           ),
                                        //         ],
                                        //       );
                                        //     },
                                        //   );
                                        // }
                                        stopLoading();
                                      },
                                      borderSide: BorderSide(
                                        color: tPrimaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // couponDetails.typeId == FLAT
                              //     ?
                              // Text(
                              //     "Get " +
                              //         currencySymbol +
                              //         couponDetails.discount.toString() +
                              //         " off",
                              //     style: GoogleFonts.mulish(
                              //       color: tGreen,
                              //       fontWeight: FontWeight.w600,
                              //       fontSize: isTab(context) ? 7.sp : 10.sp,
                              //     ),
                              //   )
                              // :
                              Text(
                                "Get " + '60' + "% off",
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
                              // Text(
                              //   couponDetails.description.toString(),
                              //   maxLines: 3,
                              //   // style: TextStyle(
                              //   //     color: tGray,
                              //   //     fontSize: isTab(context) ? 8.sp : 10.sp,
                              //   //     fontWeight: FontWeight.w400,
                              //   //     overflow: TextOverflow.ellipsis),
                              //   style: GoogleFonts.mulish(
                              //     color: tGray,
                              //     fontWeight:
                              //         isTab(context) ? FontWeight.w500 : FontWeight.w600,
                              //     fontSize: isTab(context) ? 7.sp : 10.sp,
                              //   ),
                              // ),
                              new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1,
                                    child: Text(
                                      'Use code T20RIDE & get 60% off on ride maximum discount you get ₹100',
                                      // couponDetails.description.toString(),
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: tDarkOrangeColor,
                                          fontSize:
                                              isTab(context) ? 7.sp : 10.sp),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        // descTextShowFlag = !descTextShowFlag;
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        // descTextShowFlag
                                        //     ? Text(
                                        //         "Read Less",
                                        //         style: GoogleFonts.mulish(
                                        //           color: tRed,
                                        //           fontWeight: FontWeight.w600,
                                        //           fontSize: isTab(context) ? 8.sp : 10.sp,
                                        //         ),
                                        //       )
                                        //     :

                                        Text(
                                          "Read more",
                                          style: GoogleFonts.mulish(
                                            color: tRed,
                                            fontWeight: FontWeight.w600,
                                            fontSize:
                                                isTab(context) ? 8.sp : 10.sp,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   height: 1.h,
                              // ),
                              // Text(
                              //   "Read more",
                              //   style: GoogleFonts.mulish(
                              //     color: tRed,
                              //     fontWeight: FontWeight.w600,
                              //     fontSize: isTab(context) ? 8.sp : 10.sp,
                              //   ),
                              // )
                            ],
                          ),
                        );
                     
                      },
                    )

                    // FutureBuilder<COUPOAN.CouponsListModel>(
                    //     future: myCoupons,
                    //     builder: (context, snapshot) {
                    //       if (snapshot.connectionState != ConnectionState.done) {
                    //         return Align(
                    //             alignment: Alignment.center,
                    //             child: SpinKitThreeBounce(
                    //               color: tPrimaryColor,
                    //               size: 20.0,
                    //             ));
                    //       }
                    //       if (snapshot.hasError) {
                    //         print('Error of coupons' + snapshot.error.toString());
                    //       }
                    //       if (snapshot.hasData) {
                    //         return Container(
                    //           child: CouponsListPagination(
                    //               couponData: snapshot.data,
                    //               selectedIndex: widget.selectedIndex),
                    //         );
                    //       } else {
                    //         return Center(child: Text('No coupons found'));
                    //       }
                    //     }),
                    ),
                SizedBox(
                  height: 2.h,
                )
              ],
            ),
          )),
    );
  }
}

// class CouponsListPagination extends StatefulWidget {
//   const CouponsListPagination({Key? key, this.couponData, this.selectedIndex})
//       : super(key: key);
//   final couponData;
//   final selectedIndex;

//   @override
//   State<CouponsListPagination> createState() => _CouponsListPaginationState();
// }

// class _CouponsListPaginationState extends State<CouponsListPagination> {
//   ScrollController scrollController = new ScrollController();
//   int page = 0;
//   bool descTextShowFlag = false;
//   bool isAlldoctors = true;
//   late List<COUPOAN.Detail> couponList;
//   late double scrollPosition;
//   var listText;
//   _scrollListener() {
//     if (scrollController.position.maxScrollExtent > scrollController.offset &&
//         scrollController.position.maxScrollExtent - scrollController.offset <=
//             95) {
//       print('End Scroll');
//       page = (page + 1);
//       HomeApi().fetchCouponsList(context, page.toString()).then((val) {
//         // currentPage = currentPage++;
//         if (val.details != null) {
//           setState(() {
//             // currentPage = currentPage + 1;
//             couponList.addAll(val.details);
//           });
//         } else {
//           return Center(
//             child: Text('End of data'),
//           );
//         }
//       });
//     }
//   }

//   void initState() {
//     fetchAddress();
//     scrollController = ScrollController();
//     couponList = widget.couponData.details;
//     scrollController.addListener(_scrollListener);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     scrollController.dispose();
//     super.dispose();
//   }

//   var pickupAddress;
//   var pickupLat;
//   var pickupLng;
//   var pickupPincode;
//   var dropAddress;
//   var dropLat;
//   var dropLng;
//   var dropPincode;
//   var userId;
//   fetchAddress() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     setState(() {
//       userId = sharedPreferences.getString('userId');
//       pickupAddress = sharedPreferences.getString('pickUpAddress');
//       pickupLat = sharedPreferences.getDouble('pickUplat');
//       pickupLng = sharedPreferences.getDouble('pickUplng');
//       pickupPincode = sharedPreferences.getString('pickUpPinCode');
//       //drop
//       dropAddress = sharedPreferences.getString('dropAddress');
//       dropLat = sharedPreferences.getDouble('droplat');
//       dropLng = sharedPreferences.getDouble('droplng');
//       dropPincode = sharedPreferences.getString('dropPinCode');
//       ;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return
//     ListView.builder(
//       itemCount: couponList.length,
//       shrinkWrap: true,
//       controller: scrollController,
//       scrollDirection: Axis.vertical,
//       physics: ScrollPhysics(),
//       itemBuilder: (context, index) {
//         var couponDetails = couponList[index];
//         return Container(
//           margin: EdgeInsets.symmetric(vertical: 5),
//           decoration: BoxDecoration(
//               color: tWhite,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [tBoxShadow]),
//           padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     couponDetails.code.toString(),
//                     style: GoogleFonts.mulish(
//                       color: tBlack,
//                       fontWeight: FontWeight.w700,
//                       fontSize: isTab(context) ? 9.sp : 14.sp,
//                     ),
//                   ),
//                   SizedBox(
//                     width: isTab(context) ? 20.w : 25.w,
//                     height: isTab(context) ? 5.h : 5.h,
//                     child: ButtonWidget(
//                       borderRadius: 8.0,
//                       color: tPrimaryColor,
//                       child: Text(
//                         "Apply",
//                         style: TextStyle(
//                             letterSpacing: 1,
//                             color: tBlack,
//                             fontWeight: FontWeight.w600,
//                             fontSize: isTab(context) ? 9.sp : 12.sp),
//                       ),
//                       onTap: (startLoading, stopLoading, btnState) async {
//                         startLoading();
//                         Map<String, String> param = {
//                           'pickup_pincode': pickupPincode.toString(),
//                           'drop_pincode': dropPincode.toString(),
//                           'pickup_latitude': pickupLat.toString(),
//                           'pickup_longitude': pickupLng.toString(),
//                           'drop_latitude': dropLat.toString(),
//                           'drop_longitude': dropLng.toString(),
//                           'coupon_code': couponDetails.code.toString(),
//                         };
//                         print(param);
//                         var res = await HomeApi().getVechiles(context, param);
//                         if (res != null && res['status'] == 'OK') {
//                           for (var i = 0; i <= res['details'].length - 1; i++) {
//                             // getVechilesIndex.add(res['details'][i]['coupon_code']);
//                             print(res['details'][i]['coupon_code'].toString());
//                             if (res['details'][i]['coupon_code'] != null) {
//                               Twl.forceNavigateTo(
//                                   context,
//                                   RideBookingPage(
//                                       selectedIndex: widget.selectedIndex,
//                                       getVechileDetails: res['details']));
//                               ScaffoldMessenger.of(context)
//                                   .showSnackBar(SnackBar(
//                                 content: Text('Coupon added sucessfully'),
//                               ));
//                             } else {
//                               stopLoading();
//                               Twl.createAlert(context, 'Oops',
//                                   res['details'][i]['error'].toString());
//                               stopLoading();
//                             }
//                           }
//                         } else {
//                           return showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 title: Text("Oops"),
//                                 content: Text(res['error'].toString()),
//                                 actions: <Widget>[
//                                   TextButton(
//                                     child: Text('ok'),
//                                     onPressed: () {
//                                       Twl.navigateBack(context);
//                                     },
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         }
//                         stopLoading();
//                       },
//                       borderSide: BorderSide(
//                         color: tPrimaryColor,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               couponDetails.typeId == FLAT
//                   ? Text(
//                       "Get " +
//                           currencySymbol +
//                           couponDetails.discount.toString() +
//                           " off",
//                       style: GoogleFonts.mulish(
//                         color: tGreen,
//                         fontWeight: FontWeight.w600,
//                         fontSize: isTab(context) ? 7.sp : 10.sp,
//                       ),
//                     )
//                   : Text(
//                       "Get " + couponDetails.discount.toString() + "% off",
//                       style: GoogleFonts.mulish(
//                         color: tGreen,
//                         fontWeight: FontWeight.w600,
//                         fontSize: isTab(context) ? 7.sp : 10.sp,
//                       ),
//                     ),
//               SizedBox(
//                 height: 1.1.h,
//               ),
//               DottedLine(
//                 direction: Axis.horizontal,
//                 lineThickness: 0.5,
//               ),
//               SizedBox(
//                 height: 1.5.h,
//               ),
//               // Text(
//               //   couponDetails.description.toString(),
//               //   maxLines: 3,
//               //   // style: TextStyle(
//               //   //     color: tGray,
//               //   //     fontSize: isTab(context) ? 8.sp : 10.sp,
//               //   //     fontWeight: FontWeight.w400,
//               //   //     overflow: TextOverflow.ellipsis),
//               //   style: GoogleFonts.mulish(
//               //     color: tGray,
//               //     fontWeight:
//               //         isTab(context) ? FontWeight.w500 : FontWeight.w600,
//               //     fontSize: isTab(context) ? 7.sp : 10.sp,
//               //   ),
//               // ),
//               new Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Container(
//                     width: descTextShowFlag
//                         ? MediaQuery.of(context).size.width / 1
//                         : MediaQuery.of(context).size.width / 1,
//                     child: Text(couponDetails.description.toString(),
//                         maxLines: descTextShowFlag ? 5 : 1,
//                         overflow: TextOverflow.ellipsis,
//                         textAlign: TextAlign.start),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         descTextShowFlag = !descTextShowFlag;
//                       });
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         descTextShowFlag
//                             ? Text(
//                                 "Read Less",
//                                 style: GoogleFonts.mulish(
//                                   color: tRed,
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: isTab(context) ? 8.sp : 10.sp,
//                                 ),
//                               )
//                             : Text(
//                                 "Read more",
//                                 style: GoogleFonts.mulish(
//                                   color: tRed,
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: isTab(context) ? 8.sp : 10.sp,
//                                 ),
//                               )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               // SizedBox(
//               //   height: 1.h,
//               // ),
//               // Text(
//               //   "Read more",
//               //   style: GoogleFonts.mulish(
//               //     color: tRed,
//               //     fontWeight: FontWeight.w600,
//               //     fontSize: isTab(context) ? 8.sp : 10.sp,
//               //   ),
//               // )
//             ],
//           ),
//         );
//       },
//     );

//   }
// }
