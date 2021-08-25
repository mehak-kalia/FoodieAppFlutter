import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trial/model/user.dart';
import 'package:flutter_trial/ui/home-page.dart';
import 'package:flutter_trial/util/constants.dart';

class SplashPage extends StatelessWidget {

  fetchUserDetails() async{
    String uid = await FirebaseAuth.instance.currentUser!.uid.toString();
    DocumentSnapshot document = await FirebaseFirestore.instance.collection(Util.USERS_COLLECTION).doc(uid).get();
    Util.appUser = AppUser();

    Util.appUser!.uid = document.get('uid').toString();
    Util.appUser!.name = document.get('name').toString();
    Util.appUser!.email = document.get('email').toString();
    Util.appUser!.imageUrl = document.get('imageUrl').toString();
  }

  tutorialNavigation(BuildContext context) async{
    Future.delayed(
        Duration(seconds: 3),
            (){
          Navigator.pushNamed(context, "/google-maps");
        }
    );
  }


  navigateToHome(BuildContext context){


    //User? user = FirebaseAuth.instance.currentUser;

    var uid = FirebaseAuth.instance.currentUser != null? FirebaseAuth.instance.currentUser!.uid : "" ;

    Future.delayed(
        Duration(seconds: 3),
            (){
          //Navigator.pushNamed(context, "/home");
          if(uid.isNotEmpty){
             if(uid == "QXVlFf0E1TRPu2d6oGUqYhXiy6n1")
             {Navigator.pushReplacementNamed(context, "/admin");}
            else{
              Navigator.pushReplacementNamed(context, "/ui");};
          }else {
            Navigator.pushReplacementNamed(context, "/login");
          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    navigateToHome(context);
    fetchUserDetails();
    //tutorialNavigation(context);


    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(child: Image.asset("food.png"),
              height: 40,
              width: 40,),
            SizedBox(height: 8,),
            Text(Util.APP_NAME, style: TextStyle(color: Colors.deepOrange, fontSize: 24),),
            Divider(),
            SizedBox(height: 4,),
            Text("We Deliver Fresh", style: TextStyle(color: Colors.grey, fontSize: 18))
          ],
        ),
      ),
    );
  }
}
















