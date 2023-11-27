import 'dart:async';
import 'package:base_project_flutter/constants/imageConstant.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../api_services/userApi.dart';
import '../../constants/constants.dart';
import '../../globalFuctions/globalFunctions.dart';
import '../../globalWidgets/buttonWidget.dart';
import '../EmergencyContact/EmergencyContacts.dart';
import '../PersonalDetails/personalDetailsView.dart';
import '../bottomNavigation.dart/bottomNavigation.dart';

class Otppage extends StatefulWidget {
  Otppage({
    Key? key,
    this.sessionCode,
    this.mobileNumber,
  }) : super(key: key);

  final sessionCode;
  final mobileNumber;

  @override
  State<Otppage> createState() => _OtppageState();
}

class _OtppageState extends State<Otppage> {
  final TextEditingController _otpCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int _resendTimer = 30;
  bool hasError = false;
  var deviceToken;
  @override
  void initState() {
    super.initState();
    fecthDeviceToken();
  }

  @override
  void dispose() {
   // _otpCodeController.dispose();
    super.dispose();
  }

  void _startResendTimer() {
    _resendTimer = 30;
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendTimer > 0) {
          _resendTimer--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  fecthDeviceToken() {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.getToken().then((token) async {
      print(token);
      setState(() {
        deviceToken = token;
      });
      // await setValue("firebaseAppToken", token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tDarkNavyblue,
        body: WillPopScope(
          onWillPop: () {
            return Twl.navigateBack(context);
          },
          child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        child: Center(
                          child: Image.asset(
                            Images.LOGO,
                            scale: 4,
                            // height: isTab(context) ? 17.h : 13.h,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          boxShadow: [tBoxShadow],
                          color: tWhite,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 1.5.h,
                            ),
                            // Center(
                            //   child: Container(
                            //     width: isTab(context) ? 10.w : 18.w,
                            //     padding: EdgeInsets.all(3),
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(15),
                            //       color: tPrimaryColor,
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Twl.navigateBack(context);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: isTab(context) ? 6 : 4,
                                            horizontal: isTab(context) ? 6 : 4),
                                        decoration: BoxDecoration(
                                            boxShadow: [tBoxShadow],
                                            color: tWhite,
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: Center(
                                            child: Image.asset(
                                          Images.BACK_ICON,
                                          scale: isTab(context) ? 2.5 : 3.4,
                                        )))),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  'otp_verification'.tr,
                                  style: GoogleFonts.mulish(
                                    color: tDarkNavyblue,
                                    fontWeight: FontWeight.w800,
                                    fontSize: isTab(context) ? 15.sp : 20.sp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3.5.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'enter_otp'.tr,
                                    style: TextStyle(
                                      color: tDarkOrangeColor,
                                      fontSize: isTab(context) ? 10.sp : 12.sp,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(
                              children: [
                                // Text(
                                //   'send to',
                                //   style: TextStyle(
                                //     color: tGray,
                                //     fontSize: isTab(context) ? 10.sp : 10.sp,
                                //   ),
                                // ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                // Text(
                                //   widget.mobileNumber.toString(),
                                //   style: TextStyle(
                                //     color: tGray,
                                //     fontSize: isTab(context) ? 10.sp : 10.sp,
                                //   ),
                                // ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                // GestureDetector(
                                //   onTap: () {
                                //     Twl.navigateBack(context);
                                //   },
                                //   child: Image.asset(
                                //     Images.EDIT,
                                //     scale: 3,
                                //   ),
                                // )
                              ],
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: isTab(context) ? 100 : 25,
                              ),
                              child: PinCodeTextField(
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]")),
                                  LengthLimitingTextInputFormatter(4),
                                ],
                                //backgroundColor: Colors.white,
                                appContext: context,
                                textStyle: TextStyle(
                                  color: tDarkNavyblue,
                                  fontSize: isTab(context) ? 9.sp : 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                pastedTextStyle: TextStyle(
                                  color: tDarkNavyblue,
                                  fontWeight: FontWeight.bold,
                                ),

                                length: 4,
                                obscureText: false,
                                obscuringCharacter: '*',

                                blinkWhenObscuring: true,
                                animationType: AnimationType.fade,
                                validator: (v) {
                                  if (v!.length < 4 || v.length == 0) {
                                    return 'otp_length_not_match'.tr;
                                  } else {
                                    return null;
                                  }
                                },
                                pinTheme: PinTheme(
                                  borderWidth: 1,
                                  shape: PinCodeFieldShape.box,
                                  activeColor: Colors.transparent,
                                  selectedColor: Colors.transparent,
                                  selectedFillColor: tBackground,
                                  inactiveFillColor: tBackground,
                                  inactiveColor: tDarkNavyblue,
                                  borderRadius: BorderRadius.circular(12),
                                  fieldHeight: isTab(context) ? 10.w : 15.w,
                                  fieldWidth: isTab(context) ? 10.w : 15.w,
                                  activeFillColor:
                                      hasError ? Colors.white : tBackground,
                                ),
                                cursorColor: Colors.black,
                                animationDuration: Duration(milliseconds: 300),
                                enableActiveFill: true,
                                //errorAnimationController: errorController,
                                controller: _otpCodeController,
                                keyboardType: TextInputType.number,
                                // boxShadows: [tBoxShadow],
                                onCompleted: (v) {
                                  print("Completed");
                                },
                                onTap: () {
                                  print("Pressed");
                                },
                                onChanged: (value) {
                                  print(value);
                                  // setState(() {
                                  //   currentText = value;
                                  // });
                                },
                                beforeTextPaste: (text) {
                                  print("Allowing to paste $text");

                                  return true;
                                },
                              ),
                            ),

                            SizedBox(
                              height: 1.7.h,
                            ),
                            // Center(
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       ResendCodeButton(
                            //         onTap: () async {
                            //           if (_resendTimer == 0) {
                            //             Map<String, String> param = {
                            //               'contact_no':
                            //                   widget.mobileNumber.toString(),
                            //             };
                            //             var res = await UserAPI().sendOtp(
                            //               context,
                            //               param,
                            //             );
                            //             print(res);
                            //             if (res != null &&
                            //                 res['status'] == 'OK') {
                            //               Twl.navigateTo(
                            //                   context,
                            //                   Otppage(
                            //                     mobileNumber: widget
                            //                         .mobileNumber
                            //                         .toString(),
                            //                     sessionCode: res['details']
                            //                         ['Details'],
                            //                   ));
                            //             }
                            //           }
                            //           // Handle resend code functionality here
                            //           _startResendTimer();
                            //         },
                            //         initialTimer: _resendTimer,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ArgonTimerButton(
                                    elevation: 0,
                                    initialTimer: 30,
                                    height: isTab(context) ? 50 : 50,
                                    width: isTab(context) ? (70) : 70.w,
                                    borderRadius: isTab(context) ? 90 : 10,
                                    color: tWhite,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Don\'t receive the code?',
                                          textAlign: TextAlign.center,
                                          // maxLines: 1,
                                          style: GoogleFonts.mulish(
                                            color: tBlack,
                                            fontWeight: FontWeight.w700,
                                            fontSize:
                                                isTab(context) ? 8.sp : 10.sp,
                                          ),
                                        ),
                                        Text(
                                          ' Resend (30s)',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.mulish(
                                            color: tYellow,
                                            fontWeight: FontWeight.w700,
                                            fontSize:
                                                isTab(context) ? 8.sp : 10.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    loader: (timeLeft) {
                                      return Text(
                                        "$timeLeft",
                                        style: GoogleFonts.mulish(
                                          color: tBlack,
                                          fontWeight: FontWeight.w700,
                                          fontSize:
                                              isTab(context) ? 8.sp : 12.sp,
                                        ),
                                      );
                                    },
                                    onTap: (startTimer, btnState) async {
                                      if (btnState == ArgonButtonState.idle) {
                                        startTimer(30);
                                        Map<String, String> param = {
                                          'contact_no':
                                              widget.mobileNumber.toString(),
                                        };
                                        var res = await UserAPI().sendOtp(
                                          context,
                                          param,
                                        );
                                        print(res);
                                        if (res != null &&
                                            res['status'] == 'OK') {
                                          Twl.navigateTo(
                                              context,
                                              Otppage(
                                                mobileNumber: widget
                                                    .mobileNumber
                                                    .toString(),
                                                sessionCode: res['details']
                                                    ['Details'],
                                              ));
                                        }
                                      }
                                    }),
                              ],
                            ),
                            SizedBox(
                              height: tDefaultPadding * 4,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: SizedBox(
                                  width: isTab(context) ? 50.w : 60.w,
                                  height: isTab(context) ? 6.h : 7.h,
                                  child: ButtonWidget(
                                      borderSide: BorderSide(
                                        color: tPrimaryColor,
                                      ),
                                      color: tPrimaryColor,
                                      child: Text(
                                        'next'.tr,
                                        style: GoogleFonts.mulish(
                                          color: tWhite,
                                          fontWeight: FontWeight.w800,
                                          fontSize:
                                              isTab(context) ? 10.sp : 16.sp,
                                        ),
                                      ),
                                      borderRadius: 15.0,
                                      onTap: (startLoading, stopLoading,
                                          btnState) async {
                                        startLoading();
                                        if (_formKey.currentState!.validate()) {
                                          startLoading();
                                          print(widget.mobileNumber.toString());
                                          print(widget.sessionCode.toString());
                                          print(_otpCodeController.text);
                                          print(deviceToken.toString());
                                          SharedPreferences sharedPreferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          Map<String, String> params = {
                                            "contact_no":
                                                widget.mobileNumber.toString(),
                                            "session_code":
                                                widget.sessionCode.toString(),
                                            "otp_code": _otpCodeController.text,
                                            "device_token":
                                                deviceToken.toString(),
                                            "device_type": "1"
                                          };
                                          print('pinky${params}');
                                          print('obje');
                                          var res = await UserAPI()
                                              .verifyOtp(context, params);
                                          print(res);
                                          if (res != null &&
                                              res['status'] == 'OK') {
                                            print('object');
                                            sharedPreferences.setString(
                                                "authCode", res['auth_code']);
                                            var check = await UserAPI()
                                                .checkApi(res['auth_code']);
                                            print('checkkkk');
                                            print(check);
                                            if (check != null &&
                                                check['status'] == 'OK') {
                                              sharedPreferences.setString(
                                                  "contact_no",
                                                  check['detail']['contact_no']
                                                      .toString());
                                              sharedPreferences.setString(
                                                  "userId",
                                                  check['detail']['id']
                                                      .toString());
                                              sharedPreferences.setInt(
                                                  'USER_ID',
                                                  check['detail']['id']);
                                              sharedPreferences.setString(
                                                  "username",
                                                  check['detail']['username']
                                                      .toString());
                                              sharedPreferences.setString(
                                                  'userRole',
                                                  check['detail']['user_role']);
                                              if (check['detail']['email'] !=
                                                  null) {
                                                sharedPreferences.setString(
                                                    "email",
                                                    check['detail']['email']
                                                        .toString());
                                              }
                                              if (check['detail']['gender'] !=
                                                  null) {
                                                sharedPreferences.setString(
                                                    "gender",
                                                    check['detail']['gender']
                                                        .toString());
                                              }
                                              if (check['detail']
                                                      ['profile_image'] !=
                                                  null) {
                                                sharedPreferences.setString(
                                                    "profile_image",
                                                    check['detail']
                                                            ['profile_image']
                                                        .toString());
                                              }
                                              if (check['detail']
                                                      ['date_of_birth'] !=
                                                  null) {
                                                sharedPreferences.setString(
                                                    "date_of_birth",
                                                    check['detail']
                                                            ['date_of_birth']
                                                        .toString());
                                              }
                                              if (check['detail']['email'] ==
                                                  null) {
                                                Twl.forceNavigateTo(
                                                    context, PersonalDetails());

                                                setState(() {
                                                  stopLoading();
                                                });
                                              } else {
                                                if (check['detail'][
                                                        'user_emergency_contacts'] ==
                                                    false) {
                                                  Twl.forceNavigateTo(context,
                                                      EmergencyContact());
                                                } else {
                                                  Twl.navigateTo(context,
                                                      BottomNavigation());
                                                  stopLoading();
                                                }
                                              }
                                            } else {
                                              stopLoading();
                                              return Twl.createAlert(
                                                  context,
                                                  'Oops',
                                                  res['error'].toString());
                                              //stopLoading();
                                            }
                                            stopLoading();
                                            print("Otp" +
                                                " " +
                                                _otpCodeController.text);
                                          } else {
                                            stopLoading();
                                            return Twl.createAlert(
                                                context,
                                                'Oops',
                                                res['error'].toString());
                                            //stopLoading();
                                          }
                                          stopLoading();
                                        }
                                      }),
                                ),
                              ),
                            ),
                            SizedBox(
                                height: isTab(context)
                                    ? tDefaultPadding
                                    : tDefaultPadding / 2),
                          ],
                        ),
                      ),
                    ),
                  ])),
        ));
  }
}
