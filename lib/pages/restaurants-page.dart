import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trial/pages/dishes-page.dart';
import 'package:flutter_trial/util/constants.dart';

class RestaurantsPage extends StatefulWidget {
  const RestaurantsPage({Key? key}) : super(key: key);

  @override
  _RestaurantsPageState createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {

  fetchRestaurants(){
    // Stream is a Collection i.e. a List of QuerySnapshot
    // QuerySnapshot is our Document :)
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection(Util.RESTAURANT_COLLECTION).snapshots();
    return stream;
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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

        return Container(color: Colors.black12,
          child: ListView(
              padding: EdgeInsets.all(16),
              children: snapshot.data!.docs.map<Widget>((DocumentSnapshot document){
                Map<String, dynamic> map = document.data()! as Map<String, dynamic>;

                return Card(
                  child: Container(
                    padding: EdgeInsets.all(16.0),

                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(child: Image.network(map['imageUrl'].toString()),
                          onTap: (){
                            // Navigate to another page where we will display dishes
                            // + 1 - -> Develop Counter Widget on UI
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => DishesPage(restaurantId: document.id,))
                            );

                          },),
                        SizedBox(height: 10,),
                        Text(map['name'], style: TextStyle(fontSize: 22),),
                        Row(
                            children:[
                              Text("Categories "+map['categories'].toString(), style: TextStyle(color: Colors.black54, fontSize: 18),),
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
                        SizedBox(height: 10,)
                      ],
                    ),
                  ),
                );
              }).toList()































                /*return ListTile(
                  title: Text(map['name']),
                  subtitle: Text(map['categories']),
                  onTap: (){
                    // Navigate to another page where we will display dishes
                    // + 1 - -> Develop Counter Widget on UI
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DishesPage(restaurantId: document.id,))
                    );

                  },
                );
              }).toList()*/
          ),
        );

      },

    );
  }
}