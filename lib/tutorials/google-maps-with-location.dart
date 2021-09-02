import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as lc;




class GoogleMapsPage extends StatefulWidget {
  const GoogleMapsPage({Key? key}) : super(key: key);

  @override
  _GoogleMapsPageState createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {

  lc.Location location = new lc.Location();
  bool? _serviceEnabled;
  lc.PermissionStatus? _permissionGranted;
  lc.LocationData? _locationData;


  //Address? firstAddress;

  CameraPosition auribises = CameraPosition(
    target: LatLng(30.9024779,75.8201934),
    zoom: 14.0,
  );

  checkPermissionsAndFetchLocation() async{

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == lc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != lc.PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();


   // final coordinates = new Coordinates(1.10, 45.50);
   // var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);


    setState(() {


      auribises = CameraPosition(
        target: LatLng(_locationData!.latitude!, _locationData!.longitude!),
        zoom: 20.0,


      );


    });

  }


  Completer<GoogleMapController> _controller = Completer();



  @override
  Widget build(BuildContext context) {

    checkPermissionsAndFetchLocation();

    Marker marker = Marker(
        markerId: MarkerId("atpl"),
        position: LatLng(30.9024779,75.8201934),
        onTap: (){


        },
        infoWindow: InfoWindow(

            snippet: "",
            onTap: (){

            }
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange)
    );

    var markers = Set<Marker>();
    markers.add(marker);

    return Scaffold(
      appBar: AppBar(
        title: Text("Google Maps Page"),
      ),
      body: GoogleMap(
        initialCameraPosition: auribises,
        mapType: MapType.normal,
        trafficEnabled: true,
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}