import 'dart:js';

import 'package:flutter/material.dart';

Route getAnimatedRoute(Widget page){

  return PageRouteBuilder<SlideTransition>
    (
      pageBuilder: (context, animation, secondaryAnimation){
        return page;
      },
    transitionsBuilder: (context, animation, secondaryAnimation, child){
       var tween = Tween<Offset>(
         begin: Offset(0.0, 1.0), end: Offset.zero
       ) ;
       var curveTween = CurveTween(curve: Curves.ease);

       return SlideTransition(position: animation.drive(curveTween).drive(tween),
       child: child,);
    });


}

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PAGE ONE"),

      ),
      body: Center(

      ),
    );
  }
}
