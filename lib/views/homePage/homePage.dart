import 'package:base_project_flutter/api_services/servicesApi.dart';
import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';
import 'package:base_project_flutter/providers/notifactionProvider.dart';
import 'package:base_project_flutter/providers/riderProvider.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/taxiservices/searchlocation/searchlocation.dart';

import 'package:base_project_flutter/views/profilePage/components/notifactionPage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';
import 'package:super_banners/super_banners.dart';

import '../../constants/constants.dart';
import '../../globalFuctions/globalFunctions.dart';

import '../RideBooking/selectRideType.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var homeServicesStatus;
  var checkDetails;
  bool isOthersServiceAvailable = true;
  checkLoginApi() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var check =
        await UserAPI().checkApi(sharedPreferences.getString('authCode')!);
    if (check != null && check['status'] == 'OK') {
      if (mounted) {
        setState(() {
          checkDetails = check['detail'];
          print('object');
          print(checkDetails);
        });
      }
    }
  }

  var homeServices;
  var serviceNOK;
  fetchServices() async {
    var res = await ServicesAPI().getServices(context);
    if (res != null && res['status'] == 'OK') {
      if (mounted) {
        setState(() {
          homeServices = res['details'];
          print('qwert$homeServices');
        });
      }
    } else {
      serviceNOK = res['status'];
    }
  }

  var banners;
  fetchBanner() async {
    var res = await UserAPI().getBanners(context);
    if (res != null && res['status'] == 'OK') {
      if (mounted) {
        setState(() {
          banners = res['details'];
          print('qwert$banners');
        });
      }
    } else {
      serviceNOK = res['status'];
    }
  }

  @override
  void initState() {
    fetchBanner();
    checkLoginApi();
    // TODO: implement initState
    super.initState();
    fetchServices();
  }

  @override
  Widget build(BuildContext context) {
    MyNotifactionProvider myNotificationProvider = MyNotifactionProvider();
    final tripOptionsProvider = Provider.of<TripOptionsProvider>(context);
    if (tripOptionsProvider.pickupAddress == null ||
        tripOptionsProvider.pickupAddress.isEmpty) {
      tripOptionsProvider.getCurrentLocation(context);
    }

    final List<String> imageUrls = [
      'assets/icons/driver.png',
      'assets/icons/taxi.png',
      'assets/icons/auto.png',
      'assets/icons/bike.png',
      'assets/icons/travel.png',
      'assets/icons/hotelBooking.png',
      'assets/icons/realEstate.png',
      'assets/icons/jobs.png',
      'assets/icons/loans.png',
      'assets/icons/rent.png',
      'assets/icons/homeServices.png',
      'assets/icons/more.png',

      // Add more image URLs as needed
    ];

    String? addressLine;
    String? formattedAddress;
    return checkDetails == null
        ? SpinKitThreeBounce(
            color: tPrimaryColor,
            size: 20.0,
          )
        : Scaffold(
            backgroundColor: tWhite,
            appBar: isDesktop(context)
                ? null
                : AppBar(
                    backgroundColor: tWhite,
                    elevation: 0,

                    leading: Builder(builder: (BuildContext context) {
                      return Row(
                        children: [
                          SizedBox(width: 3.w),
                          Container(
                            // height: 45.0,
                            // width: 45.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: checkDetails['selfie'] == null
                                ? CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(Images.UNKNOWN_IMAGE),
                                  )
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      checkDetails['selfie'],
                                    ),
                                  ),
                          ),
                        ],
                      );
                    }),

                    centerTitle: true,
                    title: GestureDetector(
                        onTap: () async {
                          // await Twl.navigateTo(context, SelectRidePage());
                        },
                        child: Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'home'.tr,
                                  style: TextStyle(
                                      color: tDarkNavyblue,
                                      fontWeight: FontWeight.w500,
                                      fontSize: isTab(context) ? 10.sp : 11.sp),
                                ),
                                tripOptionsProvider.pickupAddress == null ||
                                        tripOptionsProvider.pickupAddress == ''
                                    ? Container(
                                        child: Text(
                                          'fetching for current location',
                                          style: TextStyle(
                                              overflow: TextOverflow.clip,
                                              color: tlightGray,
                                              fontWeight: FontWeight.w700,
                                              fontSize: isTab(context)
                                                  ? 10.sp
                                                  : 12.sp),
                                          maxLines: 2,
                                        ),
                                      )
                                    //  Container(
                                    //     child: SpinKitThreeBounce(
                                    //       color: tPrimaryColor,
                                    //       size: 20.0,
                                    //     ),
                                    //   )
                                    : Container(
                                        width: 100.w,
                                        child: Text(
                                          tripOptionsProvider.pickupAddress,
                                          style: TextStyle(
                                              overflow: TextOverflow.clip,
                                              color: tlocationClr,
                                              fontWeight: FontWeight.w700,
                                              fontSize: isTab(context)
                                                  ? 10.sp
                                                  : 12.sp),
                                          maxLines: 2,
                                        ),
                                      ),
                              ],
                            ))),
                    //   title: GestureDetector(
                    // // onTap: () async {
                    // //   Twl.navigateTo(context, GoogleMapPage());
                    // // },
                    // child: Container(
                    //     width: MediaQuery.of(context).size.width * 0.50,
                    //     child: formattedAddress == null
                    //         ? Row(
                    //             children: [
                    //               Container(
                    //                 width: 42.w,
                    //                 child: Text(
                    //                   addressLine != null ? addressLine: '',
                    //                   overflow: TextOverflow.ellipsis,
                    //                   maxLines: 2,
                    //                   style: TextStyle(
                    //                     fontSize: isTab(context) ? 8.sp : 10.sp,
                    //                     fontWeight: FontWeight.w500,
                    //                     color: tDarkNavyblue,
                    //                   ),
                    //                 ),
                    //               ),
                    //               // Image.asset(
                    //               //   Images.DownArrowIcon,
                    //               //   width: isTab(context) ? 25 : 20,
                    //               // )
                    //             ],
                    //           )
                    //         : Row(
                    //             children: [
                    //               Container(
                    //                 width: 42.w,
                    //                 child: Text(
                    //                   formattedAddress != null
                    //                       ? formattedAddress: '',
                    //                   overflow: TextOverflow.ellipsis,
                    //                   maxLines: 2,
                    //                   style: TextStyle(
                    //                       fontSize: 10.sp,
                    //                       fontWeight: FontWeight.w500,
                    //                       color: tDarkNavyblue),
                    //                 ),
                    //               ),
                    //               // Image.asset(
                    //               //   Images.DownArrowIcon,
                    //               //   width: 20,
                    //               // )
                    //             ],
                    //
                    //          ))),

                    actions: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () {
                              Twl.forceNavigateTo(context,
                                  Notifactionpage(boolnotificationPage: true));
                            },
                            child:
                                myNotificationProvider.myFavoritesList == null
                                    ? Image.asset(
                                        Images.NOTIFICATION,
                                        scale: 4,
                                      )
                                    : Badge(
                                        isLabelVisible: true,
                                        backgroundColor: tRed,
                                        child: Image.asset(
                                          Images.NOTIFICATION,
                                          scale: 4,
                                        ))),
                      )
                    ],
                  ),
            body: SingleChildScrollView(
              child: banners == null || homeServices == null
                  ? Container(
                      child: Align(
                          alignment: Alignment.center,
                          child: SpinKitThreeBounce(
                            color: tPrimaryColor,
                            size: 20.0,
                          )),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 15),
                        //   child: SearchField(),
                        // ),
                        SizedBox(
                          height: 2.h,
                        ),
                        serviceNOK == 'NOK'
                            ? Container(
                                alignment: Alignment.center,
                                child: Text('No data found'))
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: GridView.builder(
                                  itemCount: homeServices.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount:
                                              isDesktop(context) ? 2 : 3,
                                          crossAxisSpacing: 4.w,
                                          mainAxisSpacing: 2.h,
                                          childAspectRatio: isDesktop(context)
                                              ? 0.2.w
                                              : isTab(context)
                                                  ? 4
                                                  : 0.9),
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var services = homeServices[index];
                                    if (index > 0) {
                                      return buildOthersServiceWidget(services);
                                    } else {
                                      return GestureDetector(
                                        onTap: () async {
                                          navigateBasedOnConstant(
                                              services['type'], context);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(05),
                                              border: Border.all(
                                                color: tPrimaryColor,
                                              )),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Image.network(
                                                  services['image'].toString(),
                                                  width: 40,
                                                  scale:
                                                      isTab(context) ? 2 : 4.5,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  services['title'].toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: isDesktop(context)
                                                        ? 3.sp
                                                        : isTab(context)
                                                            ? 9.sp
                                                            : 10.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: tDarkNavyblue,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                        SizedBox(
                          height: 2.h,
                        ),
                        banners != null
                            ? Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // SizedBox(
                                  //   height: 2.h,
                                  // ),
                                  Container(
                                    // height: MediaQuery.of(context)
                                    //     .size
                                    //     .height, // Adjust the height as needed
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      physics: ScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: banners
                                          .length, // Number of outer items
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var details = banners[index];
                                        return Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Column(
                                            children: [
                                              ListTile(
                                                title: Text(
                                                  details['title'],
                                                  style: TextStyle(
                                                      color: tDarkNavyblue,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: isTab(context)
                                                          ? 10.sp
                                                          : 14.sp),
                                                ),
                                                // Text(
                                                //   details['title'],
                                                // ),
                                              ),
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    5,
                                                child: ListView.builder(
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: banners[index]
                                                          ['banner']
                                                      .length, // Number of inner items
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int secoundIndex) {
                                                    var bannerDetails =
                                                        banners[index]['banner']
                                                            [secoundIndex];

                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        child: Image.network(
                                                            bannerDetails[
                                                                'image'],
                                                            height: 5.h,
                                                            width: 80.w,
                                                            fit: BoxFit.cover),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )

                                  // Column(
                                  //   children: [
                                  //     Container(
                                  //       height: MediaQuery.of(context).size.height ,
                                  //       child: ListView.builder(
                                  //         physics: NeverScrollableScrollPhysics(),
                                  //         itemCount: 10, // Number of outer items
                                  //         itemBuilder: (BuildContext context, int index) {
                                  //           return Column(
                                  //             children: [
                                  //               ListTile(
                                  //                 title: Text(
                                  //                   'Claim_your_Special'.tr,
                                  //                 ),
                                  //               ),
                                  //               Container(
                                  //                 height:
                                  //                     MediaQuery.of(context).size.height / 5,
                                  //                 child: ListView.builder(
                                  //                   scrollDirection: Axis.horizontal,
                                  //                   // shrinkWrap: true,
                                  //                   physics: ScrollPhysics(),
                                  //                   itemCount: 6, // Number of inner items
                                  //                   itemBuilder: (BuildContext context,
                                  //                       int innerIndex) {
                                  //                     return Image.asset(
                                  //                       Images.CARD,
                                  //                       scale: 4,
                                  //                     );
                                  //                   },
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           );
                                  //         },
                                  //       ),

                                  //     ),
                                  //   ],
                                  // )
                                ],
                              )
                            : Container(),
                        // SizedBox(
                        //   height: 2.h,
                        // ),
                        // SpecialCard1(),
                        // SizedBox(
                        //   height: 2.h,
                        // ),
                        // SpecialCard1()
                      ],
                    ),
            ));
  }

  Widget buildOthersServiceWidget(services) {
    return Stack(
      children: [
        Container(
          width: 30.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(05),
              border: Border.all(
                color: tPrimaryColor,
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Image.network(
                  services['image'].toString(),
                  width: 40,
                  scale: isTab(context) ? 2 : 4.5,
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Expanded(
                flex: 1,
                child: Text(
                  services['title'].toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isDesktop(context)
                        ? 3.sp
                        : isTab(context)
                            ? 9.sp
                            : 10.sp,
                    fontWeight: FontWeight.w700,
                    color: tDarkNavyblue,
                  ),
                ),
              ),
            ],
          ),
        ),
        CornerBanner(
          bannerPosition: CornerBannerPosition.topLeft,
          bannerColor: tDarkNavyblue,
          child: Text(
            "Coming soon!",
            style: TextStyle(
                color: tWhite,
                fontWeight: FontWeight.w400,
                fontSize: isTab(context) ? 8.sp : 12.sp),
          ),
        ),
      ],
    );
  }

//

  void navigateBasedOnConstant(
    int constant,
    BuildContext context,
  ) {
    final tripOptionsProvider =
        Provider.of<TripOptionsProvider>(context, listen: false);
    switch (constant) {
      case DRIVER:
        // Navigate to SelectRideType page for driver
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SelectRideType()),
        );
        tripOptionsProvider.setServiceType('DRIVER');
        break;
      case TAXI:
        // Navigate to SearchLocation page for taxi
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchLocation()),
        );
        tripOptionsProvider.setServiceType('TAXI');
        tripOptionsProvider.setServiceVehicleType(2);
        break;
      case AUTO:
        // Navigate to SearchLocation page for auto
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchLocation()),
        );
        tripOptionsProvider.setServiceType('AUTO');
        tripOptionsProvider.setServiceVehicleType(3);
        break;
      case BIKE:
        // Navigate to SearchLocation page for bike
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchLocation()),
        );
        tripOptionsProvider.setServiceType('BIKE');
        tripOptionsProvider.setServiceVehicleType(4);
        break;
      case OTHERS:
        // Show a snackbar for other services
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Exciting new services are on their way!'),
          ),
        );
        tripOptionsProvider.setServiceType('others');
        tripOptionsProvider.setServiceVehicleType(5);
        break;
      default:
        break;
    }
  }
}
