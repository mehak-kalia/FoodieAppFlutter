import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trial/util/constants.dart';

class CartPage extends StatefulWidget {
  String? userId;
  String? dishId;

  CartPage({Key? key,this.userId, this.dishId}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  fetchcartDishes(){
    // Stream is a Collection i.e. a List of QuerySnapshot
    // QuerySnapshot is our Document :)
    Stream<DocumentSnapshot<Map<String, dynamic>>> stream = FirebaseFirestore.instance.collection(Util.USERS_COLLECTION)
        .doc(widget.userId).collection(Util.CART_COLLECTION).doc(widget.dishId).snapshots();
    return stream;
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}