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

import '../../../globalWidgets/textformfieldWidget.dart';

class EditContact extends StatefulWidget {
  EditContact({
    Key? key,
    this.lastName,
    this.Email,
    this.DateOfBirth,
    this.gender,
    this.address,
    this.contactListDetais,
    this.allContacts,
  }) : super(key: key);
  var firstName;
  var lastName;
  var Email;
  final DateOfBirth;
  var gender;
  var address;
  final contactListDetais;
  final allContacts;

  @override
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _relationController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.contactListDetais['name'].toString();
    _relationController.text =
        widget.contactListDetais['relationship'].toString();
    _phoneController.text = widget.contactListDetais['phone_number'].toString();
    print(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
    print(widget.allContacts);
    print(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
  }

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
          ),
        ),
        title: Text(
          'Edit_Emergency_Contact'.tr,
          style: GoogleFonts.mulish(
            color: tDarkNavyblue,
            fontWeight: FontWeight.w800,
            fontSize: isTab(context) ? 10.sp : 17.sp,
          ),
        ),
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
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 2),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: tWhite,
                              boxShadow: [tBoxShadow],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 2.h),
                                TextFildTital(
                                  text: 'Name',
                                ),
                                SizedBox(height: 1.h),
                                TextFieldWidgets(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Name Cant Be Empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                  hinttext: "E.g : John Doe",
                                  controller: _firstNameController,
                                ),
                                SizedBox(height: 2.h),
                                TextFildTital(
                                  text: 'Phone number',
                                ),
                                SizedBox(height: 1.h),
                                TextFieldWidgets(
                                  validator: (value) {
                                    final RegExp regex = RegExp(r'^[6-9]');
                                    if (value!.isEmpty) {
                                      return 'mobile_number_can\'t_be_empty'.tr;
                                      //
                                    } else if (value.length != 10 &&
                                        value.length < 10) {
                                      return 'mobile_number_must_be_10_digits'
                                          .tr;
                                    } else if (!regex.hasMatch(value)) {
                                      return 'invalid_number'.tr;
                                    } else if ((widget.allContacts
                                        .any((details) {
                                      return details['phone_number']
                                          .toString() ==
                                          value;
                                    })) &&
                                        (value !=
                                            widget.contactListDetais[
                                            'phone_number'])) {
                                      return 'Phone Number exists'.tr;
                                    }
                                    return null;
                                  },
                                  inputFormater: [
                                    LengthLimitingTextInputFormatter(10),
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9]')),
                                  ],
                                  keyboardTyp: TextInputType.number,
                                  hinttext: 'Eg : XXXXXXXXX'.tr,
                                  controller: _phoneController,
                                ),
                                SizedBox(height: 2.h),
                                TextFildTital(
                                  text: 'Relation ship',
                                ),
                                SizedBox(height: 1.h),
                                TextFieldWidgets(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Relation ship Cant Be Empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                  hinttext: 'Eg: father'.tr,
                                  controller: _relationController,
                                ),
                                SizedBox(height: 2.h),
                                SizedBox(height: 2.h),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: isTab(context) ? 50.w : 50.w,
              height: isTab(context) ? 6.h : 7.h,
              child: Button(
                color: tPrimaryColor,
                textcolor: tWhite,
                bottonText: 'Update',
                borderSide: BorderSide(color: tPrimaryColor),
                onTap: (startLoading, stopLoading, btnState) async {
                  startLoading();

                  if (_formKey.currentState!.validate()) {
                    Map<String, String> param = {
                      'name': _firstNameController.text,
                      'phone_number': _phoneController.text,
                      'relationship': _relationController.text,
                    };

                    var res = await UserAPI().editEmergencyContacts(
                      context,
                      widget.contactListDetais['id'].toString(),
                      param,
                    );

                    if (res != null && res['status'] == 'OK') {
                      Twl.navigateTo(context, EmergencyContact());
                    } else {
                      stopLoading();
                      Twl.createAlert(context, 'Oops', res['error'].toString());
                      stopLoading();
                    }
                  } else {
                    stopLoading();
                  }
                },
              ),
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}