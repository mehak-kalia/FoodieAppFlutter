import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trial/util/constants.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();

}

List <Map> dishes =[];
fetchOrders()
{

    // Stream is a Collection i.e. a List of QuerySnapshot
    // QuerySnapshot is our Document :)
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection(Util.USERS_COLLECTION)
        .doc(Util.appUser!.uid).collection('orders').snapshots();
    return stream;
}
class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, false);
          }),



        title: Text("My Orders"),),
       body: StreamBuilder(
        stream: fetchOrders(),
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

                    List.from(map['dishes']).forEach((element) {
                      var url = (element);

                      dishes.add(url);

                    });




                        return Container(
                          child: Text(
                              dishes.toString()
                          ),
                        );


                  }).toList()
              ),

              ]);
        }),
    );
  }
}
