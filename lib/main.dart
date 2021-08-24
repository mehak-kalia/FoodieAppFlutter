import 'package:flutter/material.dart';
import 'package:flutter_trial/auth/login-page.dart';
import 'package:flutter_trial/auth/register-page.dart';
import 'package:flutter_trial/pages/cart-page.dart';
import 'package:flutter_trial/tutorials/assignment.dart';
import 'package:flutter_trial/tutorials/fetch-current-location.dart';
import 'package:flutter_trial/tutorials/google-maps-with-location.dart';
import 'package:flutter_trial/tutorials/image-picker-task.dart';
import 'package:flutter_trial/ui/admin-page.dart';
import 'package:flutter_trial/ui/home-page.dart';
import 'package:flutter_trial/ui/splash-page.dart';
import 'tutorials/NewsPage.dart';
import 'tutorials/ProfilePage.dart';
import 'package:firebase_core/firebase_core.dart';


// main function represents main thread
// whatever we code in main, is executed by main thread
// that too in a sequence
Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => SplashPage(),
        "/ui": (context) => HomePage(),
         "News": (context) => NewsPage(),
        "/login": (context) => LoginPage(),
        "/register": (context) => RegisterUserPage(),
        "/imagep": (context) => ImagePickerPage(),
        "/admin": (context) => AdminHomePage(),
        "/cart": (context) => CartPage(),
        "/fetch-current-location" : (context) => FetchCurrentLocationPage(),
        "/google-maps": (context) => GoogleMapsPage()
        //"/todo": (context) => TodosScreen(todos: [],)



      },
    initialRoute: "/",
    );
  }
}

/*class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: Scaffold(backgroundColor: Colors.white,

          body: ProfilePage()
      ),
    );
  }
}*/
