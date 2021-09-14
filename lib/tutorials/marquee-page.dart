import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class MarqueePage extends StatefulWidget {
  const MarqueePage({Key? key}) : super(key: key);

  @override
  _MarqueePageState createState() => _MarqueePageState();
}

class _MarqueePageState extends State<MarqueePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Marquee"
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Marquee(scrollAxis: Axis.horizontal ,
                text: "Flat 50% OFF on All Restaurants")
          ],
        ),
      ),
    );
  }
}
