import 'package:cloud_firestore/cloud_firestore.dart';

class Addresses{
  String? label;
  GeoPoint? location;

  String? address;

  Addresses({this.label, this.location, this.address});

  toMap(){
    return {
      "label": label,
      "location": location,

      "address": address,
    };
  }
}