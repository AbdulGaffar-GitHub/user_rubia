// import 'dart:html';

import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants.dart';
import '../../constants/imageConstant.dart';
import '../../globalFuctions/globalFunctions.dart';

import '../../globalWidgets/buttonWidget.dart';

import '../../globalWidgets/textformfieldWidget.dart';
import '../../responsive.dart';
import '../otpPage/otpPage.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  final TextEditingController _usernumbercontroller = TextEditingController();

  final _formKey = new GlobalKey<FormState>();

  late String username;
  bool isChecked = false;
  bool hasError = false;
  var resultHolder = 'Checkbox is UN-CHECKED';
  void toggleCheckbox(bool value) {
    if (isChecked == false) {
      setState(() {
        isChecked = true;
        resultHolder = 'Checkbox is CHECKED';
      });
    } else {
      setState(() {
        isChecked = false;
        resultHolder = 'Checkbox is UN-CHECKED';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tDarkNavyblue,
      body: WillPopScope(
        onWillPop: () {
          return Twl.willpopAlert(context);
        },
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                decoration: BoxDecoration(
                    color: tWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [tBoxShadow]),
                child: Column(
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    // Container(
                    //   width: isTab(context) ? 10.w : 18.w,
                    //   padding: EdgeInsets.all(3),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(15),
                    //     color: tPrimaryColor,
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'login'.tr,
                          style: GoogleFonts.mulish(
                            color: tDarkNavyblue,
                            fontWeight: FontWeight.w600,
                            fontSize: isTab(context) ? 15.sp : 20.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'mobile_number'.tr,
                            style: GoogleFonts.mulish(
                              color: tDarkOrangeColor,
                              fontWeight: FontWeight.w600,
                              fontSize: isTab(context) ? 16.sp : 15.sp,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          // Text(
                          //   "Mobile Number ",
                          //   style: TextStyle(
                          //       color: tGray,
                          //       fontSize: isTab(context) ? 9.sp : 12.sp,
                          //       fontWeight: FontWeight.w400),
                          // ),
                          SizedBox(height: 1.h),
                          TextFormFieldWidgets(
                            validator: (value) {
                              final RegExp regex = RegExp(r'^[6-9]');
                              if (value!.isEmpty) {
                                return 'mobile_number_can\'t_be_empty'.tr;
                                //
                              } else if (value.length != 10 &&
                                  value.length < 10) {
                                return 'mobile_number_must_be_10_digits'.tr;
                              } else if (!regex.hasMatch(value)) {
                                return 'invalid_number'.tr;
                              }
                            },
                            inputFormater: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(
                                "[0-9]",
                              )),
                              LengthLimitingTextInputFormatter(10),
                            ],
                            keyboardTyp: TextInputType.number,
                            hinttext: 'enter_mobile_number'.tr,
                            // style: TextStyle(color: tBlack),
                            hintStyl: TextStyle(color: tDarkNavyblue),
                            controller: _usernumbercontroller,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 2.w,
                          height: 1.h,
                        ),
                        Transform.scale(
                          scale: 1.0,
                          child: Checkbox(
                            side: MaterialStateBorderSide.resolveWith(
                              (states) => BorderSide(
                                width: 1.0,
                                color: tPrimaryColor,
                              ),
                            ),
                            focusColor: tGray,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1.80)),
                            value: isChecked,
                            onChanged: (value) {
                              toggleCheckbox(value!);
                            },
                            activeColor: tPrimaryColor,
                            checkColor: Colors.white,
                            tristate: false,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'i_agree_to_the'.tr,
                            style: GoogleFonts.mulish(
                              color: tDarkOrangeColor,
                              fontWeight: FontWeight.w600,
                              fontSize: isTab(context) ? 7.sp : 10.sp,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'terms_conditions'.tr,
                                style: GoogleFonts.mulish(
                                  color: tPrimaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: isTab(context) ? 7.sp : 10.sp,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    // SizedBox(height: tDefaultPadding * 3),
                    SizedBox(height: tDefaultPadding * 3),

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
                                // borderRadius: BorderRadius.circular(15),
                                borderRadius: 14.0,
                                color: tPrimaryColor,
                                textcolor: Colors.black,
                                child: Text(
                                  'login'.tr,
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      color: tWhite,
                                      fontWeight: FontWeight.w700,
                                      fontSize: isTab(context) ? 10.sp : 16.sp),
                                ),
                                onTap: (startLoading, stopLoading,
                                    btnState) async {
                                  startLoading();
                                  if (_formKey.currentState!.validate()) {
                                    startLoading();
                                    if (isChecked == true) {
                                      print(_usernumbercontroller.text);
                                      Map<String, String> param = {
                                        'contact_no':
                                            _usernumbercontroller.text,
                                      };
                                      print(param);
                                      var res = await UserAPI()
                                          .sendOtp(context, param);
                                      if (res != null &&
                                          res['status'] == 'OK') {
                                        Twl.navigateTo(
                                            context,
                                            Otppage(
                                              mobileNumber:
                                                  _usernumbercontroller.text,
                                              sessionCode: res['details']
                                                  ['Details'],
                                            ));
                                      } else {
                                        stopLoading();
                                        Twl.createAlert(context, 'Oops',
                                            res['error'].toString());
                                        stopLoading();
                                      }
                                      stopLoading();
                                    } else {
                                      stopLoading();
                                      return _showDialog(context);
                                    }
                                    stopLoading();
                                  }
                                })),
                      ),
                    ),

                    // SizedBox(height: 3.h),
                    // Container(
                    //   width: 80.w,
                    //   child: Text(
                    //     'Your number is safe with us, we don’t use your number for any unsolicited communication.',
                    //     textAlign: TextAlign.center,
                    //     style: GoogleFonts.mulish(
                    //       color: tlightGray,
                    //       fontWeight: FontWeight.w600,
                    //       fontSize: isTab(context) ? 7.sp : 9.sp,
                    //     ),
                    //   ),
                    // ),

                    // Row(
                    //   children: [
                    //     SizedBox(
                    //       width: 2.w,
                    //       height: 1.h,
                    //     ),
                    //     Transform.scale(
                    //       scale: 1.0,
                    //       child: Checkbox(
                    //         side: MaterialStateBorderSide.resolveWith(
                    //           (states) => BorderSide(
                    //             width: 1.0,
                    //           ),
                    //         ),
                    //         focusColor: tGray,
                    //         shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(1.80)),
                    //         value: isChecked,
                    //         onChanged: (value) {
                    //           toggleCheckbox(value!);
                    //         },
                    //         activeColor: tBlack,
                    //         checkColor: Colors.white,
                    //         tristate: false,
                    //       ),
                    //     ),
                    //     GestureDetector(
                    //       onTap: () => launch(TERMS_AND_CONDITIONS),
                    //       child: RichText(
                    //         text: TextSpan(
                    //           text: 'I agree to the ',
                    //           style: GoogleFonts.mulish(
                    //             color: tBlack,
                    //             fontWeight: FontWeight.w600,
                    //             fontSize: isTab(context) ? 7.sp : 10.sp,
                    //           ),
                    //           children: <TextSpan>[
                    //             TextSpan(
                    //               text: 'Terms & Conditions',
                    //               style: GoogleFonts.mulish(
                    //                 color: tBlue,
                    //                 fontWeight: FontWeight.w600,
                    //                 fontSize: isTab(context) ? 7.sp : 10.sp,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),

                    // SizedBox(height: tDefaultPadding * 3),
                    // SizedBox(height: tDefaultPadding * 3.5),
                    SizedBox(
                        height: isTab(context)
                            ? tDefaultPadding
                            : tDefaultPadding / 2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    // barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: new Text('alert'.tr),
        content: new Text('please_select_terms_conditions'.tr),
        actions: <Widget>[
          // ignore: deprecated_member_use
          new TextButton(
            child: new Text('ok'.tr),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
