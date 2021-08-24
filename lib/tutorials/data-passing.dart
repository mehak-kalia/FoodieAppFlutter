import 'package:flutter/material.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
        debugShowCheckedModeBanner: false,
        home: PageOne()
    );
  }
}

//int? num1 = 5;
class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  int? num1 = 5;

  String title = "Page One";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Enter the number"),
              SizedBox(height: 10,),
              TextField(),
              SizedBox(height: 10,),
              InkWell(
                child: Text("SUBMIT"),
                onTap: () async {


                  await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PageTwo(num2: num1))
                  );

                },
              )
            ],
          ),
        )
    );
  }
}

class PageTwo extends StatelessWidget {

  int? num2;

  PageTwo({Key? key, this.num2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Page Two"),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(num2.toString()),
                InkWell(
                  child: Text("DONE"),
                  onTap: (){

                    Navigator.pop(context);
                  },
                )
              ],
            )
        )
    );
  }
}

