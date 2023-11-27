// import 'package:base_project_flutter/api_services/userApi.dart';
// import 'package:base_project_flutter/views/WalletPage/components/HistoryBottomSheet.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sizer/sizer.dart';
// import 'package:intl/intl.dart';
// import '../../../../constants/constants.dart';
// import '../../../../responsive.dart';
// import '../../../constants/imageConstant.dart';
// import '../../../models/walletTransactionsModel.dart' as TRANSCATION;

// class TransactionDetailsWidget extends StatefulWidget {
//   const TransactionDetailsWidget({
//     Key? key,
//     this.selectedType,
//   }) : super(key: key);
//   final selectedType;

//   @override
//   State<TransactionDetailsWidget> createState() =>
//       _TransactionDetailsWidgetState();
// }

// class _TransactionDetailsWidgetState extends State<TransactionDetailsWidget> {
//   bool selected = true;
//   List imageView = [
//     Images.DOWNRED,
//     Images.UPGREEN,
//     Images.DOWNRED,
//     Images.UPGREEN,
//   ];
//   List title = ["Debit".tr, "Credit".tr, "Debit".tr, "Credit".tr];
//   List amount = ["-₹4.0", "+₹100.0", "-₹4.0", "+₹100.0"];
//   late Future<TRANSCATION.WalletTransactionModel> allTranscation;
//   void initState() {
//     super.initState();
//     allTranscation = UserAPI().allTranscations(
//       context,
//       '0',
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 1.h),
//           child: GestureDetector(
//             onTap: () {},
//             child: Container(
//               padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
//               decoration: BoxDecoration(
//                   color: tWhite,
//                   boxShadow: [tBoxShadow],
//                   borderRadius: BorderRadius.all(Radius.circular(10))),
//               child: Row(
//                 children: [
//                   Text(
//                     "All_Transactions".tr,
//                     style: GoogleFonts.mulish(
//                       color: tSecondaryColor,
//                       fontSize: isTab(context) ? 13.sp : 14.sp,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   Spacer(),
//                   GestureDetector(
//                     onTap: () {
//                       showModalBottomSheet(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(12),
//                                   topRight: Radius.circular(12))),
//                           context: context,
//                           builder: (context) => Container(
//                                 height: isTab(context) ? 40.h : 40.h,
//                                 child: HistoryBottomSheet(
//                                   walletTranscation: true,
//                                 ),
//                               ));
//                     },
//                     child: Row(
//                       children: [
//                         Text(
//                           widget.selectedType == null
//                               ? 'Select_Date'.tr
//                               : widget.selectedType,
//                           style: GoogleFonts.mulish(
//                             color: tPrimaryColor,
//                             fontSize: isTab(context) ? 12.sp : 14.sp,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         Icon(
//                           selected
//                               ? Icons.keyboard_arrow_down
//                               : Icons.keyboard_arrow_up,
//                           size: isTab(context) ? 45 : 30,
//                           color: tPrimaryColor,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 0.h,
//         ),

//         // Padding(
//         //   padding: EdgeInsets.symmetric(horizontal: 1.5.h, vertical: 0.3.h),
//         //   child: Card(
//         //     shape:
//         //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         //     child: Container(
//         //       decoration: BoxDecoration(
//         //           color: tWhite, borderRadius: BorderRadius.circular(10)),
//         //       child: Padding(
//         //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         //         child: Column(
//         //           children: [
//         //             Row(
//         //               children: [
//         //                 Container(
//         //                     padding: EdgeInsets.symmetric(
//         //                         vertical: 1.h, horizontal: 1.h),
//         //                     decoration: BoxDecoration(
//         //                         shape: BoxShape.circle, color: tBackground),
//         //                     child:
//         //                         //  transcationDetail.paymentType ==
//         //                         //         STATUS_CREDITED
//         //                         //     ?
//         //                         Image.asset(
//         //                       Images.DOWNRED,
//         //                       color: tRed,
//         //                       scale: 3,
//         //                     )
//         //                     // : Image.asset(
//         //                     //     Images.DOWNRED,
//         //                     //     color: tRed,
//         //                     //     scale: 3,
//         //                     //   )
//         //                     ),
//         //                 SizedBox(
//         //                   width: 1.h,
//         //                 ),
//         //                 Column(
//         //                   crossAxisAlignment: CrossAxisAlignment.start,
//         //                   children: [
//         //                     // transcationDetail.paymentType == STATUS_DEBITED
//         //                     //     ?
//         //                     Text(
//         //                       'Debit'.tr,
//         //                       style: GoogleFonts.mulish(
//         //                           fontSize: isTab(context) ? 10.sp : 13.sp,
//         //                           fontWeight: FontWeight.w700,
//         //                           color: tSecondaryColor),
//         //                     ),
//         //                     // : Text(
//         //                     //     'Credit',
//         //                     //     style: GoogleFonts.mulish(
//         //                     //         fontSize:
//         //                     //             isTab(context) ? 10.sp : 13.sp,
//         //                     //         fontWeight: FontWeight.w700,
//         //                     //         color: tWhite),
//         //                     //   ),
//         //                     SizedBox(
//         //                       height: 0.5.h,
//         //                     ),
//         //                     Text(
//         //                       '25 May 2022',
//         //                       // DateFormat(' d MMM yyyy')
//         //                       //     .format(transcationDetail.updatedOn),
//         //                       style: GoogleFonts.mulish(
//         //                           fontSize: 10.sp,
//         //                           fontWeight: FontWeight.w500,
//         //                           color: tDate),
//         //                     )
//         //                   ],
//         //                 ),
//         //                 Spacer(),
//         //                 Row(
//         //                   children: [
//         //                     SizedBox(
//         //                       width: 1.h,
//         //                     ),
//         //                     // transcationDetail.paymentType == STATUS_CREDITED
//         //                     //     ?
//         //                     Text('-' + currencySymbol + '100',
//         //                         // transcationDetail.amount.toString(),
//         //                         style: GoogleFonts.mulish(
//         //                           fontSize: isTab(context) ? 9.sp : 12.sp,
//         //                           fontWeight: FontWeight.w600,
//         //                           color: tRed,
//         //                         ))
//         //                     // : Text(
//         //                     //     currencySymbol +'0',
//         //                     //         // transcationDetail.amount.toString(),
//         //                     //     style: GoogleFonts.mulish(
//         //                     //       fontSize: isTab(context) ? 9.sp : 12.sp,
//         //                     //       fontWeight: FontWeight.w600,
//         //                     //       color: tRed,
//         //                     //     )),
//         //                   ],
//         //                 )
//         //               ],
//         //             ),
//         //             SizedBox(
//         //               height: 1.h,
//         //             ),
//         //             // DottedLine(
//         //             //   direction: Axis.horizontal,
//         //             //   lineLength: double.infinity,
//         //             //   lineThickness: 1.0,
//         //             //   dashLength: 4.0,
//         //             //   dashColor: tGray,
//         //             //   dashRadius: 0.0,
//         //             //   dashGapLength: 4.0,
//         //             //   dashGapColor: Colors.transparent,
//         //             //   dashGapRadius: 1.0,
//         //             // ),
//         //             // SizedBox(
//         //             //   height: 1.h,
//         //             // ),
//         //             // Container(
//         //             //   margin: EdgeInsets.only(left: 20),
//         //             //   width: MediaQuery.of(context).size.width / 1.5,
//         //             //   child: Text(
//         //             //     'abcd',
//         //             //     // transcationDetail.methodReason.toString(),
//         //             //     textAlign: TextAlign.start,
//         //             //     style: GoogleFonts.mulish(
//         //             //         fontSize: isTab(context) ? 07.sp : 10.sp,
//         //             //         fontWeight: FontWeight.w500,
//         //             //         color: tPrimaryColor),
//         //             //   ),
//         //             // ),
//         //           ],
//         //         ),
//         //       ),
//         //     ),
//         //   ),
//         // ),

//         Container(
//             child: FutureBuilder<TRANSCATION.WalletTransactionModel>(
//                 future: allTranscation,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState != ConnectionState.done) {
//                     return Container(
//                       child: Align(
//                         alignment: Alignment.center,
//                         child: SpinKitThreeBounce(
//                           color: tPrimaryColor,
//                           size: 20.0,
//                         ),
//                       ),
//                     );
//                   }
//                   if (snapshot.hasError) {
//                     print('Error of coupons' + snapshot.error.toString());
//                   }
//                   if (snapshot.hasData) {
//                     return Padding(
//                       padding: EdgeInsets.symmetric(vertical: 10),
//                       child: Container(
//                         child:
//                             TranscationsPagination(snapShotData: snapshot.data),
//                       ),
//                     );
//                   } else {
//                     return Center(
//                         child: Text(
//                       'No transcations found',
//                       style: TextStyle(color: tWhite),
//                     ));
//                   }
//                 })),
//       ],
//     );
//   }
// }

// class TranscationsPagination extends StatefulWidget {
//   const TranscationsPagination({Key? key, this.snapShotData}) : super(key: key);
//   final snapShotData;

//   @override
//   State<TranscationsPagination> createState() => _TranscationsPaginationState();
// }

// class _TranscationsPaginationState extends State<TranscationsPagination> {
//   ScrollController scrollController = new ScrollController();
//   int page = 0;
//   late List<TRANSCATION.Detail> transcationList;
//   late double scrollPosition;
//   var listText;
//   _scrollListener() {
//     if (scrollController.position.maxScrollExtent > scrollController.offset &&
//         scrollController.position.maxScrollExtent - scrollController.offset <=
//             95) {
//       print('End Scroll');
//       page = (page + 1);
//       UserAPI().allTranscations(context, page.toString()).then((val) {
//         // currentPage = currentPage++;
//         if (val.details != null) {
//           setState(() {
//             // currentPage = currentPage + 1;
//             transcationList.addAll(val.details);
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
//     scrollController = ScrollController();
//     transcationList = widget.snapShotData.details;
//     scrollController.addListener(_scrollListener);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         controller: scrollController,
//         itemCount: transcationList.length,
//         physics: ScrollPhysics(),
//         shrinkWrap: true,
//         itemBuilder: (BuildContext context, index) {
//           var transcationDetail = transcationList[index];
//           return Padding(
//             padding: EdgeInsets.symmetric(horizontal: 1.5.h, vertical: 0.3.h),
//             child: Card(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10)),
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: tWhite, borderRadius: BorderRadius.circular(10)),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Container(
//                               padding: EdgeInsets.symmetric(
//                                   vertical: 1.h, horizontal: 1.h),
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.circle, color: tBackground),
//                               child: transcationDetail.paymentType ==
//                                       payment_type_credit
//                                   ? Image.asset(
//                                       Images.UPGREEN,
//                                       color: tGreen,
//                                       scale: 3,
//                                     )
//                                   : Image.asset(
//                                       Images.DOWNRED,
//                                       color: tRed,
//                                       scale: 3,
//                                     )),
//                           SizedBox(
//                             width: 1.h,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               transcationDetail.paymentType ==
//                                       payment_type_debit
//                                   ? Text(
//                                       'Credit'.tr,
//                                       style: GoogleFonts.mulish(
//                                           fontSize:
//                                               isTab(context) ? 10.sp : 13.sp,
//                                           fontWeight: FontWeight.w700,
//                                           color: tSecondaryColor),
//                                     )
//                                   : Text(
//                                       'Debit',
//                                       style: GoogleFonts.mulish(
//                                           fontSize:
//                                               isTab(context) ? 10.sp : 13.sp,
//                                           fontWeight: FontWeight.w700,
//                                           color: tSecondaryColor),
//                                     ),
//                               SizedBox(
//                                 height: 0.5.h,
//                               ),
//                               Text(
//                                 // '25 May 2022',
//                                 DateFormat(' d MMM yyyy')
//                                     .format(transcationDetail.updatedOn),
//                                 style: GoogleFonts.mulish(
//                                     fontSize: 10.sp,
//                                     fontWeight: FontWeight.w500,
//                                     color: tDate),
//                               )
//                             ],
//                           ),
//                           Spacer(),
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 1.h,
//                               ),
//                               transcationDetail.paymentType ==
//                                       payment_type_credit
//                                   ? Text(
//                                       '+' +
//                                           currencySymbol +
//                                           transcationDetail.amount.toString(),
//                                       style: GoogleFonts.mulish(
//                                         fontSize: isTab(context) ? 9.sp : 12.sp,
//                                         fontWeight: FontWeight.w600,
//                                         color: tGreen,
//                                       ))
//                                   : Text(
//                                       currencySymbol +
//                                           transcationDetail.amount.toString(),
//                                       style: GoogleFonts.mulish(
//                                         fontSize: isTab(context) ? 9.sp : 12.sp,
//                                         fontWeight: FontWeight.w600,
//                                         color: tRed,
//                                       )),
//                             ],
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: 1.h,
//                       ),
//                       // DottedLine(
//                       //   direction: Axis.horizontal,
//                       //   lineLength: double.infinity,
//                       //   lineThickness: 1.0,
//                       //   dashLength: 4.0,
//                       //   dashColor: tGray,
//                       //   dashRadius: 0.0,
//                       //   dashGapLength: 4.0,
//                       //   dashGapColor: Colors.transparent,
//                       //   dashGapRadius: 1.0,
//                       // ),
//                       // SizedBox(
//                       //   height: 1.h,
//                       // ),
//                       // Container(
//                       //   margin: EdgeInsets.only(left: 20),
//                       //   width: MediaQuery.of(context).size.width / 1.5,
//                       //   child: Text(
//                       //     'abcd',
//                       //     // transcationDetail.methodReason.toString(),
//                       //     textAlign: TextAlign.start,
//                       //     style: GoogleFonts.mulish(
//                       //         fontSize: isTab(context) ? 07.sp : 10.sp,
//                       //         fontWeight: FontWeight.w500,
//                       //         color: tPrimaryColor),
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         });
//   }
// }
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/globalWidgets/buttonIconWidget.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/homePage/components/OneWay.dart';
import 'package:dotted_line/dotted_line.dart';

import '../../../constants/imageConstant.dart';
import '../../../globalWidgets/buttonwidget.dart';
import 'HistoryBottomSheet.dart';

class TransactionDetailsWidget extends StatefulWidget {
  const TransactionDetailsWidget({
    Key? key,
    this.selectedType,
  }) : super(key: key);

  final selectedType;

  @override
  _TransactionDetailsWidgetState createState() =>
      _TransactionDetailsWidgetState();
}

class _TransactionDetailsWidgetState extends State<TransactionDetailsWidget> {
  UserAPI userAPI = UserAPI();
  List<dynamic> transactionData = [];
  bool isLoading = false;
  bool descTextShowFlag = false;
  int currentPage = 0;
  ScrollController _scrollController = ScrollController();
  bool selected = true;

  @override
  void initState() {
    super.initState();
    fetchTransaction();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchTransaction();
      }
    });
  }

  Future<void> fetchTransaction() async {
    if (isLoading) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      dynamic response = await userAPI.walletTransactionWithoutModel(
        context,
        currentPage.toString(),
      );
      List<dynamic> newTransactionData = response['details'] ?? [];
      setState(() {
        transactionData.addAll(newTransactionData);
        currentPage++;
        isLoading = false;
      });
    } catch (e) {
      // Handle error
      print('Error fetching Transaction: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 1.h),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
                  decoration: BoxDecoration(
                    color: tWhite,
                    boxShadow: [tBoxShadow],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'all_transactions'.tr,
                        style: GoogleFonts.mulish(
                          color: tSecondaryColor,
                          fontSize: isTab(context) ? 13.sp : 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            context: context,
                            builder: (context) => Container(
                              height: isTab(context) ? 40.h : 40.h,
                              child: HistoryBottomSheet(
                                walletTranscation: true,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              widget.selectedType == null
                                  ? 'Today'
                                  : widget.selectedType,
                              style: GoogleFonts.mulish(
                                color: tPrimaryColor,
                                fontSize: isTab(context) ? 12.sp : 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              selected
                                  ? Icons.keyboard_arrow_down
                                  : Icons.keyboard_arrow_up,
                              size: isTab(context) ? 45 : 30,
                              color: tPrimaryColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 0.h,
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: transactionData.length + 1,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  if (index == transactionData.length) {
                    if (isLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: tPrimaryColor,
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  }
                  var transactionDetail = transactionData[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 1.5.h, vertical: 0.3.h),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: tWhite,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 1.h,
                                        horizontal: 1.h,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: tBackground,
                                      ),
                                      child:
                                          transactionDetail['payment_type'] ==
                                                  payment_type_credit
                                              ? Image.asset(
                                                  Images.UPGREEN,
                                                  color: tGreen,
                                                  scale: 3,
                                                )
                                              : Image.asset(
                                                  Images.DOWNRED,
                                                  color: tRed,
                                                  scale: 2.5,
                                                ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            transactionDetail['payment_type'] ==
                                                    payment_type_debit
                                                ? Text(
                                                    'Debit'.tr,
                                                    style: GoogleFonts.mulish(
                                                      fontSize: isTab(context)
                                                          ? 10.sp
                                                          : 13.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: tSecondaryColor,
                                                    ),
                                                  )
                                                : Text(
                                                    'Credit'.tr,
                                                    style: GoogleFonts.mulish(
                                                      fontSize: isTab(context)
                                                          ? 10.sp
                                                          : 13.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: tSecondaryColor,
                                                    ),
                                                  ),
                                            SizedBox(width: 30.w),
                                            transactionDetail['payment_type'] ==
                                                    payment_type_credit
                                                ? Container(
                                                    child: Text(
                                                      '+' +
                                                          currencySymbol +
                                                          transactionDetail[
                                                                  'amount']
                                                              .toString(),
                                                      style: GoogleFonts.mulish(
                                                        fontSize: isTab(context)
                                                            ? 9.sp
                                                            : 12.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: tGreen,
                                                      ),
                                                    ),
                                                  )
                                                : Text(
                                                    '-' +
                                                        currencySymbol +
                                                        transactionDetail[
                                                                'amount']
                                                            .toString(),
                                                    style: GoogleFonts.mulish(
                                                      fontSize: isTab(context)
                                                          ? 9.sp
                                                          : 12.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: tRed,
                                                    ),
                                                  )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Text(
                                          Twl.dateActualFormate(
                                            transactionDetail['updated_on'],
                                          ).toString(),
                                          style: GoogleFonts.mulish(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500,
                                            color: tDate,
                                          ),
                                        ),
                                        Text(
                                          transactionDetail['method_reason']
                                              .toString(),
                                          overflow: TextOverflow.clip,
                                          style: GoogleFonts.mulish(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500,
                                            color: tDate,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
