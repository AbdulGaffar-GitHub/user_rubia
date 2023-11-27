// ignore_for_file: override_on_non_overriding_member, unused_field
// naushad
import 'dart:io';

import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/constants.dart';
import '../../globalFuctions/globalFunctions.dart';

import '../../globalWidgets/buttonIconWidget.dart';
import '../../globalWidgets/buttonWidget.dart';
import '../../globalWidgets/textformfieldWidget.dart';
import '../../responsive.dart';
import 'package:intl/intl.dart';

import '../EmergencyContact/EmergencyContacts.dart';
import 'components/referalCardView.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  var selectedGender;
  @override
  var gender1;
  List<String> gender = ['male'.tr, 'female'.tr, 'others'.tr];
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _referralCodecontroller = TextEditingController();
  final TextEditingController _emailaddressController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  final _formKey = new GlobalKey<FormState>();
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  var dob;
  var yearDiff;
  var _selectedDate;
  var formattedTemporaryDate;
  dateFormate(now) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    return formatted;
  }

  bool isChecked = false;
  DateTime selectedDate = DateTime.now();
  DateTime initialDate = DateTime.now();
  bool isdropdownOpwn = false;

  bool isSelected = false;
  bool isDateSelected = false;
  bool istextSelected = false;
  void _selectDate() async {
    DateTime? picked = DateTime.now();
    FocusScope.of(context).requestFocus(new FocusNode());
    picked = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: tappbarclr,
              onPrimary: tWhite,
              onSurface: tSecondaryColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: tSecondaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      DateTime currentDate = DateTime.now();
      DateTime minimumDate = currentDate.subtract(Duration(days: 15 * 365));

      if (picked.isBefore(minimumDate)) {
        setState(() {
          _dateOfBirthController.text =
              DateFormat('yyyy-MM-dd').format(picked!);
          _selectedDate = picked;
        });
      } else {
        // Selected date does not meet the minimum age requirement
        Twl.createAlert(
            context, 'error'.tr, 'you_must_be_at_least_15_years_old'.tr);
      }
    }
  }

  String? validateDateOfBirth(String? value) {
    if (value == null || value.isEmpty) {
      return 'enter_your_dob'.tr;
    }
    // Add additional validation logic if needed
    return null;
  }
  // var gender;
  // var entityValue = 'Gender';
  // List _entityList = [
  //   'Male',
  //   'Female',
  //   'Others',
  // ];

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Twl.willpopAlert(context);
      },
      child: Scaffold(
        backgroundColor: tWhite,
        appBar: AppBar(
          titleSpacing: 5,
          elevation: 0,
          backgroundColor: tWhite,
          leading: GestureDetector(
            onTap: () {
              Twl.willpopAlert(context);
            },
            child: Padding(
              padding: EdgeInsets.all(isTab(context) ? 10 : 13.0),
              child: BackIconWidget(),
            ),
          ),
          centerTitle: false,
          title: Text(
            'personal_details'.tr,
            // style: TextStyle(
            //     fontSize: isTab(context) ? 12.sp : 20.sp,
            //     color: tBlack,
            //     fontWeight: FontWeight.w600)
            style: GoogleFonts.mulish(
              color: tDarkNavyblue,
              fontWeight: FontWeight.w600,
              fontSize: isTab(context) ? 10.sp : 20.sp,
            ),
          ),
        ),
        body: Column(
          children: [
            // SizedBox(
            //   height:isTab(context)?2.h:1.h,
            // ),
            Expanded(
              child: Form(
                key: _formKey,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 1.6.h,
                            ),
                            Text(
                              'first_name'.tr,
                              style: TextStyle(
                                  color: tDarkOrangeColor,
                                  fontSize: isTab(context) ? 9.sp : 12.sp),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            TextFormFieldWidgets(
                              style: TextStyle(fontWeight: FontWeight.w600),
                              controller: _firstNameController,
                              // textCapitalization: TextCapitalization.words,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'first_name_empty'.tr;
                                } else {
                                  return null;
                                }
                              },
                              keyboardTyp: TextInputType.text,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 13, horizontal: 20),

                              fillcolor: tBackground,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),

                              hinttext: 'enter_first_name'.tr,
                              hintStyl: TextStyle(
                                  color: tGray,
                                  fontSize: isTab(context) ? 10.sp : 13.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text(
                              'last_name'.tr,
                              style: TextStyle(
                                  color: tDarkOrangeColor,
                                  fontSize: isTab(context) ? 9.sp : 12.sp),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            TextFormFieldWidgets(
                              style: TextStyle(fontWeight: FontWeight.w600),
                              controller: _lastnameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'last_name_empty'.tr;
                                } else if (value.length != 1 &&
                                    value.length < 1) {
                                  return 'last_name_min_1_digit'.tr;
                                } else {
                                  return null;
                                }
                              },
                              keyboardTyp: TextInputType.text,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 13, horizontal: 20),
                              fillcolor: tBackground,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              hinttext: 'enter_last_name'.tr,
                              hintStyl: TextStyle(
                                  color: tGray,
                                  fontSize: isTab(context) ? 10.sp : 13.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text(
                              'email'.tr,
                              style: TextStyle(
                                  color: tDarkOrangeColor,
                                  fontSize: isTab(context) ? 9.sp : 12.sp),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            TextFormFieldWidgets(
                              style: TextStyle(fontWeight: FontWeight.w600),
                              controller: _emailaddressController,
                              keyboardTyp: TextInputType.text,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 13, horizontal: 20),
                              fillcolor: tBackground,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              hinttext: 'enter_email'.tr,
                              hintStyl: TextStyle(
                                  color: tGray,
                                  fontSize: isTab(context) ? 10.sp : 13.sp,
                                  fontWeight: FontWeight.w400),
                              // validator: (value) {
                              //   bool emailValid = RegExp(
                              //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              //       .hasMatch(value!);
                              //   if (value.endsWith('@gmail.com') == false &&
                              //       value.endsWith('@yahoo.com') == false &&
                              //       value.endsWith('@hotmail.com') == false &&
                              //       value.endsWith('@techweblabs.com') ==
                              //           false &&
                              //       value.endsWith('@outlook.com') == false) {
                              //     return 'Enter your email address';
                              //   } else if (emailValid == false) {
                              //     return 'Invalid Email';
                              //   }
                              //   return null;
                              // },
                              validator: (value) {
                                if (value.isEmpty ||
                                    !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(value)) {
                                  return 'enter_correct_email'.tr;
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text(
                              'dob'.tr,
                              style: TextStyle(
                                  color: tDarkOrangeColor,
                                  fontSize: isTab(context) ? 9.sp : 12.sp),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Container(
                              child: TextFormField(
                                controller: _dateOfBirthController,
                                validator: validateDateOfBirth,
                                onTap: _selectDate,
                                readOnly: true,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      fontSize: isTab(context) ? 10.sp : 12.sp,
                                      color: _selectedDate == null
                                          ? tGray
                                          : tDarkNavyblue,
                                      fontWeight: _selectedDate == null
                                          ? FontWeight.w500
                                          : FontWeight.w600),
                                  hintText: _dateOfBirthController.text != null
                                      ? _dateOfBirthController.text
                                      : 'dob'.tr,
                                  errorText: _dateOfBirthController.text.isEmpty
                                      ? validateDateOfBirth(
                                          _dateOfBirthController.text)
                                      : null,
                                  // color: isDateSelected ? tBlack : tGray,

                                  fillColor: tBackground,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 18),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: tBackground, width: 1),
                                      borderRadius: BorderRadius.circular(12)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: tBackground, width: 1),
                                      borderRadius: BorderRadius.circular(12)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: tBackground, width: 1),
                                      borderRadius: BorderRadius.circular(12)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: tBackground, width: 1),
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text(
                              'gender'.tr,
                              style: TextStyle(
                                  color: tDarkOrangeColor,
                                  fontSize: isTab(context) ? 11.sp : 12.sp),
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Container(
                              height: 10.h,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedGender = index;
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 12),
                                          height: 7.h,
                                          width: 28.w,
                                          decoration: BoxDecoration(
                                            color: selectedGender == index
                                                ? tPrimaryColor
                                                : tBackground,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            border: Border.all(
                                              color: selectedGender == index
                                                  ? tPrimaryColor
                                                  : tBackground,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              gender[index],
                                              style: TextStyle(
                                                color: selectedGender == index
                                                    ? tWhite
                                                    : tGray,
                                                fontSize: isTab(context)
                                                    ? 9.sp
                                                    : 12.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: isTab(context) ? 50.w : 50.w,
                height: isTab(context) ? 6.h : 7.h,
                child: ButtonWidget(
                  borderSide: BorderSide(
                    color: tPrimaryColor,
                  ),
                  color: tPrimaryColor,
                  borderRadius: 15.0,
                  child: Text(
                    'next'.tr,
                    style: TextStyle(
                        letterSpacing: 1,
                        color: tWhite,
                        fontWeight: FontWeight.w700,
                        fontSize: isTab(context) ? 10.sp : 16.sp),
                  ),
                  onTap: (startLoading, stopLoading, btnState) async {
                    startLoading();
                    if (_formKey.currentState!.validate()) {
                      startLoading();
                      if (_dateOfBirthController.text != null) {
                        if (selectedGender != null) {
                          Map<String, String> param = {
                            "first_name": _firstNameController.text,
                            "last_name": _lastnameController.text,
                            "email": _emailaddressController.text,
                            "date_of_birth": _dateOfBirthController.text,
                            "gender": selectedGender == 0
                                ? 'Male'
                                : selectedGender == 1
                                    ? 'Female'
                                    : 'Others',
                          };
                          var res =
                              await UserAPI().personalDetails(context, param);
                          if (res != null && res['status'] == 'OK') {
                            Twl.forceNavigateTo(context, EmergencyContact());
                          } else {
                            stopLoading();
                            Twl.createAlert(
                                context, 'Oops', res['error'].toString());
                          }
                        } else {
                          stopLoading(); // Gender is not selected, display an error message
                          Twl.createAlert(
                              context, 'oops'.tr, 'gender_empty'.tr);
                        }
                      } else {
                        stopLoading();
                        Twl.createAlert(context, 'oops'.tr, 'select_dob'.tr);
                      }
                    } else {
                      stopLoading();
                    }
                  },
                ),
              ),
            ),
            SizedBox(
                height: isTab(context) ? tDefaultPadding : tDefaultPadding / 2),
          ],
        ),
      ),
    );
  }
}

dateFormate(DateTime? date) {}
