/*import 'package:cloud_firestore/cloud_firestore.dart';
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
    return Scaffold(appBar: AppBar(
        title: Text(Util.APP_NAME),),
      body: StreamBuilder(
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
      ),
    );

  }
}*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trial/custom-widgets/counter.dart';
import 'package:flutter_trial/pages/razorpay-payment-page.dart';
import 'package:flutter_trial/pages/success.dart';
import 'package:flutter_trial/util/constants.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  int total = 0;
  String paymentMethod = "";

  var dishes = [];

  fetchDishesFromCart(){
    // Stream is a Collection i.e. a List of QuerySnapshot
    // QuerySnapshot is our Document :)
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection(Util.USERS_COLLECTION)
        .doc(Util.appUser!.uid).collection(Util.CART_COLLECTION).snapshots();
    return stream;
  }

  placeOrder(){
    Map<String, dynamic> order = Map<String, dynamic>();
    order['dishes'] = dishes;
    order['total'] = total;
    order['restaurantID'] = dishes.first['restaurantID'];
    order['address'] = 'NA';

    // Firebase Insert Operation
    FirebaseFirestore.instance.collection(Util.USERS_COLLECTION)
        .doc(Util.appUser!.uid)
        .collection(Util.ORDER_COLLECTION).doc().set(order);
  }

  clearCart(){
    dishes.forEach((dish) {
      // delete every single dish one by one async :)
      FirebaseFirestore.instance.collection(Util.USERS_COLLECTION).doc(Util.appUser!.uid).collection(Util.CART_COLLECTION).doc(dish['documentID']).delete();
    });
  }

  navigateToSuccess(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
    => SuccessPage(title: "Order Placed", message: "Thank You For Placing the Order \u20b9 ${total}", flag: true),));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }),
        title: Text("CART"),
      ),
      body: StreamBuilder(
        stream: fetchDishesFromCart(),
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

          return ListView(
              padding: EdgeInsets.all(16),
              children: snapshot.data!.docs.map<Widget>((DocumentSnapshot document){
                Map<String, dynamic> map = document.data()! as Map<String, dynamic>;
                map['totalprice'] = (map['price']*map['quantity']) as int;

                total += map['totalprice'] as int;

                return Card(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(map['name'], style: TextStyle(fontSize: 22),),
                        SizedBox(height: 5,),
                        Text("Price \u20b9"+map['price'].toString(), style: TextStyle(color: Colors.black54, fontSize: 18),),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Text(map['totalPrice'].toString(), style: TextStyle(fontSize: 22),),
                            Spacer(),
                            Text("Quantity: ", style: TextStyle(fontSize: 18, color: Colors.grey),),
                            Text(map['quantity'].toString(), style: TextStyle(fontSize: 22),),
                          ],
                        ),

                      ],
                    ),
                  ),
                );
              }).toList()
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        height: 120,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[

              Column(
                children: [
                  Text("Payment Method: ${paymentMethod}"),
                  OutlinedButton(
                      onPressed: () async{
                        paymentMethod = await Navigator.pushNamed(context, "/payment") as String;
                      setState(() {
                        total == 0;
                      });
                      }, child: Text("Select Payment"))
                ],
              ),
              Spacer(),

              Column(
                children: [
                  Text("Total \u20b9${total}"),
                  OutlinedButton(
                      onPressed: () async {
                        if(paymentMethod.isNotEmpty){

                          int result = await Navigator.push(context, MaterialPageRoute(builder: (context) => RazorPayPaymentPage(amount: total),));

                          if(result == 1){
                            // Save the data i.e. Dishes as Order in Orders Collection under User
                            // Order Object -> 1. List of Dishes, 2. Total 3. Address, 4. Restaurant Details

                            placeOrder();
                            clearCart();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
                            => SuccessPage(title: "Order Placed", message: "Thank You For Placing the Order \u20b9 ${total}", flag: true),));

                          }

                          /*if(paymentMethod == "RazorPay"){
                  }else if(paymentMethod == "Paytm"){
                  }else{
                  }*/

                        }
                      }, child: Text("PLACE ORDER"))
                ],
              ),



            ]
        ),
      ),
    );
  }

}