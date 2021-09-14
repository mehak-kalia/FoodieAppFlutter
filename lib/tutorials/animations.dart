import 'dart:math';

import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({Key? key}) : super(key: key);

  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {

  Color color = Colors.green;
  double borderradius = 50;
  double margin = 10;

  void updateAttributes(){

  }
  @override
  void initState(){
    super.initState();


  }
  @override
  void dispose(){
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animations Introduction"),

      ),
      body: Center(
        child: Column(
          children: [
            AnimatedContainer(
              width: 256,
              height: 256,
              margin: EdgeInsets.all(margin), duration: Duration(milliseconds: 1000),
              color: color,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(borderradius),
              ),

            )
          ],
        ),
      ),
    );
  }
}
