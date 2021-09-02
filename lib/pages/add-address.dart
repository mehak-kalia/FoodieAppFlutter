import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trial/model/address.dart';
import 'package:flutter_trial/util/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocode/geocode.dart';

/*class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);



  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {


  Location location = new Location();

  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

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
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    setState(() {
      auribises = CameraPosition(
          target: LatLng(_locationData!.latitude!, _locationData!.longitude!),
      zoom: 20.0,);


    }
    );


  }

  Completer<GoogleMapController> _controller = Completer();


  @override
  Widget build(BuildContext context) {
    TextEditingController labelController = new TextEditingController();


    AddAddress(){
      Address address = Address(label: labelController.text,
          latitude: _locationData!.latitude! as GeoPoint,
          longitude: _locationData!.latitude! as GeoPoint,
          );


      // here you need to now add the dish with quantity as 1 in dishes cart
      FirebaseFirestore.instance.collection(Util.USERS_COLLECTION)
          .doc(Util.appUser!.uid)
          .collection(Util.ADDRESS_COLLECTION).doc(address.toString()).set(address.toMap());

    }
    latlong(){
      checkPermissionsAndFetchLocation();
      final double Lat = _locationData!.latitude!;
      final double Long = _locationData!.latitude!;
      return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Latitude: ${Lat}"),
            Text("Longitude: ${Long}"),
          ]
      );
    }



    Marker marker = Marker(
        markerId: MarkerId("atpl"),
        position: _locationData != null? LatLng(_locationData!.latitude!, _locationData!.longitude!) : LatLng(30.9024779,75.8201934),
        onTap: (){


        },
        infoWindow: InfoWindow(

            snippet: "",
            onTap: (){

            }
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
    );

    var markers = Set<Marker>();
    markers.add(marker);


    return Scaffold(
      appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),),
          title: Text("Add Address")),
      body: Center(
       child: Center(child: Column(
        children: [Container(
        height: (MediaQuery.of(context).size.height)/3,
          child: GoogleMap(
            initialCameraPosition: auribises,
            mapType: MapType.normal,
            trafficEnabled: true,
            markers: markers,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),

    ),
          Divider(),
        Expanded(
          child: Container(

       height: 2*(MediaQuery.of(context).size.height)/3,
            child: ListView(
              children: [Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Address",style: TextStyle(fontSize: 20,)),
                  SizedBox(height: 10,),
                  Text("City",style: TextStyle(fontSize: 18, color: Colors.grey), ),
                  SizedBox(height: 10,),
                  Text("State",style: TextStyle(fontSize: 18 , color: Colors.grey),),
                  Divider(color: Colors.green, thickness: 5,),
                  latlong(),
                  Divider(color: Colors.green, thickness: 5,),
                  SizedBox(height: 12),
                  Container(padding: EdgeInsets.all(10),
                    child: TextFormField(textAlign: TextAlign.center,
                      controller: labelController,
                      style: TextStyle(
                          fontSize: 17.0, color: Colors.grey.shade900),
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      autofocus: false,
                      enabled: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Label is required. Please Enter.';
                        } else if (value.trim().length == 0) {
                          return 'Label is required. Please Enter.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(

                        filled: true,
                        alignLabelWithHint: true,

                        labelText: "Address Label",
                        labelStyle: TextStyle(color: Colors.green),
                        fillColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.black)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.red)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.grey)),
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.grey)),
                        contentPadding:
                        new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      ),
                    ),
                  ),
                  Container(padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 10, bottom: 4),
                      child: TextButton(
                        onPressed: () {AddAddress();

                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          elevation: 10,
                        ),
                        child: Text(
                          'Add Address',
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      )),
                ],
              ),
            ])




    ),
        )],


    ))));

  }
}*/

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {

  Location location = new Location();
  GeoCode geoCode = GeoCode();
  Address? address;
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController labelController = TextEditingController();

  CameraPosition initPlace = CameraPosition(
    target: LatLng(30.9024779, 75.8201934),
    zoom: 16,
  );

  checkPermissionAndFetchLocation() async{
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    print("Fetching Location");
    _locationData = await location.getLocation();
    print('Location Fetched');

    print("Fetching Address..");
    var addresses = await geoCode.reverseGeocoding(latitude: _locationData!.latitude as double, longitude: _locationData!.longitude as double);
    print('Address Fetched');
    print("Address: $address");

    setState(() {
      address = addresses;

      initPlace = CameraPosition(
        target: LatLng(_locationData!.latitude!, _locationData!.longitude!),
        zoom: 20,
      );
    });
  }

  addToDatabase() async{
    var dataToSave = Addresses(
      label: labelController.text,
      address: address.toString(),
      location: GeoPoint(_locationData!.latitude!, _locationData!.longitude!),
    );

    print('Adding data to database');
    FirebaseFirestore.instance.collection('users').doc(Util.appUser!.uid).collection('addresses').doc().set(await dataToSave.toMap());
    print('Data added to database');
  }

  var items = ['Home Place', 'Work Place', 'Other'];

  @override
  Widget build(BuildContext context) {
    checkPermissionAndFetchLocation();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Address"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.35,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                initialCameraPosition: initPlace,
                mapType: MapType.normal,
                trafficEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: {
                  Marker(
                    markerId: MarkerId('atpl'),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                    onTap: (){},
                    position: LatLng(_locationData!=null ? _locationData!.latitude as double : 30.9024779, _locationData!=null? _locationData!.longitude as double : 75.8201934),
                    // position: _locationData!=null? LatLng(_locationData!.latitude!, _locationData!.longitude!): LatLng(30.9024779, 75.8201934),
                    infoWindow: InfoWindow(
                      title: address!=null? address!.streetAddress : "",
                      snippet: address!=null? address!.countryName: "",
                      onTap: (){},
                    ),
                  ),
                },
              ),
            ),
            Container(
              // height: MediaQuery.of(context).size.height*0.3,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(

                    child: Column(
                      children: [
                        SizedBox(height: 5),
                        address!=null? Text('${address!.streetAddress}') : Container(),
                        address!=null? Text('${address!.city}'): Container(),
                        address!=null? Text('${address!.region}'): Container(),
                        address!=null? Text('${address!.postal}'): Container(),
                        Divider(color: Colors.green, thickness: 5,),
                        address!=null? Text('Latitude: ${_locationData!.latitude}\n Longitude: ${_locationData!.longitude}'): Container(),
                        Divider(color: Colors.green, thickness: 5,),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // SizedBox(height: 15,),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(textAlign: TextAlign.center,
                      controller: labelController,
                      style: TextStyle(
                          fontSize: 17.0, color: Colors.grey.shade900),
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      autofocus: false,
                      enabled: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Label is required. Please Enter.';
                        } else if (value.trim().length == 0) {
                          return 'Label is required. Please Enter.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(

                        filled: true,
                        alignLabelWithHint: true,

                        labelText: "Address Label",
                        labelStyle: TextStyle(color: Colors.green),
                        fillColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.black)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.red)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.grey)),
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.grey)),
                        contentPadding:
                        new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      ),
                    ),
                  ),

                          ],
                        ),
                        SizedBox(height: 5,),

                        Container(padding: EdgeInsets.all(20),
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(top: 10, bottom: 4),
                            child: TextButton(
                              onPressed: () { addToDatabase();

                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.green,
                                elevation: 10,
                              ),
                              child: Text(
                                'Add Address',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


