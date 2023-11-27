import 'package:base_project_flutter/constants/constants.dart';

import 'package:base_project_flutter/taxiservices/rideservices/riderServices.dart';
import 'package:base_project_flutter/taxiservices/searchlocation/searchlocation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/riderProvider.dart';
import '../searchingDriver.dart';

class NewRideLayout extends StatefulWidget {
  final Widget child;

  NewRideLayout({required this.child});

  @override
  State<NewRideLayout> createState() => _NewRideLayoutState();
}

class _NewRideLayoutState extends State<NewRideLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  var userId;
  init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userId = sharedPreferences.getString('userId');
    });
  }

  @override
  Widget build(BuildContext context) {
    return userId != null
        ? StreamBuilder<DocumentSnapshot>(
            stream: RideService().rideStream(uid: userId),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.data() != null) {
                print(" I think here we are ");
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                if (data['status'] != FIREBASE_STATUS_COMPLETE_RIDE ||
                    data['status'] != FIREBASE_STATUS_ACCEPTED_BY_SKIPPER ||
                    data['status'] != FIREBASE_STATUS_CANCEL_BY_SKIPPER) {
                  // return Text("drop_address: ${data['drop_address']}");

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    print("Setting Ride data here");
                    Provider.of<TripOptionsProvider>(context, listen: false)
                        .setRideData(data);
                  });
                  return SearchingDriverPage(rideData: data);
                } else {
                  return widget.child;
                  // Container(
                  //   child:Text(data['status'])
                  // );
                }
              } else {
                // return Container(
                //     child:Text('')
                //   );
                return widget.child;
              }
              //return child!;
            },
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
