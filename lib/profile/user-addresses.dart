import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trial/pages/update-address.dart';
import 'package:flutter_trial/util/constants.dart';

class UserAddressesEmptyPage extends StatefulWidget {
  const UserAddressesEmptyPage({Key? key}) : super(key: key);

  @override
  _UserAddressesEmptyPageState createState() => _UserAddressesEmptyPageState();
}

class _UserAddressesEmptyPageState extends State<UserAddressesEmptyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Addresses"),
      ),
      //body: StreamBuilder(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.mail_outline, color: Colors.white,),
        onPressed: (){
          // Open up a UI to Add Address
          Navigator.pushNamed(context, "/addaddress");
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(child: Image.asset("food.png"),
              height: 90,
              width: 90,),
            SizedBox(height: 8,),
            Text("NO ADDRESSES FOUND!!", style: TextStyle(color: Colors.deepOrange, fontSize: 15),),
            SizedBox(height: 8,),
            Text("Tap Button To Add A New Address", style: TextStyle(color: Colors.green, fontSize: 15),),
          ],
        ),
      ),
    );
  }
}










class UserAddressesPage extends StatefulWidget {
  const UserAddressesPage({Key? key}) : super(key: key);

  @override
  _UserAddressesPageState createState() => _UserAddressesPageState();
}

class _UserAddressesPageState extends State<UserAddressesPage> {

  fetchUserAddress() {
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection(
        Util.USERS_COLLECTION).doc(Util.appUser!.uid).collection(
        Util.ADDRESS_COLLECTION).snapshots();

    return stream;
  }

  @override
  Widget build(BuildContext context) {
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
        stream: fetchUserAddress(),
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
                        ListTile(
                          leading: IconButton(
                            icon: Icon(Icons.home),
                            onPressed: (){},
                          ),
                          title: Text(map["label"].toString(), style: TextStyle()),



                        ),
                        Divider()
                      ],

                    );
                  }).toList()
              ),

              ]);
        }),
    );
  }
}

