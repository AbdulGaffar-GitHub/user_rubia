import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/globalWidgets/TextFieldWidgets.dart';
import 'package:base_project_flutter/globalWidgets/TextFildTital.dart';
import 'package:base_project_flutter/globalWidgets/button.dart';
import 'package:base_project_flutter/globalWidgets/buttonIconWidget.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:base_project_flutter/views/profilePage/components/AllOptionsComponents/FavoritesLocation.dart';
import 'package:base_project_flutter/views/profilePage/components/emergencyContactPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class EditFavouritesLocation extends StatefulWidget {
  EditFavouritesLocation(
      {Key? key,
      this.editfavoriteData,
      this.editmapdata,
      this.favlat,
      this.favlng,
      this.favpincode})
      : super(key: key);
  final editfavoriteData;
  final editmapdata;
  final favlat;
  final favlng;
  final favpincode;

  @override
  _EditFavouritesLocationState createState() => _EditFavouritesLocationState();
}

class _EditFavouritesLocationState extends State<EditFavouritesLocation> {
  @override
  final TextEditingController _addressTypeController = TextEditingController();
  final TextEditingController _relationController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

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
          title: Text('Edit favorite Location'.tr,
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
                                        text: 'Address Type',
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      TextFieldWidgets(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Address Type Cant Be Empty";
                                          } else {
                                            return null;
                                          }
                                        },
                                        hinttext: "Eg : Avinash naidu",
                                        controller: _addressTypeController
                                          ..text = widget
                                              .editmapdata['address_type'],
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      TextFildTital(
                                        text: 'Address',
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      TextFieldWidgets(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Address  Cant Be Empty";
                                            } else {
                                              return null;
                                            }
                                          },
                                          // inputFormater: [
                                          //   LengthLimitingTextInputFormatter(10),
                                          //   FilteringTextInputFormatter.allow(
                                          //       RegExp('[0-9]')),
                                          // ],
                                          keyboardTyp: TextInputType.text,
                                          hinttext: 'Eg : XXXXXXXXX'.tr,
                                          controller: _addressController
                                            ..text = widget.editfavoriteData),
                                      SizedBox(
                                        height: 2.h,
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
                  bottonText: 'Update',
                  borderSide: BorderSide(
                    color: tPrimaryColor,
                  ),
                  // boxshadow: [tButtonBoxshadow],
                  onTap: (startLoading, stopLoading, btnState) async {
                    startLoading();

                    if (_formKey.currentState!.validate()) {
                      print(_addressTypeController.text);
                      print(_addressController.text);

                      Map<String, String> param = {
                        'latitude': widget.editmapdata['latitude'].toString(),
                        'longitude': widget.editmapdata['logitude'].toString(),
                        'address_type': _addressTypeController.text,
                        'address': _addressController.text,
                        'pincode': widget.editmapdata['pincode'].toString(),
                        'status': '1',
                      };
                      print(param);
                      var res = await UserAPI().editFavLocation(
                          context, param, widget.editmapdata['id'].toString());
                      if (res != null && res['status'] == 'OK') {
                        Twl.navigateTo(context, FavouriteLocation());
                      } else {
                        stopLoading();
                        Twl.createAlert(
                            context, 'Oops', res['error'].toString());
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
