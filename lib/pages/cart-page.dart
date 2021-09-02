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
import 'package:flutter_trial/util/constants.dart';

class CartPage extends StatefulWidget {

  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  int total = 0;

  fetchDishesInCart(){
    print("fetchDishesInCart");
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection(Util.USERS_COLLECTION).doc(Util.appUser!.uid).collection(Util.CART_COLLECTION).snapshots();
    print("stream");
    return stream;
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back),
        onPressed: () {
        Navigator.popAndPushNamed(context, "/ui");
        }),
        title: Text(Util.APP_NAME+ " Cart"),


        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushReplacementNamed(context, "/cart");
            }, icon: Icon(Icons.shopping_cart),
            tooltip: "Shopping Cart",
          ),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, "/login");
            },
            icon: Icon(Icons.logout),
            tooltip: "Log Out",
          ),
        ],
      ),

      body: Column(
        children: [
          StreamBuilder(
              stream: fetchDishesInCart(),
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

                //List data = [10, 20, 30];
                //List data1 = data.map((e) => e+10).toList();

                /*List<DocumentSnapshot> snapshots = snapshot.data!.docs;
              List<ListTile> tiles = [];
              snapshots.forEach((document) {
                Map<String, dynamic> map = document.data()! as Map<String, dynamic>;
                tiles.add(
                    ListTile(
                      title: Text(map['name']),
                      subtitle: Text(map['categories']),
                    )
                )
              });*/

                return ListView(
                    children: [Column(
                        children: snapshot.data!.docs
                            .map<Widget>((DocumentSnapshot document) {
                          Map<String, dynamic> map = document.data()! as Map<String, dynamic>;
                          map['docId'] = document.id.toString();

                          total += map["price"]*map["quantity"] as int;
                          return Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.fastfood),
                                title: Text(map["name"]),
                                subtitle: Text(" ${map["quantity"].toString()} * ₹${map["price"]}"),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("="),

                                    Text(" ₹${(map["price"]*map["quantity"]).toString()} ")
                                  ],
                                ),
                              ),

                            ],
                          );
                        }).toList()
                    ),
                      Divider(),

                    ]);
              }),

        ],
      ),      bottomNavigationBar: Row(crossAxisAlignment: CrossAxisAlignment.end,
        children:[Container(padding: EdgeInsets.all(8),

            width: (MediaQuery.of(context).size.width)/2,
            height: 12,

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,

                border: Border(
                    bottom: BorderSide(color: Colors.green),
                    left: BorderSide(color: Colors.green) ,
                    right: BorderSide(color: Colors.green) ,
                    top: BorderSide(color: Colors.green)
                )
            ),
            child: Column(
                children: [Text("Set Payment", style: TextStyle( fontSize: 15), ),
                  SizedBox(height: 5,),
                  Text("Payment Method", style: TextStyle( fontSize: 18) ),
                ]

            )
        ),
          SizedBox(height: 5,),
          Container(padding: EdgeInsets.all(8),

              width: (MediaQuery.of(context).size.width)/2,
              height: 120,

              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(10),
                color: Colors.green,
              ),
              child: Column(
                  children: [Text("Proceed To Pay" ,style: TextStyle(color: Colors.white , fontSize: 18)),
                    SizedBox(height: 5,),
                    Text("Total Price: ${total}" ,style: TextStyle(color: Colors.white , fontSize: 15)),
                  ]

              ))
        ]

    ),
    );
  }
}