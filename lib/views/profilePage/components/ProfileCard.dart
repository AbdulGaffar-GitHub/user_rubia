import 'dart:io';

import 'package:base_project_flutter/views/profilePage/Components/profilePage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../api_services/userApi.dart';
import '../../../constants/constants.dart';
import '../../../constants/imageConstant.dart';
import '../../../globalFuctions/globalFunctions.dart';
import '../../../responsive.dart';
import '../../bottomNavigation.dart/bottomNavigation.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({Key? key, this.checkDetails}) : super(key: key);
  final checkDetails;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  var checkDetails;
  // checkLoginApi() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   var check =
  //       await UserAPI().checkApi(sharedPreferences.getString('authCode')!);
  //   if (check != null && check['status'] == 'OK') {
  //     setState(() {
  //       checkDetails = check['detail'];
  //       print('object');
  //       print(checkDetails);
  //     });
  //   }
  // }

  bool _isLoading = true;
  bool kycLoading = true;
  bool _profileLoader = true;
  final picker = ImagePicker();
  String profileImage = '';

  Future getProfileImage(String type) async {
    var pickedFile;
    if (type == 'camera') {
      pickedFile = await picker.pickImage(
          source: ImageSource.camera,
          maxHeight: 480,
          maxWidth: 640,
          imageQuality: 50);
    } else if (type == 'gallery') {
      pickedFile = await picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 480,
          maxWidth: 640,
          imageQuality: 50);
    } else {
      pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );
    }
    setState(() => kycLoading = false);
    if (pickedFile != null) {
      _profileLoader = false;
      File _file = File(pickedFile.path);
      print(_file.lengthSync());
      setState(() => kycLoading = false);
      // ignore: non_constant_identifier_names
      String ImageName = pickedFile.path;
      print("13" + ImageName);
      // ignore: unused_local_variable
      String url;
      // Upload file
      setState(() => kycLoading = false);
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref =
          storage.ref().child("$ImageName" + DateTime.now().toString());
      print(ref);
      setState(() => kycLoading = false);
      UploadTask uploadTask = ref.putFile(_file);
      print(uploadTask);

      // setState(() => isLoading = true);
      uploadTask.then((res) async {
        _profileLoader = false;
        url = await res.ref.getDownloadURL();
        setState(() => kycLoading = true);
        print(url);

        setState(() {
          _profileLoader = false;
          profileImage = url;
          _profileLoader = true;
        });
        uploadImage(profileImage);
        return profileImage = url;

        // return getFileName(url);
      });
    }
    // ignore: unused_element
  }

  uploadImage(profileImage) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var check = await UserAPI().updateProfilePic(context, profileImage);
    if (check != null && check['status'] == 'OK') {
      setState(() {
        checkDetails = check['detail'];
        print('object');
        print(checkDetails);
      });
      Twl.forceNavigateTo(
          context,
          BottomNavigation(
            tabIndexId: 2,
          ));
    }
  }

  Future<Null> checkLoginStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var check =
        await UserAPI().checkApi(sharedPreferences.getString("authCode")!);

    print(check);
    if (check != null && check['status'] == 'OK') {
      sharedPreferences.setString('profileImage',
          check['detail']['selfie'] != null ? check['detail']['selfie'] : '');
      if (mounted) {
        setState(() {
          checkDetails = check['detail'];
        });
      }
      // sharedPreferences.setString('emailId', check['detail']['username']);
    }

    // setState(() {
    //   profileImage = (sharedPreferences.getString('selfie')!);
    //   // emailId = sharedPreferences.getString('emailId')!;
    // });
    print('sharedPreferences.getString');
    print(sharedPreferences.getString('selfie'));
  }

  // Future getImage(String type) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var pickedFile;
  //   if (type == 'camera') {
  //     pickedFile = await picker.getImage(
  //         source: ImageSource.camera,
  //         maxHeight: 480,
  //         maxWidth: 640,
  //         imageQuality: 50);
  //   } else if (type == 'gallery') {
  //     pickedFile = await picker.getImage(
  //         source: ImageSource.gallery,
  //         maxHeight: 480,
  //         maxWidth: 640,
  //         imageQuality: 50);
  //   }
  //   setState(() => kycLoading = false);
  //   if (pickedFile != null) {
  //     _profileLoader = false;
  //     print('isLoading start');
  //     File _file = File(pickedFile.path);
  //     print(_file.lengthSync());
  //     setState(() => kycLoading = false);
  //     String imageName = pickedFile.path;
  //     print("imageName" + imageName);
  //     setState(() {
  //       profileImage = imageName;
  //     });
  //     debugPrint(profileImage);
  //     // String url;
  //     setState(() => kycLoading = false);

  //     _isLoading = true;
  //   }
  // }

  @override
  void initState() {
    profileImage = '';
    // checkLoginApi();
    checkLoginStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return checkDetails == null
        ? SpinKitThreeBounce(
            color: tPrimaryColor,
            size: 20.0,
          )
        : GestureDetector(
            child:
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 16),
                //   child:
                Center(
              child: Container(
                // margin: EdgeInsets.only(
                //     left: 10,
                //     right: 10,
                //     top: isTab(context)
                //         ? 8
                //         : isDesktop(context)
                //             ? 15
                //             : isMobile(context)
                //                 ? 10
                //                 : 10),
                child: Card(
                  elevation: 1,
                  // color: tBoxShadow,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: isTab(context) ? 30 : 16),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.17,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 2.w,
                          ),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: tDarkNavyblue, width: 1.5)),
                                child:
                                    // CircleAvatar(
                                    //   child: Image.asset(Images.PROFILE_IMAGE),
                                    //   backgroundImage: AssetImage(
                                    //     Images.PROFILE_IMAGE,
                                    //     // widget.checkDetails['profile_image'].toString()
                                    //   ),
                                    //   radius: isTab(context) ? 80 : 50,
                                    // ),
                                    // checkDetails['profile_image'] == null
                                    //     ? CircleAvatar(
                                    //         backgroundImage: NetworkImage(
                                    //             Images.BOOKINGS),
                                    //         radius: isTab(context) ? 80 : 50,
                                    //       )
                                    //     : CircleAvatar(
                                    //         backgroundImage: NetworkImage(
                                    //             checkDetails[
                                    //                 'profile_image']),
                                    //         radius: isTab(context) ? 80 : 50,
                                    //       )
                                    Container(
                                  height: isTab(context) ? 145 : 95,
                                  width: isTab(context) ? 145 : 95,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: checkDetails['selfie'] != null
                                        ? DecorationImage(
                                            image: NetworkImage(
                                              checkDetails['selfie'],
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                        : profileImage.isNotEmpty
                                            ? DecorationImage(
                                                image:
                                                    NetworkImage(profileImage),
                                                fit: BoxFit.cover,
                                              )
                                            : null, // Remove the decoration image if profileImage is empty
                                    border: Border.all(
                                        color: tDarkNavyblue, width: 1.5),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: InkWell(
                                  onTap: () async {
                                    showBarModalBottomSheet(
                                        expand: false,
                                        context: context,
                                        backgroundColor: tWhite,
                                        builder: (context) => Container(
                                            height:
                                                isMobile(context) ? 150 : 30.w,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 60, top: 30, right: 60),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          getProfileImage(
                                                              'camera');

                                                          // getImage('camera getImage(

                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Column(
                                                          children: [
                                                            Image.asset(
                                                              "assets/images/Camera.png",
                                                              scale:
                                                                  isTab(context)
                                                                      ? 3
                                                                      : 5,
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  tDefaultPadding,
                                                            ),
                                                            Text("camera".tr)
                                                          ],
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          getProfileImage(
                                                              'gallery');

                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Column(
                                                          children: [
                                                            Image.asset(
                                                              "assets/images/imageUpload.png",
                                                              scale:
                                                                  isTab(context)
                                                                      ? 3
                                                                      : 5,
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  tDefaultPadding,
                                                            ),
                                                            Text("Gallery".tr)
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: tPrimaryColor,
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: tWhite,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 58.w,
                                child: Text(
                                  // 'Name',
                                  checkDetails['first_name'].toString() +
                                      ' ' +
                                      checkDetails['last_name'].toString(),

                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.mulish(
                                      color: tSecondaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: isTab(context) ? 12.sp : 14.sp),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                // '9704611443',
                                checkDetails['contact_no'].toString(),
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.mulish(
                                    color: tSecondaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: isTab(context) ? 12.sp : 12.sp),
                              ),
                              SizedBox(height: isTab(context) ? 1 : 1.h),
                              GestureDetector(
                                onTap: () {
                                  Twl.navigateTo(
                                      context,
                                      ProfilePage(
                                          // checkDetails: widget.checkDetails
                                          ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: tPrimaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(
                                        'edit_profile'.tr,
                                        style: GoogleFonts.mulish(
                                            color: tWhite,
                                            fontWeight: FontWeight.w700,
                                            fontSize:
                                                isTab(context) ? 12.sp : 10.sp),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
                // ),
              ),
            ),
          );
  }
}
