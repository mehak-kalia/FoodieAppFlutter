import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trial/model/user.dart';
import 'package:flutter_trial/pages/show-orders.dart';
import 'package:flutter_trial/profile/user-addresses.dart';
import 'package:flutter_trial/ui/home-page.dart';
import 'package:flutter_trial/util/constants.dart';
import 'package:image_picker/image_picker.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {

  String imageUrl="";

  void UpdateUser(BuildContext context){
    print(Util.appUser!.uid);
    print(Util.appUser!.imageUrl);
    FirebaseFirestore.instance.collection("users").doc(Util.appUser!.uid).update({"imageUrl":Util.appUser!.imageUrl});
    // then((value) => Navigator.pushReplacementNamed(context, "/home"));
  }

  String imageName = "";
  String imagePath="";
  final ImagePicker _picker = ImagePicker();
  Future<void> uploadFile(String filePath) async {
    File file = File(filePath);
    try {
      await FirebaseStorage.instance
          .ref('profile-pics/'+imageName+'.png')
          .putFile(file);


      var dowurl = await ( await FirebaseStorage.instance
          .ref('profile-pics/'+imageName+'.png')
          .putFile(file)).ref.getDownloadURL();
      Util.appUser!.imageUrl = dowurl.toString();
      imageUrl=dowurl.toString();
      Show_Snackbar(context: context,message: "Uploaded");
      print("UPLOAD SUCCESS");
      print(Util.appUser!.imageUrl);


      setState(() {
        UpdateUser(context);
      });
    } on FirebaseException catch (e) {
      Show_Snackbar(context: context,message: "Upload Failed");
      print("UPLOAD FAILED");
    }
  }

  Future<void> _askedToLead() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 5), () {
            Navigator.of(context).pop(true);
          });
          return SimpleDialog(
            title: const Text('Select option'),
            children: <Widget>[
              SimpleDialogOption(
                  onPressed: () async {
                    final XFile? image = await _picker.pickImage(
                        source: ImageSource.camera);
                    Show_Snackbar(context: context,message: "Uploading");
                    uploadFile(image!.path);

                  },
                  child: Text('Camera'),
                  padding: EdgeInsets.all(20)
              ),
              SimpleDialogOption(
                  onPressed: () async {
                    final XFile? image = await _picker.pickImage(
                        source: ImageSource.gallery);
                    uploadFile(image!.path);
                    Show_Snackbar(context: context,message: "Uploading");

                  },
                  child: Text('Gallery'),
                  padding: EdgeInsets.all(20)


              ),
            ],
          );
        });

  }

  fetchAddress() async{
    String uid = await FirebaseAuth.instance.currentUser!.uid.toString();
    var address = await FirebaseFirestore.instance
        .collection(Util.USERS_COLLECTION)
        .doc(Util.appUser!.uid).collection(Util.ADDRESS_COLLECTION);


    if (Util.ADDRESS_COLLECTION != null){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => UserAddressesPage())
      );
    }
    else{
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => UserAddressesEmptyPage())
      );
    }
  }


  Future fetchUserDetails() async {
    print("hello");
    String uid = await FirebaseAuth.instance.currentUser!.uid.toString();
    var document = await FirebaseFirestore.instance
        .collection(Util.USERS_COLLECTION)
        .doc(uid)
        .get();


    // appUser =AppUser();
    // print("Hello $document.get['uid'].toString()");
    // appUser!.uid = document.get('uid').toString();
    // appUser!.name = document.get('name').toString();
    // appUser!.email = document.get('email').toString();
    // appUser!.imageUrl = document.get('imageUrl').toString();
    // image=appUser!.imageUrl!;

    if (document.exists) {
      Util.appUser = AppUser();
      print("Hello $document.get['uid'].toString()");
      Util.appUser!.uid = document.get('uid').toString();
      Util.appUser!.name = document.get('name').toString();
      Util.appUser!.email = document.get('email').toString();
      Util.appUser!.imageUrl = document.get('imageUrl').toString();

      imageName=document.get('email').toString();
      imageUrl=Util.appUser!.imageUrl!;
    } else {
      print("error");
    }
    return Util.appUser ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<dynamic>(
          future: fetchUserDetails(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return Container(decoration: BoxDecoration(
                  image: DecorationImage(fit: BoxFit.fill,
                      image: AssetImage("bg.png"))
              ),
                child: ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    Card(
                      elevation: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(padding: EdgeInsets.all(8)),
                          InkWell(
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(imageUrl),
                              radius: 80,
                            ),
                            onTap: () {
                              _askedToLead();
                              //image picker logic
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            Util.appUser!.name.toString(),
                            style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                          ),
                          Text(
                            Util.appUser!.email.toString(),
                            style: TextStyle(color: Colors.black38, fontSize: 15),
                          ),
                          SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(color: Colors.white,
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text(
                          "Manage Profile",
                        ),
                        subtitle: Text("Update Your Data for Your Account"),
                        trailing: Icon(Icons.keyboard_arrow_right_sharp),
                        onTap: () {},
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(color: Colors.white,
                      child: ListTile(
                        leading: Icon(Icons.shopping_cart),
                        title: Text(
                          "Manage Orders",
                        ),
                        subtitle: Text("Manage your Order History here"),
                        trailing: Icon(Icons.keyboard_arrow_right_sharp),
                        onTap: () {

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => OrdersPage())
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(color: Colors.white,
                      child: ListTile(
                        leading: Icon(Icons.home),
                        title: Text(
                          "Manage Addresses",
                        ),
                        subtitle: Text("Update Your Addresses for Delivery"),
                        trailing: Icon(Icons.keyboard_arrow_right_sharp),
                        onTap: () { fetchAddress();

                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(color: Colors.white,
                      child: ListTile(
                        leading: Icon(Icons.message),
                        title: Text(
                          "Help",
                        ),
                        subtitle: Text("Raise your Queries"),
                        trailing: Icon(Icons.keyboard_arrow_right_sharp),
                        onTap: () {},
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(color: Colors.white,
                      child: ListTile(

                        leading: Icon(Icons.document_scanner_outlined),
                        title: Text(
                          "Terms & Conditions",
                        ),
                        subtitle: Text("Check our Terms and Conditions"),
                        trailing: Icon(Icons.keyboard_arrow_right_sharp),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator(),);
            }
          }),
    );
  }
}
