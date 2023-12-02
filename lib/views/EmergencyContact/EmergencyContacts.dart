import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/views/PersonalDetails/personalDetailsView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sizer/sizer.dart';

import '../../../constants/constants.dart';

import '../../../globalWidgets/button.dart';

import 'package:intl/intl.dart';
import '../../../responsive.dart';
import '../../globalWidgets/TextFieldWidgets.dart';
import '../../globalWidgets/TextFildTital.dart';
import '../../globalWidgets/buttonIconWidget.dart';
import '../PersonalDetails/components/referalCardView.dart';

class EmergencyContact extends StatefulWidget {
  EmergencyContact({
    Key? key,
    this.firstName,
    this.lastName,
    this.Email,
    this.DateOfBirth,
    this.gender,
    this.address,
    this.detailss,
  }) : super(key: key);
  var firstName;
  var lastName;
  var Email;
  final DateOfBirth;
  var gender;
  var address;
  var detailss;

  @override
  State<EmergencyContact> createState() => _EmergencyContactState();
}

class _EmergencyContactState extends State<EmergencyContact> {
  @override
  void initState() {
    fectData();
    // TODO: implement initState
    super.initState();
  }

  @override
  var gender1;
  List<String> gender = ['Male', 'Female', 'Others'];
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _firstNameController1 = TextEditingController();
  final TextEditingController _homeAddressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _phoneController1 = TextEditingController();
  final TextEditingController _relationController = TextEditingController();
  final TextEditingController _relationController1 = TextEditingController();
  final TextEditingController _addharController = TextEditingController();
  final TextEditingController _addharController1 = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _dobeController = TextEditingController();

  final TextEditingController _emailaddress = TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  bool isChecked = false;
  DateTime selectedDate = DateTime.now();
  DateTime initialDate = DateTime.now();
  bool isdropdownOpwn = false;
  var dob;
  var yearDiff;
  var _selectedDate;
  var formattedTemporaryDate;
  var firstnum;
  dateFormate(now) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);
    return formatted;
  }

  bool isSelected = false;
  bool isDateSelected = false;
  bool istextSelected = false;
  void _selectDate() async {
    DateTime? date = DateTime.now();
    FocusScope.of(context).requestFocus(new FocusNode());
    date = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDatePickerMode: DatePickerMode.day,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: tPrimaryColor,
              onPrimary: tWhite,
              onSurface: tBlack,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: tBlack,
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
      fieldHintText: 'Month/Date/Year',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
    );
    dob = dateFormate(date)!.toString();
    setState(() {
      _selectedDate = dob;
      print('_selectedDate');
      print(_selectedDate);
    });
  }

  fectData() {
    print(widget.gender);
    setState(() {
      widget.gender == null ? null : gender1 = widget.gender;
      print(gender1);
    });
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return Twl.navigateTo(context, PersonalDetails(details:widget.detailss));
      },
      child: Scaffold(
        backgroundColor: tWhite,
        appBar: AppBar(
          titleSpacing: 5,
          elevation: 0,
          backgroundColor: tWhite,
          leading: GestureDetector(
            onTap: () {
              Twl.navigateTo(context, PersonalDetails(details:widget.detailss));
            },
            child: Padding(
              padding: EdgeInsets.all(isTab(context) ? 10 : 13.0),
              child: BackIconWidget(),
            ),
          ),
          centerTitle: false,
          title: Text(
            'emergency_contacts'.tr,
            // style: TextStyle(
            //     fontSize: isTab(context) ? 12.sp : 20.sp,
            //     color: tBlack,
            //     fontWeight: FontWeight.w600)
            style: GoogleFonts.mulish(
              color: tDarkNavyblue,
              fontWeight: FontWeight.w600,
              fontSize: isTab(context) ? 10.sp : 16.sp,
            ),
          ),
          // actions: [
          //   Padding(
          //     padding: EdgeInsets.only(right: 15),
          //     child: GestureDetector(
          //       onTap: () {
          //         Twl.navigateBack(context);
          //         showModalBottomSheet(
          //           isScrollControlled: true,
          //           // expand: false,
          //           context: context,
          //           backgroundColor: Colors.transparent,
          //           builder: (context) => Padding(
          //               padding: EdgeInsets.symmetric(horizontal: 0),
          //               child: ReferalCardView()),
          //         );
          //       },
          //       child: Row(
          //         children: [
          //           Text(
          //             'skip'.tr,
          //             style: TextStyle(
          //               color: tPrimaryColor,
          //               fontWeight: FontWeight.bold,
          //               fontSize: isTab(context) ? 10.sp : 12.sp,
          //             ),
          //           ),
          //           SizedBox(
          //             width: 1.w,
          //           ),
          //           Icon(
          //             Icons.keyboard_arrow_right,
          //             color: tPrimaryColor,
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
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
                            Text(
                              'person1'.tr,
                              style: GoogleFonts.mulish(
                                  fontWeight: FontWeight.w700,
                                  color: tSecondaryColor,
                                  fontSize: isTab(context) ? 16.sp : 18.sp),
                            ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      hinttext: "E.g : John Doe",
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
                                        firstnum = value;
                                        final RegExp regex = RegExp(r'^[6-9]');
                                        if (value!.isEmpty) {
                                          return 'mobile_number_can\'t_be_empty'
                                              .tr;
                                        } else if (value.length != 10 &&
                                            value.length < 10) {
                                          return 'mobile_number_must_be_10_digits'
                                              .tr;
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              'person2'.tr,
                              style: GoogleFonts.mulish(
                                  fontWeight: FontWeight.w700,
                                  color: tSecondaryColor,
                                  fontSize: isTab(context) ? 16.sp : 18.sp),
                            ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      hinttext: "E.g : John Doe",
                                      controller: _firstNameController1,
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
                                        final RegExp regex = RegExp(r'^[6-9]');
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
                                        } else if (value == firstnum) {
                                          return 'emergency numbers can\'t be same';
                                        }
                                      },
                                      inputFormater: [
                                        LengthLimitingTextInputFormatter(10),
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]')),
                                      ],
                                      keyboardTyp: TextInputType.number,
                                      hinttext: 'Eg : XXXXXXXXX'.tr,
                                      controller: _phoneController1,
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
                                      controller: _relationController1,
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
                                    //   controller: _addharController1,
                                    // ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                  ],
                                )),
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
                  bottonText: 'next'.tr,
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
                      startLoading();
                      print(_firstNameController.text);
                      print(_phoneController.text);
                      print(_relationController.text);
                      print(_addharController.text);

                      Map<String, String> param = {
                        'person_name_one': _firstNameController.text,
                        'person_phone_number_one': _phoneController.text,
                        'person_relationship_one': _relationController.text,
                        'person_name_two': _firstNameController1.text,
                        'person_phone_number_two': _phoneController1.text,
                        'person_relationship_two': _relationController1.text
                      };
                      print(param);
                      var res = await UserAPI().emergenyContact(context, param);
                      if (res != null && res['status'] == 'OK') {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            // expand: false,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => ReferalCardView());
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
        ),
      ),
    );
  }
}