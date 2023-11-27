import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;
import '../../constants/constants.dart';
import '../../responsive.dart';
import '../components/pin_pill_info.dart';

const double CAMERA_ZOOM = 15;
const double CAMERA_TILT = 60;
const double CAMERA_BEARING = 40;

class StartRide extends StatefulWidget {
  StartRide({
    Key? key,
    this.rideData,
  }) : super(key: key);
  final rideData;

  @override
  _StartRideState createState() => _StartRideState();
}

class _StartRideState extends State<StartRide> {
  LatLng SOURCE_LOCATION = LatLng(17.448294, 78.391487);
  LatLng DEST_LOCATION = LatLng(17.451293, 78.396568);
  var sourceLat;
  var sourceLng;
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();
  Set<Marker> _deliveredMarkers = Set<Marker>();
// for my drawn routes on the map
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints? polylinePoints;
  BitmapDescriptor? sourceIcon;
  BitmapDescriptor? destinationIcon;

// wrapper around the location API
  Location? location;
  double pinPillPosition = -100;
  PinInformation currentlySelectedPin = PinInformation(
      pinPath: '',
      avatarPath: '',
      location: LatLng(0, 0),
      locationName: '',
      labelColor: Colors.grey);
  PinInformation? sourcePinInfo;
  PinInformation? destinationPinInfo;

  LocationData? currentLocation;

  LocationData? destinationLocation;

  @override
  void initState() {
    super.initState();
    // setInitialLocation();
    polylinePoints = PolylinePoints();
    fetchStoreDetails();
  }

  bool isLoading = true;
  var orderDetails;
  void fetchStoreDetails() async {
    setState(() {
      SOURCE_LOCATION = LatLng(
          double.parse(widget.rideData['pickup_latitude'].toString()),
          double.parse(widget.rideData['pickup_longitude'].toString()));
      DEST_LOCATION = LatLng(
          double.parse(widget.rideData['drop_latitude'].toString()),
          double.parse(widget.rideData['drop_longitude'].toString()));
      sourceLat =
          double.parse(widget.rideData['pickup_latitude'].toString()); //
      sourceLng =
          double.parse(widget.rideData['pickup_longitude'].toString()); //
      destinationLocation = LocationData.fromMap({
        "latitude": SOURCE_LOCATION.latitude,
        "longitude": SOURCE_LOCATION.longitude
      });
      setSourceAndDestinationIcons();
    });
    print("widget.rideData['driver']['id']");
    print(widget.rideData['driver']['id']);
    if (widget.rideData['driver']['id'] != null) {
      // set the initial location
      setInitialLocation();
    }
  }

  void setSourceAndDestinationIcons() async {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.0),
            'assets/icons/mapBike.png')
        .then((onValue) {
      sourceIcon = onValue;
    });

    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.0),
            'assets/images/dropLocation.png')
        .then((onValue) {
      destinationIcon = onValue;
    });
  }

  void setInitialLocation() async {
    print('i am here');

    FirebaseFirestore.instance
        .collection('skippers')
        .doc(widget.rideData['driver']['id'].toString())
        .snapshots()
        .listen((DocumentSnapshot documentSnapshot) {
      print('<<<<< checking skippers');
      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;
        sourceLat = data?['lat']; //
        sourceLng = data?['lng']; //
        SOURCE_LOCATION = LatLng(sourceLat, sourceLng);
        print(sourceLat);
        print('sourceLng');
        print(sourceLng);
        if (mounted) {
          setState(() {
            sourceLat = data?['lat'];
            sourceLng = data?['lng'];
          });
        }
        updatePinOnMap();
        // setPolylines();
        print('Document data: ${documentSnapshot.data()}');
      } else {
        print('Document does not exist on the database');
      }
    });
    destinationLocation = LocationData.fromMap({
      "latitude": DEST_LOCATION.latitude,
      "longitude": DEST_LOCATION.longitude
    });
    currentLocation =
        LocationData.fromMap({"latitude": sourceLat, "longitude": sourceLng});
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION);
    if (currentLocation != null) {
      initialCameraPosition = CameraPosition(
          target: SOURCE_LOCATION,
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING);
    }
    return Container(
        margin: EdgeInsets.symmetric(horizontal: isDesktop(context) ? 10.w : 0),
        child: Scaffold(
            body: Stack(children: [
          sourceLat != null && sourceLng != null
              ?
              // GoogleMap(
              //     // onMapCreated: _onMapCreated,
              //     myLocationButtonEnabled: true,
              //     mapType: MapType.normal,
              //     myLocationEnabled: true,
              //     initialCameraPosition: const CameraPosition(
              //       target: LatLng(17.448294, 78.391487),
              //       zoom: 17.0,
              //     ),
              //     // markers: Set<Marker>.of(markers.values),
              //   )
              GoogleMap(
                  myLocationEnabled: true,
                  compassEnabled: true,
                  tiltGesturesEnabled: false,
                  markers: _markers,
                  polylines: _polylines,
                  mapType: MapType.normal,
                  initialCameraPosition: initialCameraPosition,
                  onTap: (LatLng loc) {
                    pinPillPosition = -100;
                  },
                  onMapCreated: (GoogleMapController controller) {
                    // controller.setMapStyle(Utils.mapStyles);
                    _controller.complete(controller);
                    // my map has completed being created;
                    // i'm ready to show the pins on the map
                    showPinsOnMap();
                  })
              : Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(color: tPrimaryColor)),
        ])));
  }

  void showPinsOnMap() async {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    final Uint8List destiIcon =
        await getBytesFromAsset('assets/images/dropLocation.png', 150);
    var pinPosition = LatLng(sourceLat, sourceLng);
    // get a LatLng out of the LocationData object
    var destPosition =
        LatLng(destinationLocation!.latitude!, destinationLocation!.longitude!);

    sourcePinInfo = PinInformation(
        locationName: "Start Location",
        location: SOURCE_LOCATION,
        pinPath: "assets/icons/mapBike.png",
        avatarPath: "assets/friend1.jpg",
        labelColor: Colors.blueAccent);

    destinationPinInfo = PinInformation(
        locationName: "End Location",
        location: DEST_LOCATION,
        pinPath: "assets/images/dropLocation.png",
        avatarPath: "assets/friend2.jpg",
        labelColor: Colors.purple);

    // add the initial source location pin
    _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: pinPosition,
        onTap: () {
          setState(() {
            currentlySelectedPin = sourcePinInfo!;
            pinPillPosition = 0;
          });
        },
        icon: sourceIcon!));
    // destination pin
    _markers.add(Marker(
      markerId: MarkerId('destPin'),
      position: destPosition,
      onTap: () {
        setState(() {
          currentlySelectedPin = destinationPinInfo!;
          pinPillPosition = 0;
        });
      },
      icon: BitmapDescriptor.fromBytes(destiIcon),
    )); //change

    _deliveredMarkers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: destPosition,
        onTap: () {
          setState(() {
            currentlySelectedPin = sourcePinInfo!;
            pinPillPosition = 0;
          });
        },
        icon: sourceIcon!));
    // set the route lines on the map from source to destination
    // for more info follow this tutorial
    setPolylines();
  }

  void setPolylines() async {
    print('polylines');
    PolylineResult result = await polylinePoints!.getRouteBetweenCoordinates(
      mapKey,
      PointLatLng(sourceLat, sourceLng),
      PointLatLng(
          destinationLocation!.latitude!, destinationLocation!.longitude!),
      travelMode: TravelMode.walking,
    );
    // print(result.points.toString());
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {
        _polylines.add(Polyline(
            width: 5, // set the width of the polylines
            polylineId: PolylineId("poly"),
            color: tPrimaryColor,
            points: polylineCoordinates));
      });
    }
  }

  void updatePinOnMap() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/icons/mapBike.png', 100);
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(sourceLat, sourceLng),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    if (mounted) {
      setState(() {
        polylineCoordinates.clear();
        setPolylines();
        // setPolylines();
        // updated position
        var pinPosition = LatLng(sourceLat, sourceLng);

        sourcePinInfo!.location = pinPosition;

        // the trick is to remove the marker (by id)
        // and add it again at the updated location
        _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
        _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          onTap: () {
            setState(() {
              currentlySelectedPin = sourcePinInfo!;
              pinPillPosition = 0;
            });
          },
          position: pinPosition, // updated position
          icon: BitmapDescriptor.fromBytes(markerIcon),
        ));
      });
    }
  }
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}
