import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/globalWidgets/TextFieldWidgets.dart';
import 'package:base_project_flutter/globalWidgets/TextFildTital.dart';
import 'package:base_project_flutter/globalWidgets/button.dart';
import 'package:base_project_flutter/globalWidgets/buttonIconWidget.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:base_project_flutter/views/profilePage/components/emergencyContactPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class AddContact extends StatefulWidget {
  AddContact({
    Key? key,
    this.lastName,
    this.Email,
    this.DateOfBirth,
    this.gender,
    this.address,
    this.allContacts,
  }) : super(key: key);
  var firstName;
  var lastName;
  var Email;
  final DateOfBirth;
  var gender;
  var address;
  final allContacts;

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  @override
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _relationController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final _formKey = new GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 7,
          backgroundColor: tYellow,
          leading: GestureDetector(
              onTap: () {
                Twl.navigateBack(
                  context,
                );
              },
              child: Padding(
                padding: EdgeInsets.all(isTab(context) ? 10 : 12.0),
                child: BackIconWidget(),
              )),
          title: Text(' Add_Emergency_Contact'.tr,
              style: GoogleFonts.mulish(
                  color: tDarkNavyblue,
                  fontWeight: FontWeight.w800,
                  fontSize: isTab(context) ? 10.sp : 17.sp)),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 1.h,
                              ),
                              // Text(
                              //   'Person 1',
                              //   style: GoogleFonts.mulish(
                              //       fontWeight: FontWeight.w700,
                              //       color: tSecondaryColor,
                              //       fontSize: isTab(context) ? 16.sp : 18.sp),
                              // ),
                              Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 2),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: tWhite,
                                      boxShadow: [tBoxShadow]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      TextFildTital(
                                        text: 'name'.tr,
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      TextFieldWidgets(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'name_empty'.tr;
                                          } else {
                                            return null;
                                          }
                                        },
                                        hinttext: "Enter Your Your Full Name",
                                        controller: _firstNameController,
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      TextFildTital(
                                        text: 'phone_number'.tr,
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      TextFieldWidgets(
                                        validator: (value) {
                                          final RegExp regex =
                                              RegExp(r'^[6-9]');
                                          if (value!.isEmpty) {
                                            return 'mobile_number_can\'t_be_empty'
                                                .tr;
                                            //
                                          } else if (value.length != 10 &&
                                              value.length < 10) {
                                            return 'mobile_number_must_be_10_digits'
                                                .tr;
                                          } else if (!regex.hasMatch(value)) {
                                            return 'invalid_number'.tr;
                                          } else if (widget.allContacts
                                              .any((details) {
                                            return details['phone_number']
                                                    .toString() ==
                                                value;
                                          })) {
                                            return 'Phone Number exists'.tr;
                                          }
                                          return null;
                                        },
                                        inputFormater: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp(
                                            "[0-9]",
                                          )),
                                          LengthLimitingTextInputFormatter(10),
                                        ],
                                        keyboardTyp: TextInputType.number,
                                        hinttext: 'Eg : XXXXXXXXX'.tr,
                                        controller: _phoneController,
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      TextFildTital(
                                        text: 'relationship'.tr,
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      TextFieldWidgets(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'relation_empty'.tr;
                                          } else {
                                            return null;
                                          }
                                        },
                                        hinttext: 'Eg: father'.tr,
                                        controller: _relationController,
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      // TextFildTital(
                                      //   text: 'aadhar_number'.tr,
                                      // ),
                                      // SizedBox(
                                      //   height: 1.h,
                                      // ),
                                      // TextFieldWidgets(
                                      //   validator: (value) {
                                      //     if (value!.isEmpty) {
                                      //       return "aadhar_number_Cant_Be_Empty".tr;
                                      //     } else {
                                      //       return null;
                                      //     }
                                      //   },
                                      //   inputFormater: [
                                      //     LengthLimitingTextInputFormatter(12),
                                      //     FilteringTextInputFormatter.allow(
                                      //         RegExp('[0-9]')),
                                      //   ],
                                      //   keyboardTyp: TextInputType.number,
                                      //   hinttext: 'Eg: 1234 5678 9876'.tr,
                                      //   controller: _addharController,
                                      // ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
              Container(
                width: isTab(context) ? 50.w : 50.w,
                height: isTab(context) ? 6.h : 7.h,
                child: Button(
                  color: tPrimaryColor,
                  textcolor: tWhite,
                  bottonText: 'Save'.tr,
                  borderSide: BorderSide(
                    color: tPrimaryColor,
                  ),
                  // boxshadow: [tButtonBoxshadow],
                  onTap: (startLoading, stopLoading, btnState) async {
                    startLoading();
                    // showBarModalBottomSheet(
                    //     expand: false,
                    //     context: context,
                    //     backgroundColor: Colors.transparent,
                    //     builder: (context) => Container(
                    //         height: MediaQuery.of(context).size.height / 2,
                    //         child: ReferalCardView()));

                    if (_formKey.currentState!.validate()) {
                      print(_firstNameController.text);
                      print(_phoneController.text);
                      print(_relationController.text);

                      Map<String, String> param = {
                        'name': _firstNameController.text,
                        'phone_number': _phoneController.text,
                        'relationship': _relationController.text,
                      };
                      print(param);
                      var res =
                          await UserAPI().addEmergencyContacts(context, param);
                      if (res != null && res['status'] == 'OK') {
                        Twl.navigateTo(context, EmergencyContact());
                      } else {
                        stopLoading();
                        Twl.createAlert(
                            context, 'oops'.tr, res['error'].toString());
                        stopLoading();
                      }
                      stopLoading();
                    } else {
                      stopLoading();

                      // return _showDialog(context);
                    }
                    stopLoading();
                  },
                ),
              ),
              SizedBox(
                height: 2.h,
              )
            ],
          ),
        ));
  }
}
