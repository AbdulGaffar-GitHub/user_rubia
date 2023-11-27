// import 'package:base_project_flutter/constants/imageConstant.dart';
// import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
// import 'package:base_project_flutter/responsive.dart';
// import 'package:base_project_flutter/views/logiPage/loginPage.dart';
// import '../../constants/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';

// class OnboardingPage extends StatefulWidget {
//   OnboardingPage({Key? key}) : super(key: key);

//   @override
//   _OnboardingPageState createState() => _OnboardingPageState();
// }

// class _OnboardingPageState extends State<OnboardingPage> {
//   var currentPage = 0;

//   bool get isLastPage => currentPage == splashData.length - 1;

//   var pageControll = PageController();

//   late List<Map<String, String>> splashData = [
//     {
//       'title': 'Select your location',
//       'suntitle': '"Navigate with Ease, Select Your Location, Book Your Ride!"',
//       'image': Images.ONBOARDING1,
//     },
//     {
//       'title': 'Get best Drivers',
//       'suntitle':
//           '"Empowering Journeys with the Elite Get the Best Drivers, Elevate Your Ride!"',
//       'image': Images.ONBOARDING2
//     },
//     {
//       'title': 'Get ready with your car',
//       'suntitle':
//           '""Rev up and Ride, Get Set with Your Car, Let the Journey Begin!""',
//       'image': Images.ONBOARDING3
//     }
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SizedBox(
//           width: double.infinity,
//           child: Stack(
//             children: [
//               PageView.builder(
//                   onPageChanged: (page) {
//                     setState(() {
//                       currentPage = page;
//                     });
//                   },
//                   controller: pageControll,
//                   itemCount: splashData.length,
//                   itemBuilder: (context, index) {
//                     return OnboardingWidget(
//                       title: splashData[index]['title'],
//                       subtitle: splashData[index]['suntitle'],
//                       // image: introController.splashData[index]['image'],
//                       titlecolor: tDarkNavyblue,
//                       subtitlecolor: tDarkOrangeColor,
//                       height: 20.w,
//                     );
//                   }),
//               Column(
//                 children: [
//                   Spacer(),
//                   Container(
//                       alignment: Alignment.center,
//                       color: tWhite,
//                       child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 16),
//                           child: Row(
//                               // mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   alignment: Alignment.centerRight,
//                                   // width: 50.w,
//                                   child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: List.generate(
//                                         splashData.length,
//                                         (index) => Container(
//                                           margin: EdgeInsets.all(5),
//                                           height: 6,
//                                           width: currentPage == index ? 20 : 20,
//                                           decoration: BoxDecoration(
//                                               color: currentPage == index
//                                                   ? tPrimaryColor
//                                                   : Colors.grey,
//                                               borderRadius:
//                                                   BorderRadius.circular(2)),
//                                         ),
//                                       )),
//                                 ),
//                                 Spacer(),
//                                 Container(
//                                   alignment: Alignment.centerRight,
//                                   // width: 30.w,
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       Twl.navigateTo(context, LoginScreen());
//                                     },
//                                     child: Container(
//                                       alignment: Alignment.center,
//                                       width: isTab(context) ? 100 : 60,
//                                       height: isTab(context) ? 40 : 25,
//                                       decoration: BoxDecoration(
//                                           color: tPrimaryColor,
//                                           borderRadius:
//                                               BorderRadius.circular(10)),
//                                       child: Text(
//                                         "skip",
//                                         style: TextStyle(
//                                             color: tWhite, fontSize: 12.sp),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ])))
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// // class OnboardingPage extends StatefulWidget {

// // }

// class OnboardingWidget extends StatelessWidget {
//   const OnboardingWidget(
//       {Key? key,
//       this.title,
//       this.subtitle,
//       this.image,
//       this.title2,
//       this.titlecolor,
//       this.height,
//       this.subtitlecolor})
//       : super(key: key);
//   final String? title;
//   final String? title2;
//   final String? subtitle;
//   final image;
//   final titlecolor;
//   final height;
//   final subtitlecolor;
//   get tprimaryColor => null;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           FlutterLogo(
//             size: 65.h,
//           ),
//           // Image.asset(
//           //   image,
//           //   height: MediaQuery.of(context).size.height * 0.57,
//           //   width: MediaQuery.of(context).size.width,
//           //   fit: BoxFit.fill,
//           // ),
//           SizedBox(
//             height: height,
//           ),
//           Text(
//             title!,
//             style: TextStyle(
//                 color: titlecolor,
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.bold),
//           ),
//           SizedBox(
//             height: height / 3,
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width * 0.8,
//             child: Text(
//               subtitle!,
//               style: TextStyle(
//                   color: subtitlecolor,
//                   height: 1.7,
//                   fontSize: 10.sp,
//                   fontWeight: FontWeight.w600),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:base_project_flutter/views/logiPage/loginPage.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../globalFuctions/globalFunctions.dart';
import '../../responsive.dart';

class OnboardingPage extends StatefulWidget {
  OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  var currentPage = 0;

  bool get isLastPage => currentPage == splashData.length - 1;

  var pageControll = PageController();

  late List<Map<String, String>> splashData = [
    {
      'title': 'Select your location',
      'suntitle': '"Navigate with Ease, Select Your Location, Book Your Ride!"',
      // 'image':Images.OnBoardScreen1,
    },
    {
      'title': 'Get best Drivers',
      'suntitle':
          '"Empowering Journeys with the Elite Get the Best Drivers, Elevate Your Ride!"',
      // 'image':Images.OnBoardScreen2
    },
    {
      'title': 'Get ready with your car',
      'suntitle':
          '"Rev up and Ride, Get Set with Your Car, Let the Journey Begin!"',
      // 'image':
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Container(
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //   fit: BoxFit.cover,
            //   // image: AssetImage('assets/images/OnboardingBg.png'),
            // )),
            child: Stack(
              children: [
                PageView.builder(
                  onPageChanged: (page) {
                    setState(() {
                      currentPage = page;
                    });
                  },
                  controller: pageControll,
                  itemCount: splashData.length,
                  itemBuilder: (context, index) {
                    return OnboardingWidget(
                      title: splashData[index]['title'],
                      subtitle: splashData[index]['suntitle'],
                      // image: introController.splashData[index]['image'],
                      titlecolor: tDarkNavyblue,
                      subtitlecolor: tDarkOrangeColor,
                      height: isTab(context) ? 50.w : 10.w,
                      index: index,
                    );
                  },
                ),
                Column(
                  children: [
                    Spacer(),
                    Container(
                      padding: currentPage == 0
                          ? EdgeInsets.symmetric(horizontal: 20)
                          : EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      // color: tWhite,
                      height: isTab(context) ? 10.h : 10.h,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            currentPage == 0
                                ? GestureDetector(
                                    onTap: () {
                                      Twl.navigateTo(context, LoginScreen());
                                      // determinePosition();
                                    },
                                    child: Text(
                                      'Skip Now',
                                      style: TextStyle(
                                          fontSize:
                                              isTab(context) ? 7.sp : 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: tDarkNavyblue),
                                    ),
                                  )
                                : Container(
                                    width: isTab(context) ? 10.w : 16.5.w,
                                  ),
                            Container(
                              alignment: Alignment.centerRight,
                              // width: 50.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  splashData.length,
                                  (index) => Container(
                                    margin: EdgeInsets.all(2.5),
                                    height: 8,
                                    width: currentPage == index ? 14 : 14,
                                    decoration: BoxDecoration(
                                      color: currentPage == index
                                          ? tDarkNavyblue
                                          : tWhite,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Spacer(),
                            currentPage == 0
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        currentPage = 1;
                                      });
                                      pageControll.nextPage(
                                          duration: Duration(seconds: 1),
                                          curve: Curves.ease);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(
                                          isTab(context) ? 18 : 14),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: tPrimaryColor,
                                          boxShadow: [tBoxShadow]),
                                      child: Icon(
                                        Icons.arrow_forward_rounded,
                                        color: tWhite,
                                        size: isTab(context) ? 45 : 34,
                                      ),
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.centerRight,
                                    // width: 30.w,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (currentPage == 1) {
                                          pageControll.nextPage(
                                              duration: Duration(seconds: 1),
                                              curve: Curves.ease);
                                          setState(() {
                                            currentPage = 2;
                                          });
                                        } else {
                                          Twl.navigateTo(
                                              context, LoginScreen());
                                          // determinePosition();
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(
                                            isTab(context) ? 18 : 14),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: tBlack,
                                            boxShadow: [tBoxShadow]),
                                        child: Icon(
                                          Icons.arrow_forward_rounded,
                                          color: tWhite,
                                          size: isTab(context) ? 45 : 34,
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget(
      {Key? key,
      this.title,
      this.subtitle,
      this.image,
      this.title2,
      this.titlecolor,
      this.height,
      this.index,
      this.subtitlecolor})
      : super(key: key);
  final String? title;
  final String? title2;
  final String? subtitle;
  final image;
  final titlecolor;
  final height;
  final subtitlecolor;
  final index;
  get tprimaryColor => null;

  @override
  Widget build(BuildContext context) {
    print(index);

    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              // CustomPaint(
              //   size: Size(
              //     120.w,
              //     (54.h).toDouble(),
              //   ), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
              //   painter: RPSCustomPainter(),
              // ),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Align(
                  child: Image.asset(
                    index == 0
                        ? 'assets/icons/onboarding1.png'
                        : index == 1
                            ? 'assets/icons/onboarding2.png'
                            : 'assets/icons/onboarding3.png',
                    // height: 28.h,
                    // width: 70.w,
                    scale: isTab(context) ? 2.5 : 3.7,
                  ),
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ],
          ),
          // Image.asset(
          //   image,
          //   height: MediaQuery.of(context).size.height * 0.57,
          //   width: MediaQuery.of(context).size.width,
          //   fit: BoxFit.fill,
          // ),
          //  SizedBox(
          //   height:MediaQuery.of(context).size.height /6,
          // ),
          SizedBox(
            height: isTab(context) ? 20.h : 15.h,
          ),
          Text(
            title!,
            style: GoogleFonts.mulish(
              color: tBlack,
              fontWeight: FontWeight.w800,
              fontSize: isTab(context) ? 15.sp : 19.sp,
            ),
          ),
          SizedBox(
            height: isTab(context) ? height / 20 : height / 3,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              subtitle!,
              style: TextStyle(
                  color: subtitlecolor,
                  height: 1.4,
                  fontSize: isTab(context) ? 9.sp : 14.sp,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
