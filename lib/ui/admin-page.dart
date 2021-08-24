import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trial/util/constants.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
        title: Text(Util.APP_NAME+ " Admin"), actions: [
    IconButton(
    onPressed: (){
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, "/login");
    }, icon: Icon(Icons.logout),
    tooltip: "Log Out",

    )
    ],
    ),
    );
  }
}
