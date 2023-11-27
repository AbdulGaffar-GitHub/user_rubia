import 'dart:async';

import 'package:base_project_flutter/api_services/notificationController.dart';
import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/taxiservices/Ride/completedride/rideCompleted.dart';
import 'package:base_project_flutter/taxiservices/Ride/start_ride.dart';
import 'package:base_project_flutter/taxiservices/searchlocation/components.dart/riderRating.dart';
import 'package:base_project_flutter/views/homePage/components/paymentSelection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../api_services/servicesApi.dart';
import '../constants/constants.dart';
import '../taxiservices/Ride/going_to_pickup.dart';
import '../taxiservices/rideDetails.dart';
import '../taxiservices/searchlocation/RideComponents/driver_searching.dart';

class TripOptionsProvider with ChangeNotifier {
  String serviceType = '';
  int serviceVehicleType = 0;
  int serviceRideFare = 0;
  int vehicalId = 0;
  int rideFare = 0;
  String storedServiceValue = '0';
  int tripType = 1;
  int riderType = 1;
  String pickupLatitude = '';
  String pickupLongitude = '';
  String dropLatitude = '';
  String dropLongitude = '';
  String pickupAddress = '';
  String dropAddress = '';
  String currentLatitude = '';
  String currentLongitude = '';
  String currentAddress = '';
  int carType = 1;
  String carModel = '';
  String pickupDate = '';
  String pickupTime = '';
  int usageHours = 2;
  String couponCode = '';
  String estimateFare = '0.0';
  String paymentMethod = '1';
  String isVehicleDamageProtection = '1';
  bool isLoading = false;
  bool isSaveBooking = false;
  String couponDiscount = '0';
  int couponId = 0;
  int locationType = 1;
  int selectedCityId = 0;
  int pickupCityId = 0;
  int dropCityId = 0;

  int selectedIndex = 0;

  // Estimatevalues
  dynamic baseFare = 0.0;
  dynamic baseHour = 0.0;
  dynamic baseKm = 0.0;
  dynamic extraKmCharge = 0.0;
  dynamic extraMinCharge = 0.0;
  dynamic nightCharge = 0.0;
  dynamic outStationCharge = 0.0;
  dynamic additionalCharges = 0.0;
  dynamic estimatedDistance = 0.0;
  dynamic isNightChargeApplicable = 0.0;
  dynamic gst = 0.0;
  dynamic securedFee = 0.0;
  dynamic platFormCharges = 0.0;

  dynamic finalFare = 0.0;
  List<LatLng> polylineCoordinates = [];
  Set<Marker> markers = {};
  List<dynamic> vehicles = [];
  bool isDataLoaded = false;

  //skipper firebase data
  var skipperData;
  var newRideId;

  void resetValues() {
    print("Resetting values hereee");
    pickupLatitude = '';
    pickupLongitude = '';
    dropLatitude = '';
    dropLongitude = '';
    pickupAddress = '';
    dropAddress = '';
    polylineCoordinates.clear();
    // Add any other values that need to be reset
    // Remove the drop location marker
    markers.removeWhere((marker) => marker.markerId.value == 'drop');
    // Remove the drop location marker

    notifyListeners();
  }

  void resetProviderValues() {
    print("Resetting Provider Values here");
    tripType = 1;
    riderType = 1;
    pickupLatitude = '';
    pickupLongitude = '';
    dropLatitude = '';
    dropLongitude = '';
    pickupAddress = '';
    dropAddress = '';
    carType = 1;
    carModel = '';
    pickupDate = '';
    pickupTime = '';
    usageHours = 2;
    couponCode = '';
    couponId = 0;
    couponDiscount = '0';
    paymentMethod = "1";
    estimateFare = '0.0';
    isVehicleDamageProtection = '1';
    isSaveBooking = false;
    selectedCityId = 0;
    storedServiceValue = '0';
  }

  getCurrentLocation(BuildContext context) async {
    print("Getting current Location");
    LocationPermission permission;
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, handle it accordingly
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        // Handle the case when the user denies the location permission permanently
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      String address = "${placemark.name}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}";
      print("Getting current Location " + address);

      Map<String, String> param = {
        'lat': position.latitude.toString(),
        'lng': position.longitude.toString(),
      };
      var res = await UserAPI().checkBoundary(context, param);
      if (res['status'] == "OK") {
        print('CheckBoundary is hitting here >>>>>>>>');
        setCityId(res['selected_city_id']);
        setPickupLocation(
          position.latitude.toString(),
          position.longitude.toString(),
          address,
        );
      }
    }
  }

  bool isRequiredFieldsValid() {
    if (riderType == RIDER_TYPE_ONEWAY) {
      return pickupAddress != null && dropAddress != null && pickupAddress.isNotEmpty && dropAddress.isNotEmpty;
    } else if (riderType == RIDER_TYPE_ROUNDTRIP) {
      return pickupAddress != null && pickupAddress.isNotEmpty;
    }
    return false; // Handle any other cases as needed
  }

  void setServiceType(String type) {
    print("setServiceType " + type.toString());
    serviceType = type;
    notifyListeners();
  }

  void setServiceVehicleType(int type) {
    print("setServiceVehicleType " + type.toString());
    serviceVehicleType = type;
    notifyListeners();
  }

  void setServiceRideFare(int type) {
    print("setServiceRideFare " + type.toString());
    serviceRideFare = type;
    notifyListeners();
  }

  void setSelectedVehicle(int type) {
    print("setSelectedVehicle " + type.toString());
    selectedIndex = type;
    notifyListeners();
  }

  void setRideFare(int type) {
    print("setRideFare " + type.toString());
    rideFare = type;
    notifyListeners();
  }

  void setVehicleId(int type) {
    print("setVehicleId " + type.toString());
    vehicalId = type;
    notifyListeners();
  }

  void setFinalFare(dynamic type) {
    print("finalFare " + type.toString());
    finalFare = type;
    notifyListeners();
  }

  void setStoreServiceValues(String type) {
    print("storedServiceValue " + type.toString());
    storedServiceValue = type;

    notifyListeners();
  }

  void setLocationType(int type) {
    print("LocationType " + type.toString());
    locationType = type;
    notifyListeners();
  }

  void setCityId(int type) {
    print("City Id " + type.toString());
    selectedCityId = type;
    notifyListeners();
  }

  void setDropCityId(int type) {
    print("setDropCityId Id " + type.toString());
    dropCityId = type;
    notifyListeners();
  }

  void setPickupCityId(int type) {
    print("setPickupCityId Id " + type.toString());
    pickupCityId = type;
    notifyListeners();
  }

  void setSaveBooking(bool type) {
    isSaveBooking = type;
    notifyListeners();
  }

  void setpaymentMethod(String type) {
    paymentMethod = type;

    notifyListeners();
  }

  void setisVehicleDamageProtection(String type) {
    isVehicleDamageProtection = type;

    notifyListeners();
  }

  void setTripType(int type) {
    tripType = type;
    print('TripTYpe: ' + tripType.toString());
    notifyListeners();
  }

  void setRiderType(int type) {
    riderType = type;
    print('riderType : ' + riderType.toString());
    notifyListeners();
  }

  void setPickupLocation(String latitude, String longitude, String address) {
    pickupLatitude = latitude;
    pickupLongitude = longitude;
    pickupAddress = address;
    print('Pickup Address' + pickupAddress);
    notifyListeners();
  }

  void setDropLocation(String latitude, String longitude, String address) {
    print('herreeee');
    dropLatitude = latitude;
    dropLongitude = longitude;
    dropAddress = address;
    notifyListeners();
  }

  void setCarType(int type) {
    carType = type;
    print('carType: ' + carType.toString());
    notifyListeners();
  }

  void setCarModel(String model) {
    carModel = model;
    print('carModel: ' + carModel.toString());
    notifyListeners();
  }

  void setPickupDateTime(String date) {
    pickupDate = date;

    notifyListeners();
  }

  void setPickupTime(String time) {
    pickupTime = time;
    notifyListeners();
  }

  void setUsageHours(int hours) {
    usageHours = hours;
    notifyListeners();
  }

  void setCouponCode(String code) {
    couponCode = code;
    notifyListeners();
  }

  void setCouponDiscount(String amount) {
    couponDiscount = amount;
    notifyListeners();
  }

  void setEstimatePrice(String estimate) {
    estimateFare = estimate;
    notifyListeners();
  }

  void setEstimate(Map<String, dynamic> calculateEstimate) {
    baseFare = calculateEstimate['baseFare'].toString();
    baseHour = calculateEstimate['baseHour'].toString();
    baseKm = calculateEstimate['baseKm'].toString();
    extraKmCharge = calculateEstimate['extraKmCharge'].toString();
    extraMinCharge = calculateEstimate['extraMinCharge'].toString();
    nightCharge = calculateEstimate['nightCharge'].toString();
    outStationCharge = calculateEstimate['outStationCharge'].toString();
    additionalCharges = calculateEstimate['additionalCharges'].toString();
    estimatedDistance = calculateEstimate['estimatedDistance'].toString();
    isNightChargeApplicable = calculateEstimate['isNightChargeApplicable'].toString();
    gst = calculateEstimate['gst'].toString();

    securedFee = calculateEstimate['securedFee'].toString();
    platFormCharges = calculateEstimate['platformCharges'].toString();
    couponDiscount = couponDiscount.toString();

    notifyListeners();
  }

  // double calculateEstimateFinalFare() {
  //   String estimateFare = this.estimateFare.toString();
  //   String couponDiscount = this.couponDiscount.toString();

  //   double parsedEstimateFare = 0.0;
  //   double parsedCouponDiscount = 0.0;
  //   try {
  //     parsedEstimateFare = double.parse(estimateFare);
  //   } catch (e) {
  //     print('Error parsing estimateFare: $e');
  //     // Handle the error here, such as providing a fallback value or showing an error message
  //     // For example:
  //     // parsedEstimateFare = 0.0;
  //   }

  //   if (couponDiscount != null) {
  //     couponDiscount = couponDiscount.trim();
  //     try {
  //       parsedCouponDiscount = double.parse(couponDiscount);
  //     } catch (e) {
  //       if (couponDiscount == '0' || couponDiscount == 'null') {
  //         parsedCouponDiscount = 0.0;
  //         setCouponDiscount(parsedCouponDiscount.toString());
  //       } else {
  //         print('Error parsing couponDiscount: $e');
  //         // Handle the error as needed
  //       }
  //     }
  //   } else {
  //     // Handle the case where couponDiscount is null
  //     // For example:
  //     parsedCouponDiscount = 0.0;
  //   }

  //   final double finalFare = parsedEstimateFare - parsedCouponDiscount;
  //   return finalFare;
  // }

  getEstimate(BuildContext context) async {
    Map<String, String> param = {
      'rider_type': riderType.toString(),
      'trip_type': tripType.toString(),
      'pickup_latitude': pickupLatitude,
      'pickup_longitude': pickupLongitude,
      'car_type': carType.toString(),
      'car_model': carModel.toString(),
      'pickup_date': pickupDate.toString(),
      'pickup_time': pickupTime.toString(),
      'usage_hours': usageHours.toString(),
      'drop_latitude': dropLatitude,
      'drop_longitude': dropLongitude,
      'pickup_address': pickupAddress,
      'drop_address': dropAddress,
      'coupon_code': couponCode,
      'coupon_discount': couponDiscount.toString(),
      'is_vehicle_damage_protection': isVehicleDamageProtection,
      'payment_method': paymentMethod,
      'city_id': selectedCityId.toString()
    };

    // Check if the 'usage_hours' value is not zero
    if (usageHours != 0) {
      isLoading = true;
      // Make the API request with the 'usage_hours' parameter
      var response = await ServicesAPI().getEstimate(context, param, isSaveBooking);
      if (response['status'] == 'OK') {
        print(" i am hereeee");
        isLoading = false;
        print(isLoading);
        // Get the estimate value from the response
        final estimate = response['estimate'];

        // Update the estimate property in the provider
        this.estimateFare = estimate.toString();
        this.couponDiscount = response['coupon_discount'].toString();
        print("Setting coupon Disount here from API");
        print(this.couponDiscount);
        // // Get the calculateEstimate values from the response
        final calculateEstimate = response['calculateEstimate'];
        this.setEstimate(calculateEstimate);

        // // Save the values in the corresponding variables
        // baseChargeDay = calculateEstimate['baseChargeDay'];
        // baseChargeNight = calculateEstimate['baseChargeNight'];
        // extraMinuteCharge = calculateEstimate['extraMinuteCharge'];
        // extraKmCharge = calculateEstimate['extraKmCharge'];
        // extraKmChargeNight = calculateEstimate['extraKmChargeNight'];
        // extraHourCharge = calculateEstimate['extraHourCharge'];
        // outsideCityCharge = calculateEstimate['outsideCityCharge'];
        // outsideCityChargeNight = calculateEstimate['outsideCityChargeNight'];
        isLoading = false;

        if (isSaveBooking == true) {
          resetProviderValues();
        }
        // Notify listeners about the changes
        notifyListeners();

        return response;
      } else {
        isLoading = false;
        notifyListeners();
        // Handle the case when the status is not OK
        // You can show an error message or perform any other required action
      }
    } else {
      isLoading = false;
      // Remove the 'usage_hours' parameter from the map
      param.remove('usage_hours');
      await ServicesAPI().getEstimate(context, param, isSaveBooking);
    }
  }

// Apply coupon
  applyCoupon(BuildContext context, param) async {
    // Call your API or perform the necessary logic to apply the coupon
    // Update the estimatePrice based on the applied coupon
    // Example:
    final response = await ServicesAPI().applyCoupon(context, param);
    if (response['status'] == 'OK') {
      this.couponDiscount = response['details']['coupon_discount'].toString();
      this.couponCode = response['details']['coupon_code'].toString();
      this.couponId = response['details']['coupon_id'];
      print("Setting coupon Disount here from Apply Coupon");
      print(this.couponDiscount);
      getEstimate(context);
      notifyListeners();
      return true;
    } else {
      String errorMessage = response['error'];
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Coupon Application Failed'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      notifyListeners();
      return false;
    }
  }

// Apply coupon
  removeCoupon(BuildContext context) async {
    // Call your API or perform the necessary logic to apply the coupon
    // Update the estimatePrice based on the applied coupon
    // Example:

    this.couponDiscount = '0';
    this.couponCode = '';
    this.couponId = 0;
    getEstimate(context);

    notifyListeners();
    return true;
  }

//   //Get Route
//   Future<void> getRoute() async {
//     if (pickupLatitude.isEmpty ||
//         pickupLongitude.isEmpty ||
//         dropLatitude.isEmpty ||
//         dropLongitude.isEmpty) {
//       return;
//     }

//     double pickupLat = double.tryParse(pickupLatitude) ?? 0.0;
//     double pickupLng = double.tryParse(pickupLongitude) ?? 0.0;
//     double dropLat = double.tryParse(dropLatitude) ?? 0.0;
//     double dropLng = double.tryParse(dropLongitude) ?? 0.0;

//     LatLng pickupLocation = LatLng(pickupLat, pickupLng);
//     LatLng dropLocation = LatLng(dropLat, dropLng);

//     PolylinePoints polylinePoints = PolylinePoints();
//     List<PointLatLng> result = [];

//     PolylineResult polylineResult =
//         await polylinePoints.getRouteBetweenCoordinates(
//       mapKey, // Replace with your actual API key
//       PointLatLng(pickupLocation.latitude, pickupLocation.longitude),
//       PointLatLng(dropLocation.latitude, dropLocation.longitude),
//       travelMode: TravelMode.driving,
//     );

//     if (polylineResult.points.isNotEmpty) {
//       polylineCoordinates.clear();
//       result = polylineResult.points;
//       result.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     }
// // Update pickup and drop markers
//     markers.clear();
//     markers.add(Marker(
//       markerId: MarkerId('pickup'),
//       position: pickupLocation,
//       infoWindow: InfoWindow(title: 'Pickup'),
//     ));
//     markers.add(Marker(
//       markerId: MarkerId('drop'),
//       position: dropLocation,
//       infoWindow: InfoWindow(title: 'Drop'),
//     ));
//     notifyListeners();
//   }

//   CameraPosition getInitialCameraPosition() {
//     if (polylineCoordinates.isEmpty) {
//       // If polylineCoordinates is empty, set a default initial position
//       return CameraPosition(
//         target: LatLng(0, 0),
//         zoom: 12,
//       );
//     } else {
//       // Calculate the center point of the polyline coordinates
//       double sumLat = 0;
//       double sumLng = 0;
//       for (LatLng coordinate in polylineCoordinates) {
//         sumLat += coordinate.latitude;
//         sumLng += coordinate.longitude;
//       }
//       double avgLat = sumLat / polylineCoordinates.length;
//       double avgLng = sumLng / polylineCoordinates.length;

//       // Set the camera position at the center of the route
//       return CameraPosition(
//         target: LatLng(avgLat, avgLng),
//         zoom: 12,
//       );
//     }
//   }

  getVehicles(BuildContext context) async {
    vehicles = [];
    try {
      Map<String, String> params = {
        'pickup_pincode': '500081',
        'drop_pincode': '500081',
        'pickup_latitude': pickupLatitude.toString(),
        'pickup_longitude': pickupLongitude.toString(),
        'drop_latitude': dropLatitude.toString(),
        'drop_longitude': dropLongitude.toString(),
        'coupon_code': couponCode.toString(),
        //have to change switch case
        'vehicle_type': serviceVehicleType.toString()
        // serviceVehicleType == 'BIKE' ? BIKE.toString() : TAXI.toString(),
      };

      var response = await UserAPI().getVechiles(context, params);

      if (response['status'] == 'OK') {
        vehicles = response['details'];

        notifyListeners();
      } else {
        // Handle error case
      }
    } catch (error) {
      // Handle error case
    }
  }

  getRideRequest(BuildContext context) async {
    try {
      Map<String, String> params = {
        'vehical_id': serviceVehicleType.toString(),
        'ride_fare': serviceRideFare.toString(),
        'pickup_address': pickupAddress,
        'pickup_pincode': '500081',
        'pickup_latitude': pickupLatitude,
        'pickup_longitude': pickupLongitude,
        'drop_address': dropAddress,
        'drop_pincode': '500081',
        'drop_latitude': dropLatitude,
        'drop_longitude': dropLongitude,
        'payment_method': paymentMethod,
        'cgst': '0',
        'sgst': '0',
        'coupon_code': couponCode,
      };
      print(params);

      var response = await UserAPI().rideRequest(context, params);

      if (response['status'] == 'OK') {
        // Need to get nearby drivers and store data in firebase user request and skipper request

        notifyListeners();
        return response;
      } else {
        return response;
        // Handle error case
      }
    } catch (error) {
      // Handle error case
    }
  }

// Firebase rides

  // void setRideRequestResponse(
  //     String pickupPincode, String dropPincode, String rideId) {
  //   print('herreeee');
  //   pickupPincode = pickupPincode;
  //   dropPincode = dropPincode;
  //   rideId = rideId;
  //   notifyListeners();
  // }

  final _firestore = FirebaseFirestore.instance;

  newRideProvider(userId, rideDetails) {
    // userId = Check ID
    // ridesDetails = riderRequest Api response details
    //
    var collectionReference = _firestore.collection('newRide').doc(userId);
    var dt = DateTime.now();
    collectionReference.set({
      'ride_id': rideDetails['id'],
      'time': DateTime.now(),
      'pickup_address': pickupAddress,
      'pickup_pincode': rideDetails['pickup_pincode'].toString(),
      'pickup_latitude': pickupLatitude,
      'pickup_longitude': pickupLongitude,
      'drop_address': dropAddress,
      'drop_latitude': dropLatitude,
      'drop_longitude': dropLongitude,
      'drop_pincode': rideDetails['drop_pincode'].toString(),
      'is_ride': false,
      'userId': userId,
      'payment_method': paymentMethod,
      'ride_status': 'newRide',
      'ride_fare': serviceRideFare.toString(),
      'skipperId': rideDetails['driver']['id'],
      'driver': rideDetails['driver'],
      'otp': rideDetails['otp'],
      'vechileType': serviceType.toString(),
      'vehical_id': serviceVehicleType.toString(),
      'status': FIREBASE_STATUS_NEW_REQUEST,
      // 'payment_status': PAYMENT_STATUS_PENDING,
    }, SetOptions(merge: true));

    notifyListeners();
  }

  newSkipperRequestProvider(data, rideDetails) {
    skipperData = data;
    newRideId = rideDetails['user']['id'];
    print('skipperData');
    print(skipperData);
    var collectionReference = _firestore.collection('skipperRequest');
    print(collectionReference.doc(data['userId']));
    var dt = DateTime.now();
    collectionReference.doc(data['userId']).set({
      'ride_id': rideDetails['id'],
      'time': DateTime.now(),
      // 'vehical_id': selectedIndex == 0
      //     ? widget.getVechileDetails[0]['id'].toString()
      //     : selectedVechileId.toString(),
      // 'vechileType': selectedIndex == 0
      //     ? widget.getVechileDetails[0]['title'].toString()
      //     : selectedVechileName,

      'ride_fare': serviceRideFare.toString(),
      'driver_startlat': '',
      'driver_startlong': '',
      'driver_endlat': '',
      'driver_endlong': '',
      'driver_startadress': '',

      'pickup_address': pickupAddress,
      'pickup_pincode': rideDetails['pickup_pincode'].toString(),
      'pickup_latitude': pickupLatitude,
      'pickup_longitude': pickupLongitude,
      'drop_address': dropAddress,
      'drop_latitude': dropLatitude,
      'drop_longitude': dropLongitude,
      'drop_pincode': rideDetails['drop_pincode'].toString(),
      'userId': rideDetails['user'],
      'userIdFeild': rideDetails['user']['id'],
      'status': FIREBASE_STATUS_NEW_REQUEST,
      'ride_status': 'newRide',
      'skipperId': data['userId'],
      'driver': rideDetails['driver'],
      'is_ride': false,
      'otp': rideDetails['otp'],
      'payment_method': rideDetails['payment_method'],
      // 'payment_status': PAYMENT_STATUS_PENDING,
    }, SetOptions(merge: true));
    // Send Notification to Skipper

    NotificationController.sendNotification("Hey, You got a new Ride request", "New ride request", data['deviceToken']);
    notifyListeners();
  }

  Map<String, dynamic>? _rideData;

  Map<String, dynamic>? get rideData => _rideData;

  void setRideData(Map<String, dynamic> data) {
    _rideData = data;
    notifyListeners();
  }

  // Function to return different widgets based on status
  Widget getWidgetForStatus() {
    final int status = _rideData?['status'] as int;
    switch (status) {
      case FIREBASE_STATUS_COMPLETE_RIDE:
        return RideCompletedScreen(
          rideData: _rideData,
        );
      case FIREBASE_STATUS_ACCEPTED_BY_SKIPPER:
        return Riderdetails(rideData: _rideData);
      case FIREBASE_STATUS_CANCEL_BY_SKIPPER:
        return Text('Hi');
      case FIREBASE_STATUS_ON_THE_WAY:
        return Riderdetails(rideData: _rideData);

      case FIREBASE_STATUS_ARRIVED:
        return Riderdetails(rideData: _rideData);

      case FIREBASE_STATUS_START_RIDE:
        return Riderdetails(rideData: _rideData);

      case FIREBASE_STATUS_NEW_REQUEST:
        return DriverSearch(rideData: _rideData);
      case FIREBASE_STATUS_RIDE_BOOKED:
      case FIREBASE_STATUS_CANCEL_BY_USER:
        return Text('Hi');

      case FIREBASE_STATUS_AMOUNT_COLLECTED:
        return AddRating(
          rideData: _rideData,
        );

      case FIREBASE_STATUS_RATING_COMPLETED:

      default:
        return Text('Hi');
    }
  }

  Widget getMapWidgetForStatus() {
    final int status = _rideData?['status'] as int;
    switch (status) {
      case FIREBASE_STATUS_COMPLETE_RIDE:

      case FIREBASE_STATUS_ACCEPTED_BY_SKIPPER:
        return NewPickUpRide(rideData: _rideData);
      case FIREBASE_STATUS_CANCEL_BY_SKIPPER:
        return Text('Hi');
      case FIREBASE_STATUS_ON_THE_WAY:
        return StartRide(
          rideData: _rideData,
        );

      case FIREBASE_STATUS_ARRIVED:
        return NewPickUpRide(rideData: _rideData);

      case FIREBASE_STATUS_START_RIDE:
        return StartRide(
          rideData: _rideData,
        );

      case FIREBASE_STATUS_NEW_REQUEST:
        return NewPickUpRide(rideData: _rideData);
      case FIREBASE_STATUS_RIDE_BOOKED:
        return NewPickUpRide(rideData: _rideData);

      case FIREBASE_STATUS_AMOUNT_COLLECTED:

      default:
        return Text('Hi');
    }
  }

  // final ValueNotifier<LatLng> sourceLatLngNotifier =
  //     ValueNotifier<LatLng>(LatLng(0, 0));
  // final ValueNotifier<LatLng> destinationLatLngNotifier =
  //     ValueNotifier<LatLng>(LatLng(0, 0));

  // LatLng get sourceLatLng => sourceLatLngNotifier.value;
  // LatLng get destinationLatLng => destinationLatLngNotifier.value;

  // StreamSubscription<Map<String, dynamic>>? _driverDataStream;

  // // void dispose() {
  // //   _driverDataStream?.cancel();
  // //   super.dispose();
  // // }

  // Future<void> updateLatLngBasedOnStatus() async {
  //   if (_rideData != null) {
  //     int status = _rideData!['status'];
  //     // Rest of your code

  //     //String status = rideData!['status'].toString();
  //     print('status>>>>>>>>>>>');

  //     if (status == FIREBASE_STATUS_ACCEPTED_BY_SKIPPER) {
  //       print("Here I am ");
  //       // Subscribe to the driver's data stream using the driver's ID
  //       String driverId = _rideData!['driver']['id'].toString();
  //       _driverDataStream = getDriverLatLngStream(driverId)
  //           .listen((Map<String, dynamic> driverSnapshot) {
  //         print(driverSnapshot);
  //         // Callback triggered whenever the driver data changes in Firebase
  //         // Get the driver's latitude and longitude from the driverSnapshot
  //         double driverLatitude = driverSnapshot['lat'] ?? 0.0;
  //         double driverLongitude = driverSnapshot['lng'] ?? 0.0;

  //         // Set the sourceLatLng to the driver's latitude and longitude
  //         sourceLatLngNotifier.value = LatLng(driverLatitude, driverLongitude);

  //         double pickupLatitude = double.parse(_rideData!['pickup_latitude']);
  //         double pickupLongitude = double.parse(_rideData!['pickup_longitude']);
  //         destinationLatLngNotifier.value =
  //             LatLng(pickupLatitude, pickupLongitude);

  //         // Notify the listeners that the sourceLatLng has changed
  //         notifyListeners();
  //       });
  //     } else if (status == FIREBASE_STATUS_START_RIDE) {
  //       print("heree???????");
  //       // Unsubscribe from the previous driver data stream (if any)
  //       //  _driverDataStream?.cancel();
  //       String driverId = _rideData!['driver']['id'].toString();

  //       _driverDataStream = getDriverLatLngStream(driverId)
  //           .listen((Map<String, dynamic> driverSnapshot) {
  //         print(driverSnapshot);
  //         double driverLatitude = driverSnapshot['lat'] ?? 0.0;
  //         double driverLongitude = driverSnapshot['lng'] ?? 0.0;

  //         // Set the sourceLatLng to the driver's latitude and longitude
  //         sourceLatLngNotifier.value = LatLng(driverLatitude, driverLongitude);
  //       });

  //       // Use drop location as destinationLatLng
  //       double dropLatitude = double.parse(_rideData!['drop_latitude']);
  //       double dropLongitude = double.parse(_rideData!['drop_longitude']);
  //       destinationLatLngNotifier.value = LatLng(dropLatitude, dropLongitude);

  //       // Notify the listeners that the destinationLatLng has changed
  //       notifyListeners();
  //     } else {
  //       // For other statuses, use pickup_latitude and pickup_longitude as sourceLatLng
  //       double pickupLatitude = double.parse(_rideData!['pickup_latitude']);
  //       double pickupLongitude = double.parse(_rideData!['pickup_longitude']);
  //       sourceLatLngNotifier.value = LatLng(pickupLatitude, pickupLongitude);

  //       // Use drop_latitude and drop_longitude as destinationLatLng
  //       double dropLatitude = double.parse(_rideData!['drop_latitude']);
  //       double dropLongitude = double.parse(_rideData!['drop_longitude']);
  //       destinationLatLngNotifier.value = LatLng(dropLatitude, dropLongitude);

  //       // Notify the listeners that the sourceLatLng and destinationLatLng have changed
  //       notifyListeners();
  //     }
  //   } else {
  //     print("Else part here");
  //   }
  // }

  LatLng _sourceLatLng = LatLng(42.747932, -71.167889); // Default initial value
  LatLng _destinationLatLng = LatLng(17.5209327, 78.34424159999999); // Default initial value

  LatLng get sourceLatLng => _sourceLatLng;
  LatLng get destinationLatLng => _destinationLatLng;

  // ... Other methods and properties related to your trip options provider

  void updateLatLngBasedOnStatus() {
    // Implement your logic here to update the sourceLatLng and destinationLatLng based on status changes
    // For this example, I'll just update them with custom latitudes and longitudes
    _sourceLatLng = LatLng(42.747932, -71.167889);
    _destinationLatLng = LatLng(37.335685, -122.0605916);

    notifyListeners();
  }

  set sourceLatLng(LatLng newLatLng) {
    _sourceLatLng = newLatLng;
    notifyListeners();
  }

  set destinationLatLng(LatLng newLatLng) {
    _destinationLatLng = newLatLng;
    notifyListeners();
  }

  Stream<Map<String, dynamic>> getDriverLatLngStream(String driverId) {
    print('driverId');
    print(driverId);
    return FirebaseFirestore.instance.collection('skippers').doc(driverId).snapshots().map((snapshot) => snapshot.data() ?? {});
  }
}
