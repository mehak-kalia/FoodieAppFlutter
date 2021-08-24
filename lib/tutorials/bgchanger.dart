import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: View()
        )
    );
  }
}

class View extends StatefulWidget {

  ViewState createState() => ViewState();

}

class ViewState extends State{

  // Default Background Color.
  Color colorCode = Colors.lightBlue;



  Changecolor(){
    var idx = 0;
    List<ColorSwatch<int>> tmpColor = [Colors.amber,  Colors.deepPurple, Colors.deepOrangeAccent  ] ;

    setState(() {
    colorCode = tmpColor[idx] as Color;
    idx++;
      }


    ) ;



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorCode,
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

            SizedBox(height: 100),
            Divider(),
            InkWell(
                child: Text('Change Color'),
                onTap: () => Changecolor()),
            Divider()
            ],
        )
    )
    );
  }
}