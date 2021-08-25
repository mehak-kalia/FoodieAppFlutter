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
    Stream<QuerySnapshot<Map<String, dynamic>>> stream = FirebaseFirestore.instance.collection(Util.USERS_COLLECTION)
        .doc(widget.userId).collection(Util.CART_COLLECTION).snapshots();
    return stream;
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: fetchcartDishes(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        if(snapshot.hasError){
          return Center(
            child: Text("SOMETHING WENT WRONG", style: TextStyle(color: Colors.red),),
          );
        }

        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          color: Colors.white70,
          child: ListView(
              padding: EdgeInsets.all(16),

              children: snapshot.data!.docs.map<Widget>((DocumentSnapshot document){
                //document.id -> Restaurant Document ID
                Map<String, dynamic> map = document.data()! as Map<String, dynamic>;

                /*List <dynamic> category = map['category'];
                String categories = "";
                category.forEach((element) {
                  categories += element.toString()+", ";
                });

                categories = categories.substring(0, categories.length-2);*/

                return Card(
                  child: Container(
                    padding: EdgeInsets.all(16.0),

                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(map['name'], style: TextStyle(fontSize: 22),),
                        Row(
                            children:[
                              Text("Price \u20b9"+map['price'].toString(), style: TextStyle(color: Colors.black54, fontSize: 18),),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.all(6.0),
                                child: Text(map['quantity'].toString(), style: TextStyle(color: Colors.white),),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(8.0)
                                ),
                              ),
                            ]
                        ),
                      ],
                    ),
                  ),
                );
              }).toList()
          ),
        );

      },
    );

  }
}