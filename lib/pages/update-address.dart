import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trial/util/constants.dart';
import 'package:geocode/geocode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class UpdateAddressPage extends StatefulWidget {
  const UpdateAddressPage({Key? key}) : super(key: key);

  @override
  _UpdateAddressPageState createState() => _UpdateAddressPageState();
}

class _UpdateAddressPageState extends State<UpdateAddressPage> {


  GeoCode geoCode = GeoCode();
  Address? address;

  LocationData? _locationData;
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController labelController = TextEditingController();

  CameraPosition initPlace = CameraPosition(
    target: LatLng(30.9024779, 75.8201934),
    zoom: 16,
  );

  fetchGeopoint() async {

  Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection(
        Util.USERS_COLLECTION).doc(Util.appUser!.uid).collection(
        Util.ADDRESS_COLLECTION).snapshots();

    return stream;
  }

  Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection(
      Util.USERS_COLLECTION).doc(Util.appUser!.uid).collection(
      Util.ADDRESS_COLLECTION).snapshots();

  checkPermissionAndFetchLocation() async{


    print("Fetching Location");

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

 /* addToDatabase() async{
    var dataToSave = Addresses(
      label: labelController.text,
      address: address.toString(),
      location: GeoPoint(_locationData!.latitude!, _locationData!.longitude!),
    );

    print('Adding data to database');
    FirebaseFirestore.instance.collection('users').doc(Util.appUser!.uid).collection('addresses').doc().set(await dataToSave.toMap());
    print('Data added to database');
  }*/

  @override
  Widget build(BuildContext context) {
    checkPermissionAndFetchLocation();
    return Scaffold(
      appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, false);
          }),

        title: Text("Add Address"),),
      //body: StreamBuilder(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.mail_outline, color: Colors.white,),
        onPressed: () {
          Navigator.pushNamed(context, "/addaddress");
        },

      ), body: StreamBuilder(
        stream: fetchGeopoint(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("SOMETHING WENT WRONG",
                  style: TextStyle(color: Colors.red)),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
              children: [Column(
                  children: snapshot.data!.docs
                      .map<Widget>((DocumentSnapshot document) {
                    Map<String, dynamic> map = document.data()! as Map<
                        String,
                        dynamic>;
                    map['docId'] = document.id.toString();
                    //Util.total[map["name"]]=map["totalprice"] as int;
                    return Column(
                      children: [
                      ],

                    );
                  }).toList()
              ),
                Divider(),
              ]);
        }),
    );
  }
}

