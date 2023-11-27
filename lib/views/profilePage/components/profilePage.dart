import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/globalWidgets/button.dart';
import 'package:base_project_flutter/globalWidgets/customTextFiled.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../api_services/userApi.dart';
import '../../../constants/constants.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../globalWidgets/buttonIconWidget.dart';
import '../ProfilePageView.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var checkDetails;
  checkLoginApi() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var check =
        await UserAPI().checkApi(sharedPreferences.getString('authCode')!);
    if (check != null && check['status'] == 'OK') {
      setState(() {
        checkDetails = check['detail'];
        print('object');
        print(checkDetails);
      });
    }
  }

  bool _isLoading = true;
  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: [
            new InkWell(
              child: new Text("Continue"),
              onTap: () {
                // Get.to(MainPage());
              },
            ),
          ],
        ),
      );
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();
  var entityValue = 'Select a Gender';
  var dob;
  var yearDiff;
  var _selectedDate;
  var formattedTemporaryDate;
  dateFormate(now) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);
    return formatted;
  }

  List _entityList = [
    'Male',
    'Female',
    'Other',
  ];
  bool isChecked = false;
  DateTime selectedDate = DateTime.now();
  DateTime initialDate = DateTime.now();
  bool isdropdownOpwn = false;

  bool isSelected = false;
  bool isDateSelected = false;
  bool istextSelected = false;
  var gender1;
  List<String> gender = ['male'.tr, 'female'.tr, 'Others'.tr];
  void _selectDate() async {
    DateTime? date = DateTime.now();
    FocusScope.of(context).requestFocus(new FocusNode());
    date = await showDatePicker(
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

  String? email = ' ';
  String? username = '  ';
  String? lastName = '  ';
  String? fullName = '  ';
  String? profileImage = '  ';
  String? firstName = '  ';

  late String authCode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void validateAndSave() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  final TextEditingController _emailIdController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  void dispose() {
    // Clean up the controller when the widget is disposed.

    _emailIdController.dispose();
    _phoneController.dispose();

    _firstNameController.dispose();

    _lastNameController.dispose();

    super.dispose();
  }

  bool kycLoading = true;

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'enter_valid_email'.tr;
    else
      return null;
  }

  @override
  void initState() {
    checkLoginApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tWhite,
      appBar: AppBar(
        backgroundColor: tappbarclr,

        title: Text(
          'edit_profile'.tr,
          style: GoogleFonts.mulish(
              fontSize: isTab(context) ? 10.sp : 17.sp,
              color: tSecondaryColor,
              fontWeight: FontWeight.w700),
        ),
        // leading: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Container(
        //     padding: EdgeInsets.symmetric(
        //         vertical: isTab(context) ? 7 : 0,
        //         horizontal: isTab(context) ? 7 : 0),
        //     decoration: BoxDecoration(
        //         boxShadow: [tBackbtnBoxShadow],
        //         color: tWhite,
        //         borderRadius: BorderRadius.circular(7)),
        //     child: IconButton(
        //         onPressed: () {
        //           Twl.navigateBack(context);
        //         },
        //         icon: Icon(
        //           Icons.arrow_back_ios_rounded,
        //           color: tSecondaryColor,
        //         )),
        //   ),
        // ),
        leading: GestureDetector(
            onTap: () {
              Twl.navigateBack(context);
            },
            child: Padding(
              padding: EdgeInsets.all(isTab(context) ? 10 : 12.0),
              child: BackIconWidget(),
            )),
      ),
      body: checkDetails == null
          ? SpinKitThreeBounce(
              color: tPrimaryColor,
              size: 20.0,
            )
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: tWhite,
                                    boxShadow: [tBackbtnBoxShadow],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'first_name'.tr,
                                          style: GoogleFonts.mulish(
                                              color: tDarkOrangeColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: isTab(context)
                                                  ? 7.sp
                                                  : 14.sp),
                                        ),
                                        CustomTextFormField(
                                          readOnly: false,
                                          // validators: (value) {
                                          //   if (value!.isEmpty) {
                                          //     return "Firstname can't be empty";
                                          //   } else {
                                          //     return null;
                                          //   }
                                          // },
                                          keyboardTyp: TextInputType.text,
                                          // hinttext: 'First Name',
                                          controllers: _firstNameController
                                            ..text =
                                                checkDetails['first_name'] !=
                                                        null
                                                    ? checkDetails['first_name']
                                                        .toString()
                                                    : ''
                                            ..selection =
                                                TextSelection.fromPosition(
                                                    TextPosition(
                                                        offset:
                                                            _firstNameController
                                                                    .text
                                                                    .length -
                                                                0)),
                                          onChanged: (txt) {
                                            checkDetails['first_name'] = txt;
                                            _firstNameController.value =
                                                TextEditingValue(
                                                    text: txt,
                                                    selection:
                                                        TextSelection.collapsed(
                                                            offset: checkDetails[
                                                                'first_name']));
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: tDefaultPadding,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: tWhite,
                                    boxShadow: [tBackbtnBoxShadow],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'last_name'.tr,
                                          style: GoogleFonts.mulish(
                                              color: tDarkOrangeColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: isTab(context)
                                                  ? 7.sp
                                                  : 14.sp),
                                        ),
                                        CustomTextFormField(
                                          readOnly: false,
                                          // validators: (value) {
                                          //   if (value!.isEmpty) {
                                          //     return "Firstname can't be empty";
                                          //   } else {
                                          //     return null;
                                          //   }
                                          // },
                                          keyboardTyp: TextInputType.text,
                                          // hinttext: 'First Name',
                                          controllers: _lastNameController
                                            ..text =
                                                checkDetails['last_name'] !=
                                                        null
                                                    ? checkDetails['last_name']
                                                        .toString()
                                                    : ''
                                            ..selection =
                                                TextSelection.fromPosition(
                                                    TextPosition(
                                                        offset:
                                                            _lastNameController
                                                                    .text
                                                                    .length -
                                                                0)),
                                          onChanged: (txt) {
                                            checkDetails['last_name'] = txt;
                                            _lastNameController.value =
                                                TextEditingValue(
                                                    text: txt,
                                                    selection:
                                                        TextSelection.collapsed(
                                                            offset: checkDetails[
                                                                'last_name']));
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: tDefaultPadding,
                                ),

                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: tWhite,
                                    boxShadow: [tBackbtnBoxShadow],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'phone_number'.tr,
                                          style: GoogleFonts.mulish(
                                              color: tDarkOrangeColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: isTab(context)
                                                  ? 7.sp
                                                  : 14.sp),
                                        ),
                                        CustomTextFormField(
                                          readOnly: true,
                                          // validators: (value) {
                                          //   final RegExp regex = RegExp(r'^[6-9]');
                                          //   if (value!.isEmpty) {
                                          //     return "Mobile number can't be empty";
                                          //     //
                                          //   } else if (value.length != 10 &&
                                          //       value.length < 10) {
                                          //     return "Mobile number must be 10 digits";
                                          //   } else if (!regex.hasMatch(value)) {
                                          //     return 'Invalid number';
                                          //   }
                                          // },
                                          inputFormater: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(
                                              "[0-9]",
                                            )),
                                            LengthLimitingTextInputFormatter(
                                                10),
                                          ],
                                          keyboardTyp: TextInputType.number,
                                          // hinttext: 'Phone number',

                                          controllers: _phoneController
                                            ..text =
                                                checkDetails['contact_no'] !=
                                                        null
                                                    ? checkDetails['contact_no']
                                                        .toString()
                                                    : ''
                                            ..selection =
                                                TextSelection.fromPosition(
                                                    TextPosition(
                                                        offset: _phoneController
                                                                .text.length -
                                                            0)),
                                          onChanged: (txt) {
                                            checkDetails['contact_no'] = txt;
                                            _lastNameController.value =
                                                TextEditingValue(
                                                    text: txt,
                                                    selection:
                                                        TextSelection.collapsed(
                                                            offset: checkDetails[
                                                                'contact_no']));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: tDefaultPadding,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: tWhite,
                                    boxShadow: [tBackbtnBoxShadow],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'email'.tr,
                                          style: GoogleFonts.mulish(
                                              color: tDarkOrangeColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: isTab(context)
                                                  ? 7.sp
                                                  : 14.sp),
                                        ),
                                        CustomTextFormField(
                                          readOnly: false,
                                          // validators: (value) {
                                          //   String? pattern =
                                          //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                          //   RegExp regex = new RegExp(pattern);
                                          //   if (!(regex.hasMatch(value!)))
                                          //     return "Invalid Email";
                                          // },
                                          // hinttext: 'Enter Your Email ID',
                                          controllers: _emailIdController
                                            ..text =
                                                checkDetails['email'] != null
                                                    ? checkDetails['email']
                                                        .toString()
                                                    : ''
                                            ..selection =
                                                TextSelection.fromPosition(
                                                    TextPosition(
                                                        offset:
                                                            _emailIdController
                                                                    .text
                                                                    .length -
                                                                0)),
                                          onChanged: (txt) {
                                            checkDetails['email'] = txt;
                                            _lastNameController.value =
                                                TextEditingValue(
                                                    text: txt,
                                                    selection:
                                                        TextSelection.collapsed(
                                                            offset:
                                                                checkDetails[
                                                                    'email']));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: tDefaultPadding,
                                ),
                                Container(
                                  // height: 8.h,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      customButton: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          color: tWhite,
                                          boxShadow: [tBackbtnBoxShadow],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'gender'.tr,
                                              style: GoogleFonts.mulish(
                                                  color: tDarkOrangeColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: isTab(context)
                                                      ? 7.sp
                                                      : 14.sp),
                                            ),
                                            SizedBox(
                                              height: 0.9.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0,
                                                      top: 4,
                                                      bottom: 4),
                                                  child: Text(
                                                    // entityValue,
                                                    entityValue ==
                                                            'Select a Gender'
                                                        ? checkDetails['gender']
                                                            .toString()
                                                        : entityValue,
                                                    style: TextStyle(
                                                        fontSize: isTab(context)
                                                            ? 10.sp
                                                            : 12.sp,
                                                        color: tDarkNavyblue),
                                                  ),
                                                ),
                                                Spacer(),
                                                Icon(
                                                  isdropdownOpwn
                                                      ? Icons.keyboard_arrow_up
                                                      : Icons
                                                          .keyboard_arrow_down,
                                                  color: tPrimaryColor,
                                                )
                                              ],
                                            ),
                                            Divider(
                                              thickness: 1,
                                              color: tPrimaryColor,
                                            )
                                          ],
                                        ),
                                      ),
                                      items: [
                                        ...List.generate(_entityList.length,
                                            (index) {
                                          return DropdownMenuItem<String>(
                                            value: _entityList[index],

                                            // enabled: false,
                                            child: Row(
                                              children: [
                                                SizedBox(width: 10),
                                                Text(
                                                  _entityList[index],
                                                  style: TextStyle(
                                                      color: tDarkNavyblue,
                                                      fontSize: isTab(context)
                                                          ? 10.sp
                                                          : 12.sp),
                                                ),
                                              ],
                                            ),
                                          );
                                        })
                                      ],
                                      onMenuStateChange: (value) {
                                        setState(() {
                                          isdropdownOpwn = value;
                                        });
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          entityValue = value!;
                                        });
                                        print(entityValue.toString());
                                      },
                                      underline: Container(
                                        height: 2,
                                        color: Colors.deepPurpleAccent,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: tDefaultPadding,
                                ),
                                // Container(
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(8.0),
                                //     color: tWhite,
                                //     boxShadow: [tBackbtnBoxShadow],
                                //   ),
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(8.0),
                                //     child: Column(
                                //       crossAxisAlignment: CrossAxisAlignment.start,
                                //       children: [
                                //         Text(
                                //           'Gender'.tr,
                                //           style: GoogleFonts.mulish(
                                //               color: tDarkOrangeColor,
                                //               fontWeight: FontWeight.w600,
                                //               fontSize:
                                //                   isTab(context) ? 7.sp : 14.sp),
                                //         ),
                                //         // Container(
                                //         //   decoration: BoxDecoration(
                                //         //     borderRadius: BorderRadius.circular(8.0),
                                //         //     color: tWhite,
                                //         //     boxShadow: [tBackbtnBoxShadow],
                                //         //   ),
                                //         //   child: Center(
                                //         //     child: Text(
                                //         //       gender[index],
                                //         //       style: TextStyle(
                                //         //           color: tDarkNavyblue,
                                //         //           fontSize:
                                //         //               isTab(context) ? 9.sp : 12.sp,
                                //         //           fontWeight: FontWeight.w500),
                                //         //     ),
                                //         //   ),
                                //         // )
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: tDefaultPadding,
                                // ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: tWhite,
                                    boxShadow: [tBackbtnBoxShadow],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'dob'.tr,
                                          style: GoogleFonts.mulish(
                                              color: tDarkOrangeColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: isTab(context)
                                                  ? 7.sp
                                                  : 14.sp),
                                        ),
                                        Container(
                                          child: TextFormField(
                                            onTap: _selectDate,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                  fontSize: isTab(context)
                                                      ? 10.sp
                                                      : 12.sp,
                                                  color: isDateSelected == null
                                                      ? tGray
                                                      : tSecondaryColor,
                                                  fontWeight:
                                                      isDateSelected == null
                                                          ? FontWeight.w500
                                                          : FontWeight.w500),
                                              hintText:
                                                  // !isDateSelected
                                                  //     ? checkDetails[
                                                  //             'date_of_birth']
                                                  //         .toString()
                                                  //     : "${selectedDate.day.toString()}/${selectedDate.month.toString()}/ ${selectedDate.year.toString()}",

                                                  _selectedDate != null
                                                      ? _selectedDate.toString()
                                                      : checkDetails[
                                                              'date_of_birth']
                                                          .toString(),
                                              // color: isDateSelected ? tBlack : tGray,

                                              fillColor: tWhite,
                                              filled: true,
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: tPrimaryColor),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: tPrimaryColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: tDefaultPadding,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: isTab(context) ? 50.w : 60.w,
                  height: isTab(context) ? 6.h : 7.h,
                  child: Button(
                      borderSide: BorderSide(
                        color: tPrimaryColor,
                      ),
                      color: tPrimaryColor,
                      textcolor: tWhite,
                      bottonText: 'update'.tr,
                      onTap: (startLoading, stopLoading, btnState) async {
                        if (_formKey.currentState!.validate()) {
                          print(_firstNameController.text);
                          print(_phoneController.text);
                          print(_emailIdController.text);

                          print(entityValue);
                          print(!isDateSelected);
                          Map<String, String> param = {
                            "first_name": checkDetails['first_name'].toString(),
                            "last_name": checkDetails['last_name'].toString(),
                            "email": checkDetails['email'].toString(),
                            "date_of_birth": _selectedDate != null
                                ? _selectedDate.toString()
                                : checkDetails['date_of_birth'].toString(),
                            "gender": entityValue == 'Select a Gender'
                                ? checkDetails['gender'].toString()
                                : entityValue
                            // gender1.toString()
                          };
                          print(param);

                          // Twl.navigateTo(context, ProfilePageView());
                          var res =
                              await UserAPI().personalDetails(context, param);
                          if (res != null && res['status'] == 'OK') {
                            Twl.navigateTo(context, ProfilePageView());
                          }
                        }
                        stopLoading();
                      }),
                ),
                SizedBox(
                  height: tDefaultPadding,
                ),
              ],
            ),
    );
  }
}
