import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trial/auth/login-page.dart';
import 'package:flutter_trial/auth/register-page.dart';
import 'package:flutter_trial/pages/add-address.dart';
import 'package:flutter_trial/pages/cart-page.dart';
import 'package:flutter_trial/profile/user-addresses.dart';
import 'package:flutter_trial/profile/user-profile.dart';
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
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
AndroidNotificationChannel? channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;


// main function represents main thread
// whatever we code in main, is executed by main thread
// that too in a sequence
Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //Locale.populateMap();

  // to execute the app created by us
  // MyApp -> Object
  runApp(MyApp());
}



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        // Navigator.pushNamed(context, '/message',
        //     arguments: MessageArguments(message, true));
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {

      RemoteNotification? notification = message!.notification;
      AndroidNotification? android = message.notification!.android;

      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            notification.title,
            notification.body,

            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                channel!.description,
                playSound: true,
                //sound: AndroidNotificationSound()
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Navigator.pushNamed(context, '/message',
      //     arguments: MessageArguments(message, true));
    });
  }
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
        "/google-maps": (context) => GoogleMapsPage(),
        "/address": (context) => UserAddressesPage(),
        "/addressnull": (context) => UserAddressesEmptyPage(),
        "/addaddress": (context) => AddAddressPage(),
        "/user": (context) => UserProfilePage()
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
