import 'package:flutter/material.dart';



void main() {
  runApp(MyApp());
}
final Color purple = Color.fromARGB(255, 91, 13, 109);
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: purple),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Quotespage()
      ),
    );
  }
}




class Quotespage extends StatefulWidget {
  const Quotespage({Key? key}) : super(key: key);

  @override
  _QuotespageState createState() => _QuotespageState();
}

class _QuotespageState extends State<Quotespage> {

  var quotes = [
    "Be Exceptional",
    "Work hard, and Succeed",
    "Search the candle rather than cursing the darkness",
    "Always Smile and be Happy"
  ];

  var idx = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(quotes[idx]),
            SizedBox(height: 100),
            Divider(),
            InkWell(
                child: Text('Next Quote'),
                onTap: (){
                  setState(() {
                    if( idx == quotes.length-1){
                      idx = 0;
                    }else{
                      idx++;
                    };
                  });
                }),
            Divider()
          ],
        )
    );
  }
}
    
    