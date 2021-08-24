import 'package:flutter/material.dart';

class ListViewDemo extends StatelessWidget {
  const ListViewDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      children: <ListTile>[
        ListTile(
          title: Text('TechCrunch'),
          focusColor: Colors.deepPurple,hoverColor: Colors.pink,
        )
      ],
    );
  }
}
