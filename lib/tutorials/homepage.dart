import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homepage extends StatelessWidget {

  const homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("welcome to my app"),
          SizedBox(height: 100),
          Divider(),
          Text("Version 1.0"),
          Text("Name: Hawk")
        ],
      )
    );
  }
}
