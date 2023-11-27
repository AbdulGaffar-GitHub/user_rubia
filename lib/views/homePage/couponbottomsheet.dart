import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/globalWidgets/buttonwidget.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Couponsbottomsheet extends StatefulWidget {
  const Couponsbottomsheet({Key? key, this.item, this.index}) : super(key: key);
  final item;
  final index;

  @override
  State<Couponsbottomsheet> createState() => _CouponsbottomsheetState();
}

class _CouponsbottomsheetState extends State<Couponsbottomsheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      height: 30.h,
      decoration: BoxDecoration(
          color: tWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [tBoxShadow]),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.item['name'].toString()}',
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
                        fontSize: isTab(context) ? 9.sp : 12.sp),
                  ),
                  onTap: (startLoading, stopLoading, btnState) async {
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
          Text(
            "Get " + '${widget.item['discount'].toString()}' + "% off",
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
                  '${widget.item['description'].toString()}',
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
            ],
          ),
        ],
      ),
    );
//     Padding(
//       padding: const EdgeInsets.all(14.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           GestureDetector(
//             onTap: () {
//               Twl.navigateBack(context);
//             },
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 // Image.asset(
//                 //   Images.CROSSICON,
//                 //   scale: isTab(context) ? 2.5 : 3.5,
//                 // ),
//               ],
//             ),
//           ),
//           GestureDetector(
//             onTap: () async {
//               await Clipboard.setData(
//                   ClipboardData(text: ('${widget.item['code'].toString()}')));
//               // ScaffoldMessenger.of(context).showSnackBar(
//               //     SnackBar(
//               //       content: Text("${widget.item['code'].toString()}"),
//               //     ),

//               //   );
//               Fluttertoast.showToast(
//                 msg: "${widget.item['code'].toString()}",
//                 toastLength: Toast.LENGTH_SHORT,
//                 timeInSecForIosWeb: 1,
//                 // backgroundColor: Colors.black,
//                 textColor:tPrimaryColor,
//                 fontSize: 16.0,
//               );

//               // copied successfully
//             },
// //             onTap: (){
// //               Clipboard.setData( ClipboardData(text:('${widget.item['code'].toString()}')
// //                   )).then((_) {
// //                ScaffoldMessenger.of(context).showSnackBar(
// //       const SnackBar(content: Text('Copied to your clipboard !')));
// // });

// //                 },

//             child: Container(
//               padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
//               width: 32.w,
//               decoration: BoxDecoration(
//                   color: tPrimaryColor, borderRadius: BorderRadius.circular(6)),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Image.asset(
//                   //   Images.OFFER,
//                   //   scale: isTab(context) ? 5 : 6,
//                   // ),
//                   SizedBox(
//                     width: 1.w,
//                   ),
//                   Text('${widget.item['code'].toString()}'),
//                   SizedBox(
//                     width: 1.w,
//                   ),
//                   GestureDetector(
//                       onTap: () {
//                         final snackBar = SnackBar(
//                           content: const Text('Copied to Clipboard!'),
//                           action: SnackBarAction(
//                             label: 'Undo',
//                             onPressed: () {
//                               // Some code to undo the change.
//                             },
//                           ),
//                         );

//                         // Find the ScaffoldMessenger in the widget tree
//                         // and use it to show a SnackBar.
//                         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                       },
//                       child: Icon(
//                         Icons.copy,
//                         color: tBlack,
//                         size: isTab(context) ? 10 : 20,
//                       ))
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(height: 1.h),
//           Text(
//             'Flat ${widget.item['discount']}% Off'.toString(),
//             style: TextStyle(
//                 color: tBlack,
//                 fontWeight: FontWeight.w800,
//                 fontSize: isTab(context) ? 11.sp : 14.sp),
//           ),
//           SizedBox(height: 1.h),
//           Row(
//             children: [
//               Text(
//                 "Use this coupon on orders above ₹${widget.item['min_cart']} "
//                     .toString(),
//                 style: TextStyle(
//                     color: tGray,
//                     fontWeight: FontWeight.w500,
//                     fontSize: isTab(context) ? 9.sp : 12.sp),
//               ),
//               Text(
//                 "    ${widget.item['code']}".toString(),
//                 style: TextStyle(
//                     color: tBlack,
//                     fontWeight: FontWeight.w600,
//                     fontSize: isTab(context) ? 9.sp : 12.sp),
//               )
//             ],
//           ),
//           Divider(
//             color: tlightGray,
//             thickness: 0.9,
//             height: 40,
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10),
//             child: Text(
//               'Terms and Conditions',
//               style: TextStyle(
//                   color: tBlack,
//                   fontSize: isTab(context) ? 9.sp : 12.sp,
//                   fontWeight: FontWeight.w600),
//             ),
//           ),
//           SizedBox(
//             height: 0.7.h,
//           ),
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(3),
//                 decoration:
//                     BoxDecoration(color: tPrimaryColor, shape: BoxShape.circle),
//               ),
//               SizedBox(
//                 width: 1.w,
//               ),
//               Text(
//                 'Minimum order value of ₹${widget.item['min_cart']}'.toString(),
//                 style: TextStyle(
//                     // color: tGray,
//                     color: tBlack,
//                     fontSize: isTab(context) ? 9.sp : 12.sp,
//                     fontWeight: FontWeight.w500),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 0.5.h,
//           ),
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(3),
//                 decoration:
//                     BoxDecoration(color: tPrimaryColor, shape: BoxShape.circle),
//               ),
//               SizedBox(
//                 width: 1.w,
//               ),
//               Text(
//                 'Offer valid in select cities',
//                 style: TextStyle(
//                     color: tBlack,
//                     fontSize: isTab(context) ? 9.sp : 12.sp,
//                     fontWeight: FontWeight.w500),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 0.5.h,
//           ),
//           Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(3),
//                 decoration:
//                     BoxDecoration(color: tPrimaryColor, shape: BoxShape.circle),
//               ),
//               SizedBox(
//                 width: 1.w,
//               ),
//               Text(
//                 'Offer valid on select restaurants',
//                 style: TextStyle(
//                     color: tBlack,
//                     fontSize: isTab(context) ? 9.sp : 12.sp,
//                     fontWeight: FontWeight.w500),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
  }
}
