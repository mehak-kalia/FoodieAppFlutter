import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_trial/custom-widgets/counter.dart';
import 'package:flutter_trial/model/dish.dart';
import 'package:flutter_trial/util/constants.dart';

class DishesPage extends StatefulWidget {

  String? restaurantId;

  DishesPage({Key? key, this.restaurantId}) : super(key: key);

  @override
  _DishesPageState createState() => _DishesPageState();
}

class _DishesPageState extends State<DishesPage> {

  fetchRestaurants(){
    // Stream is a Collection i.e. a List of QuerySnapshot
    // QuerySnapshot is our Document :)
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection(Util.RESTAURANT_COLLECTION)
        .doc(widget.restaurantId).collection(Util.DISHES_COLLECTION).snapshots();
    return stream;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Util.APP_NAME),
          actions: [
            IconButton(
              onPressed: (){
                Navigator.pushReplacementNamed(context, "/cart");
              }, icon: Icon(Icons.shopping_cart),
              tooltip: "Cart",

            ),
            IconButton(
              onPressed: (){
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, "/login");
              }, icon: Icon(Icons.logout),
              tooltip: "Log Out",

            )
          ],
        ),


      body: StreamBuilder(
        stream: fetchRestaurants(),
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
            color: Colors.green,
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
                          Image.network(map['imageUrl'].toString()),
                          SizedBox(height: 10,),
                          Text(map['name'], style: TextStyle(fontSize: 22),),
                          Row(
                              children:[
                                Text("Price \u20b9"+map['price'].toString(), style: TextStyle(color: Colors.black54, fontSize: 18),),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.all(6.0),
                                  child: Text(map['ratings'].toString(), style: TextStyle(color: Colors.white),),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(8.0)
                                  ),
                                ),
                              ]
                          ),
                          Divider(),

                          //Text(categories, style: TextStyle(fontSize: 16, color: Colors.black45),),
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [Spacer(),Counter(dish: map)]),
                          SizedBox(height: 10,)
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
}