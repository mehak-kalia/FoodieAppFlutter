import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
              title: Text("Friends List")),
          body: Friends()
      ),
    );
  }
}

class Friends extends StatefulWidget {
  const Friends({Key? key}) : super(key: key);

  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {

  var backgroundColors = <String, Color>{
    "John":Colors.black,
    "Jennie": Colors.orange,
    "Jim":  Colors.green,
    "Jack": Colors.blue,
    "Joe": Colors.amber,
    "Red":  Colors.red,
  };

  Color backgroundColor = Colors.deepPurple;

  getWidgets(){
    var widgets = <Widget>[];
    backgroundColors.forEach((key, value) {
      widgets.add(InkWell(
        child: Text(key, style: TextStyle(color: Colors.white, fontSize: 24),),
        onTap: (){
          setState(() {
            backgroundColor = value;

          });
        },
      ));
      widgets.add(Divider());
    });
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView(
          children: [Container(
              height: (MediaQuery.of(context).size.height)/2,
              color: Colors.pinkAccent,
              child:ListView(
                children: getWidgets(),
              )
          ),
            Container(
              height: (MediaQuery.of(context).size.height)/2,
              color: backgroundColor,


            )],


        ));

  }
}