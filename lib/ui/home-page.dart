
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trial/pages/restaurants-page.dart';
import 'package:flutter_trial/profile/user-profile.dart';
import 'package:flutter_trial/util/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int index = 0;

  List<Widget> widgets = [
    RestaurantsPage(),
    Center(child: Text("SEARCH PAGE")),
    UserProfilePage()
  ];

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

      body: widgets[index],

      bottomNavigationBar: BottomNavigationBar(
        items: [
          // 0
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "HOME"
          ),
          // 1
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "SEARCH"
          ),
          //2
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: "PROFILE"
          )
        ],

        currentIndex: index,
        selectedFontSize: 16,
        selectedItemColor: Colors.deepOrange,
        onTap: (idx){ // idx will have value of the index of BottomNavBarItem
          setState(() {
            index = idx;
          });
        },
      ),

    );
  }
}

class Show_Snackbar{
  String message;
  BuildContext context;
  Show_Snackbar({required this.context,required this.message}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(this.message.toString()),
      duration: Duration(seconds: 3),
    )
    );
  }
}