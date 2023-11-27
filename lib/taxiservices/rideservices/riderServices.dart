import 'package:base_project_flutter/providers/riderProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RideService {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  // CollectionReference? skipperRequest;

  Stream<DocumentSnapshot> rideStream({String? uid}) {
    CollectionReference skipperRequest =
        FirebaseFirestore.instance.collection('newRide');
    return skipperRequest.doc(uid).snapshots();
  }

  //Update Date
  Future<bool> update({String? uid, String? status}) async {
    try {
      CollectionReference skipperRequest =
          FirebaseFirestore.instance.collection('newRide');
      await skipperRequest.doc(uid).update({'status': status});

      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }
  // //Update payment
  // Future<bool> updatePaymentStatusSkipper({String? uid, String? status}) async {
  //   try {
  //     CollectionReference skipperRequest =
  //         FirebaseFirestore.instance.collection('skipperRequest');
  //     await skipperRequest.doc(uid).update({'payment_status': status});
  //     print(' updated................');
  //     return true;

  //   } on Exception catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }
  //updatePaymentStatusSkipper
  updatePaymentStatusSkipper(
      {String? uid, int? status, var riderDetails}) async {
    print("updating ride collection");
    try {
      CollectionReference skipperRequest =
          FirebaseFirestore.instance.collection('skipperRequest');
      if (riderDetails != null) {
        await skipperRequest.doc(uid).update({
          'payment_status': status,
        });
      } else {
        await skipperRequest.doc(uid).update({
          'payment_status': status,
        });
      }

      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  //Update payment
  Future<bool> updatePaymentStatus({String? uid, int? status}) async {
    try {
      CollectionReference skipperRequest =
          FirebaseFirestore.instance.collection('newRide');
      await skipperRequest.doc(uid).update({'payment_status': status});

      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> removeDocument({String? uid, String? skipperId}) async {
    try {
      CollectionReference skipperRequest =
          FirebaseFirestore.instance.collection('newRide');
      await skipperRequest.doc(uid).delete();
      print("Success!.....");
      // completedSkippers(skipperId, '');
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> removeSkipperRequest(context) async {
    final tripOptionsProvider =
        Provider.of<TripOptionsProvider>(context, listen: false);
    print('tripOptionsProvider.skipperData');
    print(tripOptionsProvider.skipperData);
    // print("userid" + uid.toString());
    try {
      CollectionReference skipperRequest =
          FirebaseFirestore.instance.collection('skipperRequest');
      await skipperRequest
          .where('userIdFeild')
          .where('is_ride', isEqualTo: false)
          .get()
          .then((value) {
        // await skipperRequest.where('userIdFeild', isEqualTo: uid).where('userIdFeild').get().then((value) {
        value.docs.forEach((element) {
          print("element['skipperId']");
          print(element['skipperId']);
          FirebaseFirestore.instance
              .collection("skipperRequest")
              .doc(element['skipperId'])
              .delete()
              .then((value) {
            print("Success!");
            print("Success!");
          });
        });
        print("tripOptionsProvider.newRideId.toString()");
        print(tripOptionsProvider.newRideId.toString());
        RideService().removeDocument(
          uid: tripOptionsProvider.newRideId.toString(),
        );
      });

      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> removeMiddleSkipperRequest(
      {String? uid, String? skipperId}) async {
    // print("userid" + uid.toString());
    try {
      CollectionReference skipperRequest =
          FirebaseFirestore.instance.collection('skipperRequest');
      await skipperRequest
          .where('userIdFeild')
          .where('skipperId', isEqualTo: skipperId)
          .get()
          .then((value) {
        // await skipperRequest.where('userIdFeild', isEqualTo: uid).where('userIdFeild').get().then((value) {
        value.docs.forEach((element) {
          print("element['skipperId']");
          print(element['skipperId']);
          FirebaseFirestore.instance
              .collection("skipperRequest")
              .doc(element['skipperId'])
              .delete()
              .then((value) {
            print("Success!");
            print("Success!");
          });
        });
        RideService().removeDocument(uid: uid, skipperId: skipperId);
      });

      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  //genrate token
  // genrateToken(
  //   BuildContext context,
  //   Map<String, String> param,
  // ) async {
  //   var headers = await ApiHelper().getHeader(context);
  //   var url = GENERATE_TOKEN + headers['auth_code'];
  //   Map<String, String> params = param;
  //   var response = await ApiHelper().getTypePost(context, url, params);
  //   print(response);
  //   return response;
  // }

  //payment status
  // paymentstatus(
  //   BuildContext context,
  //   Map<String, String> param,
  // ) async {
  //   var headers = await ApiHelper().getHeader(context);
  //   var url = PAYMENT_STATUS + headers['auth_code'];
  //   Map<String, String> params = param;
  //   var response = await ApiHelper().getTypePost(context, url, params);
  //   print(response);
  //   return response;
  // }

  completedSkippers(String? uid, String? rideId) async {
    var collection = FirebaseFirestore.instance.collection('skippers');
    collection
        .doc(uid) // <-- Doc ID where data should be updated.
        .update({
          'is_ride': false,
          'rideid': rideId,
        }) // <-- Updated data
        .then((value) => print('Updated Skipper'))
        .catchError((error) => print('Update failed: $error'));
  }
}
