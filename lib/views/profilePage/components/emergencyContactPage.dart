// ignore: import_of_legacy_library_into_null_safe
// import 'package:contact_picker/contact_picker.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/views/profilePage/components/addcontact.dart';
import 'package:base_project_flutter/views/profilePage/components/editcontact.dart';
import 'package:flutter/material.dart';

//import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
// import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../constants/constants.dart';
import '../../../../globalFuctions/globalFunctions.dart';
import '../../../constants/imageConstant.dart';
import '../../../globalWidgets/buttonIconWidget.dart';
import '../../../globalWidgets/buttonWidget.dart';
import '../../../responsive.dart';

import 'package:permission_handler/permission_handler.dart';

import '../../bottomNavigation.dart/bottomNavigation.dart';

class EmergencyContact extends StatefulWidget {
  const


  EmergencyContact({Key? key}) : super(key: key);

  @override
  State<EmergencyContact> createState() => _EmergencyContactState();
}

class _EmergencyContactState extends State<EmergencyContact> {
  @override
  void initState() {
    number = "";
    name = "";
    // TODO: implement initState
    super.initState();
    fetchEmergencyContacts();
  }

  String? number, name;

  var contactDetails;
  var resNOK;
  fetchEmergencyContacts() async {
    var response = await UserAPI().emergencyContacts(context);
    if (response != null && response['status'] == 'OK') {
      setState(() {
        contactDetails = response['details'];
        print(contactDetails);
      });
    } else {
      setState(() {
        resNOK = response['status'];
      });
    }
  }

  //Check contacts permission
  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ?? PermissionStatus.denied;
    } else {
      return permission;
    }
  }

//  final FlutterContactPicker _contactPicker = new FlutterContactPicker();
//   late Contact _contact;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Twl.forceNavigateTo(
            context,
            BottomNavigation(
              tabIndexId: 3,
            ));
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 7,
          backgroundColor: tYellow,
          leading: GestureDetector(
              onTap: () {
                Twl.forceNavigateTo(
                    context,
                    BottomNavigation(
                      tabIndexId: 3,
                    ));
              },
              child: Padding(
                padding: EdgeInsets.all(isTab(context) ? 10 : 12.0),
                child: BackIconWidget(),
              )),
          title: Text('emergency_contact'.tr,
              style: GoogleFonts.mulish(
                  color: tDarkNavyblue,
                  fontWeight: FontWeight.w800,
                  fontSize: isTab(context) ? 10.sp : 17.sp)),
        ),
        body:
            // contactDetails == null
            //     ? resNOK == 'NOK'
            //         ? Align(
            //             alignment: Alignment.center, child: Text('No data found'))
            //         : Align(
            //             alignment: Alignment.center,
            //             child: CircularProgressIndicator(
            //               color: tPrimaryColor,
            //             ),
            //           )
            //     :
            SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Text('Your_trusted_contacts'.tr,
                    // contactDetail['contact_name']
                    //     .toString(),
                    style: GoogleFonts.mulish(
                        color: tDarkNavyblue,
                        fontWeight: FontWeight.w700,
                        fontSize: isTab(context) ? 10.sp : 16.sp)),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Text(
                    'Share_your_ride_with_your_trusted_max_5_contacts'.tr,
                    // contactDetail['contact_name']
                    //     .toString(),
                    style: GoogleFonts.mulish(
                        color: tGray,
                        fontWeight: FontWeight.w700,
                        fontSize: isTab(context) ? 8.sp : 10.sp)),
              ),
              SizedBox(
                height: 1.h,
              ),
              contactDetails == null
                  ? resNOK == 'NOK'
                      ? Align(
                          alignment: Alignment.center,
                          child: Text('No data found'))
                      : Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            color: tPrimaryColor,
                          ),
                        )
                  : ListView.builder(
                      itemCount: contactDetails.length,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        var contactDetail = contactDetails[index];

                        return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 0.6.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 1.5.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: tWhite,
                                boxShadow: [tBoxShadow]),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: tBlack, width: 2)),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.asset(
                                            Images.PROFILE_IMAGE,
                                            scale: isTab(context) ? 5 : 7,
                                          )),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            // 'Father',
                                            contactDetail['relationship']
                                                .toString(),
                                            style: GoogleFonts.mulish(
                                                color: tDarkNavyblue,
                                                fontWeight: FontWeight.w700,
                                                fontSize: isTab(context)
                                                    ? 10.sp
                                                    : 14.sp)),
                                        SizedBox(
                                          height: 0.6.h,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: Text(
                                              // '+91 9008007006',
                                              contactDetail['phone_number']
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.mulish(
                                                  color: tDarkOrangeColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: isTab(context)
                                                      ? 8.sp
                                                      : 10.sp)),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    PopupMenuButton<int>(
                                        // onSelected: (value) async {
                                        //   var res = await HomeApi().clearNotifications(context);
                                        //   if (res['status'] != null && res['status'] == 'OK') {
                                        //     Twl.forceNavigateTo(context, Notifactionpage());
                                        //   } else {
                                        //     Twl.createAlert(context, 'Oops', res['error'].toString());
                                        //   }
                                        // },
                                        icon: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.more_vert,
                                              color: tPrimaryColor,
                                              // size: isTab(context) ? 20 : 30,
                                            )
                                            //  Icon(
                                            //            isChargesSelected
                                            //                 ? Icons.keyboard_arrow_down
                                            //                 : Icons.keyboard_arrow_up,
                                            //             size: 35,
                                            //             color: tGreencolor,
                                            //           ),
                                          ],
                                        ),
                                        tooltip: "  ",
                                        // icon: Image.asset(Images.),

                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(4.0),
                                          ),
                                        ),
                                        offset: Offset(
                                          -40,
                                          -0,
                                        ),
                                        color: tWhite,
                                        itemBuilder: (context) => [
                                              PopupMenuItem(
                                                // height: 0.4.h,

                                                padding: EdgeInsets.zero,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    print(contactDetails);
                                                    Twl.forceNavigateTo(
                                                        context,
                                                        EditContact(
                                                            contactListDetais:
                                                                contactDetail,
                                                            allContacts:
                                                                contactDetails));
                                                    // var response=await UserAPI().editEmergencyContacts(context, contactDetail['id'].toString());
                                                    // print('Edittt');
                                                    // print(contactDetail['id']);
                                                    // print('Edittt');
                                                  },
                                                  child: Container(
                                                    height: 5.h,
                                                    color: Colors.transparent,
                                                    width: double.infinity,
                                                    child: Center(
                                                      child: Text('edit'.tr,
                                                          style: GoogleFonts.mulish(
                                                              color:
                                                                  tPrimaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize:
                                                                  isTab(context)
                                                                      ? 9.sp
                                                                      : 12.sp)),
                                                    ),
                                                  ),
                                                ),

                                                value: 1,
                                              ),
                                              PopupMenuDivider(
                                                  // height: 20,
                                                  ),
                                              PopupMenuItem(
                                                // height: 0.4.h,

                                                padding: EdgeInsets.zero,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: (context) {
                                                        return Container(
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Stack(
                                                              clipBehavior:
                                                                  Clip.none,
                                                              children: [
                                                                Container(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            16),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              5.h,
                                                                        ),
                                                                        Center(
                                                                          child:
                                                                              Text(
                                                                            'delete_contact'.tr,
                                                                            style: TextStyle(
                                                                                color: tSecondaryColor,
                                                                                fontSize: isTab(context) ? 11.sp : 14.sp,
                                                                                fontWeight: FontWeight.w600),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              3.5.h,
                                                                        ),
                                                                        Center(
                                                                          child:
                                                                              Text(
                                                                            'are_you_sure'.tr,
                                                                            style: TextStyle(
                                                                                color: tDarkOrangeColor,
                                                                                fontSize: isTab(context) ? 9.sp : 12.sp,
                                                                                fontWeight: FontWeight.w600),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              2.5.h,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                // Twl.forceNavigateTo(context, LoginScreen());
                                                                              },
                                                                              child: Container(
                                                                                  width: isTab(context) ? 50.w : 40.w,
                                                                                  height: isTab(context) ? 6.h : 7.h,
                                                                                  // padding: EdgeInsets.symmetric(vertical: isTab(context) ? 12 : 10, horizontal: isTab(context) ? 18.5.w : 16.5.w),
                                                                                  decoration: BoxDecoration(color: tWhite, border: Border.all(color: tCancelRidebtn, width: 2), borderRadius: BorderRadius.circular(12)),
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      'Cancel'.tr,
                                                                                      style: TextStyle(color: tCancelRidebtn, fontSize: isTab(context) ? 10.sp : 13.sp, fontWeight: FontWeight.w700),
                                                                                    ),
                                                                                  )),
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                var res = await UserAPI().deleteEmergencyContacts(context, contactDetail['id'].toString());

                                                                                if (res != null && res['status'] == 'OK') {
                                                                                  setState(() {
                                                                                    fetchEmergencyContacts();
                                                                                  });
                                                                                  Twl.navigateBack(
                                                                                    context,
                                                                                  );
                                                                                } else {
                                                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                    content: Text('failed_to_delete'.tr),
                                                                                  ));

                                                                                  // Twl.createAlert(context, 'Oops', res['error'].toString());
                                                                                }
                                                                              },
                                                                              child: Container(
                                                                                  width: isTab(context) ? 50.w : 40.w,
                                                                                  height: isTab(context) ? 6.h : 7.h,
                                                                                  // padding: EdgeInsets.symmetric(vertical: isTab(context) ? 12.5 : 10, horizontal: isTab(context) ? 18.5.w : 16.5.w),
                                                                                  decoration: BoxDecoration(color: tPrimaryColor, border: Border.all(color: tPrimaryColor, width: 1.5), borderRadius: BorderRadius.circular(12)),
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      'Delete'.tr,
                                                                                      style: TextStyle(color: tWhite, fontSize: isTab(context) ? 10.sp : 13.sp, fontWeight: FontWeight.w600),
                                                                                    ),
                                                                                  )),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              4.h,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  top: -20,
                                                                  left: isTab(
                                                                          context)
                                                                      ? 47.w
                                                                      : 45.w,
                                                                  child:
                                                                      Container(
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
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          6.h,
                                                                      width:
                                                                          6.h,
                                                                      decoration: BoxDecoration(
                                                                          //     color: tPrimaryColor,
                                                                          //     borderRadius:
                                                                          //         BorderRadius.circular(30)
                                                                          ),
                                                                      child: Image
                                                                          .asset(
                                                                        Images
                                                                            .DELETE,
                                                                        scale: isTab(context)
                                                                            ? 2
                                                                            : 3,
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
                                                    color: Colors.transparent,
                                                    height: 5.h,
                                                    width: double.infinity,
                                                    child: Center(
                                                      child: Text('Delete'.tr,
                                                          style: GoogleFonts.mulish(
                                                              color:
                                                                  tPrimaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize:
                                                                  isTab(context)
                                                                      ? 9.sp
                                                                      : 12.sp)),
                                                    ),
                                                  ),
                                                ),

                                                value: 1,
                                              ),
                                            ]),
                                  ],
                                ),
                              ],
                            ));
                      }),
              SizedBox(
                height: 4.h,
              ),
              contactDetails != null
                  ? contactDetails.length < 5
                      ? Center(
                          child: SizedBox(
                            width: isTab(context) ? 30.w : 40.w,
                            height: isTab(context) ? 6.h : 7.h,
                            child: ButtonWidget(
                              borderSide: BorderSide(color: tPrimaryColor),
                              color: tPrimaryColor,
                              borderRadius: isTab(context) ? 40.0 : 30.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: tWhite, width: 2),
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: isTab(context) ? 35 : 23,
                                      color: tWhite,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text('Add_New'.tr,
                                      style: GoogleFonts.mulish(
                                          color: tWhite,
                                          fontWeight: FontWeight.w700,
                                          fontSize:
                                              isTab(context) ? 9.sp : 14.sp)),
                                ],
                              ),
                              onTap:
                                  (startLoading, stopLoading, btnState) async {
                                startLoading();
                                Twl.navigateTo(context,
                                    AddContact(allContacts: contactDetails));
                              },
                            ),
                          ),
                        )
                      : Container()
                  : Center(
                      child: SizedBox(
                        width: isTab(context) ? 30.w : 40.w,
                        height: isTab(context) ? 6.h : 7.h,
                        child: ButtonWidget(
                          borderSide: BorderSide(color: tPrimaryColor),
                          color: tPrimaryColor,
                          borderRadius: isTab(context) ? 40.0 : 30.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: tWhite, width: 2),
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: isTab(context) ? 35 : 23,
                                  color: tWhite,
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text('Add_New'.tr,
                                  style: GoogleFonts.mulish(
                                      color: tWhite,
                                      fontWeight: FontWeight.w700,
                                      fontSize: isTab(context) ? 9.sp : 14.sp)),
                            ],
                          ),
                          onTap: (startLoading, stopLoading, btnState) async {
                            startLoading();
                            Twl.navigateTo(context, AddContact());
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
  // void _showDialog(BuildContext context, favLocationId) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         contentPadding: EdgeInsets.zero,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(15.0),
  //         ),
  //         actions: [
  //           DeleteAddressPopUp(
  //             // favLocationId: favLocationId,
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }
}
