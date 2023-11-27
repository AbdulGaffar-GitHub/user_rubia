import 'package:base_project_flutter/main.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/taxiservices/rideservices/rideLayout.dart';
import 'package:base_project_flutter/views/homePage/homePage.dart';
import 'package:base_project_flutter/views/profilePage/ProfilePageView.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../../constants/constants.dart';
import '../../constants/imageConstant.dart';
import '../../globalFuctions/globalFunctions.dart';
import '../Bookings/bookingPageView.dart';
import '../WalletPage/Wallet.dart';
import '../Bookings/components/riderDetailsPayment.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({Key? key, this.tabIndexId, this.selectedType})
      : super(key: key);

  final tabIndexId;
  final selectedType;
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  void checkBottomIndex() {
    setState(() {
      tabIndexs = widget.tabIndexId != null ? widget.tabIndexId : 0;
    });
  }

  var tabIndexs = 0;
  void _onItemTapped(int index) {
    setState(() {
      tabIndexs = index;
      print(index);
    });
  }

  @override
  void initState() {
    super.initState();
    checkBottomIndex();

    // getPermission();
    FirebaseMessaging.instance.getInitialMessage();
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        // addNotification(message.notification.title, message.notification.body,
        //     message.notification.android.imageUrl);
        flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                // channel!.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));

        print('Message data:+ ${message.data}' + tabIndexs.toString());
        // if (message.notification != null) {
        //   print(
        //       'Message also contained a notification: ${message.notification}');
        //   print('object');
        //   print(tabIndexs.toString());
        //   print('object');
        //   print('onMessageOpenedApp --2');

        //   // print('widget.tabIndexId');
        //   // print(tabIndexs);
        //   // print('widget.tabIndexId');
        //   tabIndexs == 0 || tabIndexs == ''
        //       ? Twl.forceNavigateTo(context, BottomNavigation())
        //       : '';
        // }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Image home(int index) => tabIndexs == index
        ? Image.asset(
            Images.SELECT_HOME,
            width: isTab(context) ? 40 : 22,
          )
        : Image.asset(
            Images.HOME,
            width: isTab(context) ? 35 : 22,
          );
    Image nearby(int index) => tabIndexs == index
        ? Image.asset(
            Images.SELECT_BOOKINGS,
            width: isTab(context) ? 38 : 25,
          )
        : Image.asset(
            Images.BOOKINGS,
            width: isTab(context) ? 38 : 25,
          );
    Image orders(int index) => tabIndexs == index
        ? Image.asset(
            Images.SELECT_WALLET,
            width: isTab(context) ? 40 : 22,
          )
        : Image.asset(
            Images.WALLETS,
            width: isTab(context) ? 40 : 22,
          );
    Image profile(int index) => tabIndexs == index
        ? Image.asset(
            Images.SELECT_PROFILE,
            width: isTab(context) ? 36 : 18,
          )
        : Image.asset(
            Images.PROFILE,
            width: isTab(context) ? 36 : 18,
          );
    return NewRideLayout(
      child: WillPopScope(
        onWillPop: () => tabIndexs == 0
            ? Twl.willpopAlert(context)
            : tabIndexs == 1
                ? Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 0))
                : tabIndexs == 2
                    ? Twl.forceNavigateTo(
                        context, BottomNavigation(tabIndexId: 0))
                    : tabIndexs == 3
                        ? Twl.forceNavigateTo(
                            context, BottomNavigation(tabIndexId: 0))
                        : null,
        child: Scaffold(
          body: Stack(
            children: [
              // DrawerList(),
              IndexedStack(
                index: tabIndexs,
                children: [
                  HomePage(),
                  BookingPageView(),
                  WalletPage(selectedType: widget.selectedType),
                  ProfilePageView(),
                  // Darwer(),
                ],
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: tDarkNavyblue,
            selectedItemColor: tPrimaryColor,
            onTap: _onItemTapped,
            currentIndex: tabIndexs,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            iconSize: isTab(context) ? 40 : 30,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            items: [
              _bottomNavigationBarItem(
                icon: home(0),
                label: 'home'.tr,
              ),
              _bottomNavigationBarItem(
                icon: nearby(1),
                // icon: Icon(Icons.history_sharp),
                label: 'bookings'.tr,
              ),
              _bottomNavigationBarItem(
                icon: orders(2),
                label: 'wallet'.tr,
              ),
              _bottomNavigationBarItem(
                icon: profile(3),
                label: 'profile'.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _bottomNavigationBarItem({required icon, required String label}) {
    return BottomNavigationBarItem(
      icon: icon,
      label: label,
    );
  }
}
