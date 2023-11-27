import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/globalWidgets/buttonWidget.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:base_project_flutter/views/profilePage/Components/AllOptionsCard.dart';
import 'package:base_project_flutter/views/profilePage/Components/ProfileCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../api_services/userApi.dart';
import '../homePage/homePage.dart';
import '../logiPage/loginPage.dart';
import 'Components/Terms&conditionsCard.dart';

class ProfilePageView extends StatefulWidget {
  const ProfilePageView({Key? key, this.checkDetails}) : super(key: key);
  final checkDetails;

  @override
  State<ProfilePageView> createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
  var checkDetails;
  checkLoginApi() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var check =
        await UserAPI().checkApi(sharedPreferences.getString('authCode')!);
    if (check != null && check['status'] == 'OK') {
      if (mounted) {
        setState(() {
          checkDetails = check['detail'];
          print('object');
          print(checkDetails);
        });
      }
    }
  }

  @override
  void initState() {
    checkLoginApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Twl.navigateTo(context, BottomNavigation()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: tappbarclr,
          automaticallyImplyLeading: false,
          title: Text(
            'profile'.tr,
            style: GoogleFonts.mulish(
              color: tDarkNavyblue,
              fontSize: isTab(context) ? 10.sp : 17.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              ProfileCard(
                checkDetails: widget.checkDetails,
              ),
              SizedBox(
                height: 2.h,
              ),
              AllOptionsCard(),
              SizedBox(
                height: 2.h,
              ),
              TermsConditionsCard(),
              SizedBox(
                height: 2.h,
              ),
              GestureDetector(
                // onTap: () {
                //   showDialog(
                //     context: context,
                //     barrierDismissible: false, // user must tap button!
                //     builder: (BuildContext context) {
                //       return AlertDialog(
                //         title: const Text('Are you sure you want to sign out?'),
                //         actions: <Widget>[
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.end,
                //             children: [
                //               GestureDetector(
                //                 onTap: () {
                //                   Twl.navigateBack(context);
                //                 },
                //                 child: Container(
                //                   alignment: Alignment.center,
                //                   padding: EdgeInsets.symmetric(
                //                       vertical: 4, horizontal: 10),
                //                   decoration: BoxDecoration(
                //                       border: Border.all(
                //                           width: 1, color: tPrimaryColor),
                //                       borderRadius: BorderRadius.circular(6)),
                //                   child: Text(
                //                     'Cancel',
                //                     style: TextStyle(color: tPrimaryColor),
                //                   ),
                //                 ),
                //               ),
                //               SizedBox(
                //                 width: 30,
                //               ),
                //               GestureDetector(
                //                 onTap: () async {
                //                   SharedPreferences sharedPreferences =
                //                       await SharedPreferences.getInstance();

                //                   var res = await UserAPI().getlogout(context);
                //                   print(res);
                //                   if (res != null && res['status'] == 'OK') {
                //                     await sharedPreferences.clear();
                //                     Twl.forceNavigateTo(context, LoginScreen());
                //                   } else {
                //                     AwesomeDialog(
                //                         context: context,
                //                         dialogType: DialogType.ERROR,
                //                         animType: AnimType.RIGHSLIDE,
                //                         headerAnimationLoop: true,
                //                         title: 'Logout Failed',
                //                         desc: 'Please retry',
                //                         btnOkOnPress: () {},
                //                         btnOkIcon: Icons.cancel,
                //                         btnOkColor: Colors.red);
                //                   }
                //                 },
                //                 child: Container(
                //                   alignment: Alignment.center,
                //                   padding: EdgeInsets.symmetric(
                //                       vertical: 4, horizontal: 10),
                //                   decoration: BoxDecoration(
                //                       border: Border.all(
                //                           width: 1, color: tPrimaryColor),
                //                       borderRadius: BorderRadius.circular(6)),
                //                   child: Text(
                //                     'OK',
                //                     style: TextStyle(color: tPrimaryColor),
                //                   ),
                //                 ),
                //               )
                //             ],
                //           )
                //         ],
                //       );
                //     },
                //   );
                // },
                child: GestureDetector(
                  onTap: () {
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Center(
                                          child: Text(
                                            'logout'.tr,
                                            style: TextStyle(
                                                color: tSecondaryColor,
                                                fontSize: isTab(context)
                                                    ? 11.sp
                                                    : 14.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3.5.h,
                                        ),
                                        Center(
                                          child: Text(
                                            'do_you_want'.tr,
                                            style: TextStyle(
                                                color: tSecondaryColor,
                                                fontSize: isTab(context)
                                                    ? 9.sp
                                                    : 12.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.5.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                SharedPreferences
                                                    sharedPreferences =
                                                    await SharedPreferences
                                                        .getInstance();

                                                var res = await UserAPI()
                                                    .getlogout(context);
                                                print(res);
                                                if (res != null &&
                                                    res['status'] == 'OK') {
                                                  await sharedPreferences
                                                      .clear();
                                                  Twl.forceNavigateTo(
                                                      context, LoginScreen());
                                                } else {
                                                  AwesomeDialog(
                                                      context: context,
                                                      dialogType:
                                                          DialogType.ERROR,
                                                      animType:
                                                          AnimType.RIGHSLIDE,
                                                      headerAnimationLoop: true,
                                                      title: 'logout_failed'.tr,
                                                      desc: 'please_retry'.tr,
                                                      btnOkOnPress: () {},
                                                      btnOkIcon: Icons.cancel,
                                                      btnOkColor: Colors.red);
                                                }
                                              },
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: isTab(context)
                                                          ? 12
                                                          : 10,
                                                      horizontal: isTab(context)
                                                          ? 18.5.w
                                                          : 16.5.w),
                                                  decoration: BoxDecoration(
                                                      color: tWhite,
                                                      border: Border.all(
                                                          color: tPrimaryColor,
                                                          width: 1.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Text(
                                                    'Yes'.tr,
                                                    style: TextStyle(
                                                        color: tPrimaryColor,
                                                        fontSize: isTab(context)
                                                            ? 10.sp
                                                            : 13.sp),
                                                  )),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Twl.navigateBack(context);
                                              },
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: isTab(context)
                                                          ? 12.5
                                                          : 10,
                                                      horizontal: isTab(context)
                                                          ? 18.5.w
                                                          : 16.5.w),
                                                  decoration: BoxDecoration(
                                                      color: tPrimaryColor,
                                                      border: Border.all(
                                                          color: tPrimaryColor,
                                                          width: 1.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Text(
                                                    'No'.tr,
                                                    style: TextStyle(
                                                        color: tWhite,
                                                        fontSize: isTab(context)
                                                            ? 10.sp
                                                            : 13.sp),
                                                  )),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        )
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
                                        Images.LOGOUT_ONE,
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
                  },
                  child: Container(
                    width: 45.w,
                    height: 7.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: tWhite,
                      boxShadow: [tBackbtnBoxShadow],
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: GestureDetector(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Images.LOG_OUT,
                                scale: 3.5,
                                color: tappbarclr,
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                'logout'.tr,
                                style: GoogleFonts.mulish(
                                    color: tappbarclr,
                                    fontWeight: FontWeight.w700,
                                    fontSize: isTab(context) ? 12.sp : 12.sp),
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
