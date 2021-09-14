import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trial/pages/dishes-page.dart';
import 'package:flutter_trial/util/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';

class RestaurantsPage extends StatefulWidget {
  const RestaurantsPage({Key? key}) : super(key: key);

  @override
  _RestaurantsPageState createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {
  List<String> imagesList = [];
  int index = 0;

  fetchRestaurants(){
    // Stream is a Collection i.e. a List of QuerySnapshot
    // QuerySnapshot is our Document :)
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection(Util.RESTAURANT_COLLECTION).snapshots();
    return stream;
  }

  Future fetchCarouselpics() async {
    await FirebaseFirestore.instance.collection(Util.EXTRA_COLLECTION).doc('carousel-photos').get()
        .then((value){
          setState(() {
            List.from(value['imageUrl']).forEach((element) {
              var url = (element);

              imagesList.add(url);
              print("images: ${imagesList}");

            });
          });

        return imagesList;
        });
  }

   @override
  Widget build(BuildContext context) {


    return SingleChildScrollView(

      child: Column(
        children: [
          FutureBuilder<dynamic>(
              future: fetchCarouselpics(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                //print("List: ${}");

                  return CarouselSlider(items: [
                    Image.network(imagesList[0]),
                    Image.network(imagesList[1]),
                    Image.network(imagesList[2]),
                    Image.network(imagesList[3]),
                    Image.network(imagesList[4])] ,
                      options: CarouselOptions(
                       autoPlayInterval: Duration(seconds: 3),
                       autoPlay: true,
                      ));

              }),

          /*StreamBuilder(
            stream: fetchCarouselpics(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              if(snapshot.hasError){
                return Center(
                  child: Text("SOMETHING WENT WRONG", style: TextStyle(color: Colors.red),),
                );
              }

              if(snapshot.connectionState == ConnectionState.waiting){
                return Container(color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }


              return Container(
                child: CarouselSlider(
                  items: snapshot.data!.docs.map<Widget>((DocumentSnapshot document){
                 Map<String, dynamic> map = document.data()! as Map<String, dynamic>;}),
                  options: CarouselOptions(
                    height: 300,

                  ),
                )
              );
            }
          ),*/
          Divider(),
          StreamBuilder(
            stream: fetchRestaurants(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              if(snapshot.hasError){
                return Center(
                  child: Text("SOMETHING WENT WRONG", style: TextStyle(color: Colors.red),),
                );
              }

              if(snapshot.connectionState == ConnectionState.waiting){
                return Container(color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              //List data = [10, 20, 30];
              //List data1 = data.map((e) => e+10).toList();

              /*List<DocumentSnapshot> snapshots = snapshot.data!.docs;
                List<ListTile> tiles = [];
                snapshots.forEach((document) {
                  Map      cghfhg<String, dynamic> map = document.data()! as Map<String, dynamic>;
                  tiles.add(
                      ListTile(
                        title: Text(map['name']),
                        subtitle: Text(map['categories']),
                      )
                  )
                });*/

              return  ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(16),
                    children: snapshot.data!.docs.map<Widget>((DocumentSnapshot document){
                      Map<String, dynamic> map = document.data()! as Map<String, dynamic>;

                      return Card(shadowColor: Colors.black12,
                        borderOnForeground: true,
                        elevation: 20,
                        child: Container(
                          padding: EdgeInsets.all(16.0),

                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          InkWell(child: Row(
                                  children: [

                                    Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                        alignment: Alignment.bottomLeft ,
                                        height: 100,
                                        width: 150,
                                        child: Image.network(map['imageUrl'].toString())),

                                    Container(alignment: AlignmentDirectional.topStart,
                                      child: Column(textDirection: TextDirection.ltr,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(map['name'], style: TextStyle(fontSize: 18),),
                                          SizedBox(height: 5,),
                                          Text("Flat 50% OFF  \non all restaurants", style: TextStyle(color: Colors.black54, fontSize: 10),),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                                  onTap: (){
                                    // Navigate to another page where we will display dishes
                                    // + 1 - -> Develop Counter Widget on UI
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => DishesPage(restaurantId: document.id,))
                                    );

                                  },),

                          Divider(),

                              Row(mainAxisAlignment: MainAxisAlignment.start,
                                  children:[
                                    Text("Categories "+map['categories'].toString(), style: TextStyle(color: Colors.black54, fontSize: 17),),
                                    Spacer(),
                                    Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width/11,
                                      padding: EdgeInsets.all(6.0),
                                      child: Text(map['ratings'].toString(), style: TextStyle(color: Colors.white),),
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.circular(8.0)
                                      ),
                                    ),
                                  ]
                              ),


                              //Text(categories, style: TextStyle(fontSize: 16, color: Colors.black45),),

                            ],
                          ),
                        ),
                      );
                    }).toList()
































                );


            },

          ),
        ],
      ),
    );
  }
}