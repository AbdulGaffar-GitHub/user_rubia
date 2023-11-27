import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CustomPopup extends StatelessWidget {
  final String title;
  final String message;
  const CustomPopup(BuildContext context,
      {Key? key, required this.title, required this.message})
      : super(key: key);
  void showDeleteAddressModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: SingleChildScrollView(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        SizedBox(height: 5.h),
                        Center(
                          child: Text(
                            title,
                            style: TextStyle(
                              color: tSecondaryColor,
                              fontSize: isTab(context) ? 11.sp : 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 3.5.h),
                        Center(
                          child: Text(
                            message,
                            style: TextStyle(
                              color: tDarkOrangeColor,
                              fontSize: isTab(context) ? 9.sp : 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // Twl.forceNavigateTo(context, LoginScreen());
                              },
                              child: Container(
                                width: isTab(context) ? 50.w : 40.w,
                                height: isTab(context) ? 6.h : 7.h,
                                decoration: BoxDecoration(
                                  color: tWhite,
                                  border: Border.all(
                                      color: tCancelRidebtn, width: 2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    'Cancel'.tr,
                                    style: TextStyle(
                                      color: tCancelRidebtn,
                                      fontSize: isTab(context) ? 10.sp : 13.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                // var res = await UserAPI().deleteFavLocations(context, favLocationData['id'].toString());
                                // print(res);
                                // if (res != null && res['status'] == 'OK') {
                                //   Twl.forceNavigateTo(context, FavouriteLocation());
                                // } else {
                                //   Twl.createAlert(context, 'Oops', res['error'].toString());
                                // }
                              },
                              child: Container(
                                width: isTab(context) ? 50.w : 40.w,
                                height: isTab(context) ? 6.h : 7.h,
                                decoration: BoxDecoration(
                                  color: tPrimaryColor,
                                  border: Border.all(
                                      color: tPrimaryColor, width: 1.5),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    'Delete'.tr,
                                    style: TextStyle(
                                      color: tWhite,
                                      fontSize: isTab(context) ? 10.sp : 13.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 4.h),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -20,
                  left: isTab(context) ? 47.w : 45.w,
                  child: Container(
                    height: 6.h,
                    width: 6.h,
                    decoration: BoxDecoration(
                        // color: tWhite,
                        // border: Border.all(
                        //     color: tWhite, width: 4),
                        // borderRadius:
                        //     BorderRadius.circular(60),
                        // boxShadow: [tBoxShadow]
                        ),
                    child: Container(
                      height: 6.h,
                      width: 6.h,
                      decoration: BoxDecoration(
                          //     color: tPrimaryColor,
                          //     borderRadius:
                          //         BorderRadius.circular(30)
                          ),
                      child: Image.asset(
                        Images.DELETE,
                        scale: isTab(context) ? 2 : 3,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
