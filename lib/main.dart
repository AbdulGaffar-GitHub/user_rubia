// @dart=2.9
import 'dart:math';
import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:base_project_flutter/api_services/notificationController.dart';
import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/providers/earningsProvider.dart';
import 'package:base_project_flutter/providers/riderProvider.dart';
import 'package:base_project_flutter/providers/themeProvider.dart';
import 'package:base_project_flutter/views/EmergencyContact/EmergencyContacts.dart';
import 'package:base_project_flutter/views/PersonalDetails/personalDetailsView.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:base_project_flutter/views/logiPage/loginPage.dart';
import 'package:base_project_flutter/views/onBoardingpage/onBoardingPage.dart';
import 'package:base_project_flutter/views/translation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'constants/imageConstant.dart';
import 'providers/notifactionProvider.dart';

//
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.notification} ');
}

AndroidNotificationChannel channel;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  SharedPreferences pref = await SharedPreferences.getInstance();
  var authCode = sharedPreferences.getString('authCode');
  var checkAuth = '1';
  var checkMail;
  var checkDetails;
  var emergencyContactDetails;
  if (authCode != null) {
    var check = await UserAPI().checkApi(authCode);
    print("authCode>>>>> " + authCode);
    print(check);
    print("CheckAuthcode");
    if (check != null && check['status'] == 'OK') {
      if (check['detail']['email'] != null) {
        checkMail = '2';
        checkAuth = '1';
        checkDetails = check['detail']['personal_details'];
        emergencyContactDetails = check['detail']['user_emergency_contacts'];
        print("CheckMail");
        print(checkMail);
        sharedPreferences.setInt('USER_ID', check['detail']['id']);
      } else {
        checkMail = null;
        print("CheckMail");
        print(checkMail);
      }
    } else {
      checkAuth = '';
    }
  } else {
    checkAuth = '';
  }
  sharedPreferences.remove('service_type');
  pref.remove('serviceType');
  print("checkAuth>>>>> " + checkAuth);
  runApp(MyApp(
    checkAuth: checkAuth,
    checkMail: checkMail,
    checkDetails: checkDetails,
    emergencyContact: emergencyContactDetails,
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
  const MyApp(
      {Key key,
      this.checkAuth,
      this.checkMail,
      this.checkDetails,
      this.emergencyContact})
      : super(key: key);
  final checkAuth;
  final checkMail;
  final checkDetails;
  final emergencyContact;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
}

class _MyAppState extends State<MyApp> {
  // var checkDetails;
  // var resNOK;
  // fetchCheck() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   var authCode = sharedPreferences.getString('authCode');
  //   if (authCode != null) {
  //     var check = await UserAPI().checkApi(authCode);
  //     if (check != null && check['status'] == 'OK') {
  //       setState(() {
  //         checkDetails = check['detail'];
  //         print(checkDetails);
  //       });
  //     } else {
  //       resNOK = check['status'];
  //     }
  //   }
  // }

  @override
  void initState() {
    // NotificationController.startListeningNotificationEvents();
    // TODO: implement initState
    super.initState();
    // fetchCheck();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider<TripOptionsProvider>(
          create: (context) => TripOptionsProvider(),
        ),
        ChangeNotifierProvider<MyNotifactionProvider>(
          create: (context) => MyNotifactionProvider(),
        ),
        ChangeNotifierProvider<EarningsProvider>(
            create: (context) => EarningsProvider()),
      ],
      child: Sizer(builder: (context, orientation, screenType) {
        return GetMaterialApp(
          color: tPrimaryColor,
          defaultTransition: Transition.native,
          translations: LanguageTranslations(),
          locale: const Locale('en', "US"),
          title: 'Rubia User',
          debugShowCheckedModeBanner: false,
          //suseInheritedMediaQuery: true,
          theme: ThemeData(
            textTheme: GoogleFonts.muliTextTheme(
              Theme.of(context).textTheme,
            ),
            primarySwatch: Colors.blue,
          ),
          home: AnimatedSplashScreen(
              duration: 1000,
              splash: Image.asset(
                Images.LOGO,
              ),
              splashIconSize: 400,
              nextScreen: (widget.checkAuth == null || widget.checkAuth == '')
                  ? OnboardingPage()
                  : (widget.checkDetails == false)
                      ? PersonalDetails()
                      : (widget.emergencyContact == false)
                          ? EmergencyContact()
                          : BottomNavigation(
                              tabIndexId: 0,
                            ),
              splashTransition: SplashTransition.scaleTransition,
              backgroundColor: Colors.white),
        );
      }),
    );
  }
}
