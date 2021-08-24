import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100
          ),
          Text("John Watson",style: TextStyle(color: Colors.black, fontSize: 25)),
          Text("Frontend Developer with 2 years experience",style: TextStyle(color: Colors.black38, fontSize:18 )),
          SizedBox(height: 20,),
          Container(height: 20,
              width: 300,
              color: Color(0xff6441B053)),
          Container(height: 30,
              width: 300,
              color: Color(0xff6441B053),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(width: 20,height:20),
                  Text("Followers", style: TextStyle(color: Color(0xff0C2710), fontSize: 18),),
                  SizedBox(width: 60,),
                  Text("Following", style: TextStyle(color: Color(0xff0C2710), fontSize: 18),),
                  SizedBox(width: 60,),
                  Text("Articles", style: TextStyle(color: Color(0xff0C2710), fontSize: 18),)],
              )),
          Container(height: 47,
            width: 300,
            color: Color(0xff6441B053),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(width: 45,height:20),
                Text("120", style: TextStyle(color: Color(0xff2F6237), fontSize: 18),),
                SizedBox(width: 110,),
                Text("50", style: TextStyle(color: Color(0xff2F6237), fontSize: 18),),
                SizedBox(width: 110,),
                Text("10", style: TextStyle(color: Color(0xff2F6237), fontSize: 18),)],
            ),

          ),Container(height: 30,
              width: 300,
              color: Color(0xff6441B053),

              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text("Explore More Articles", style: TextStyle(color: Color(0xff2F6237), fontSize: 16),)]
              )),
          Container(height: 30,
              width: 300,
              color: Color(0xff6441B053),

              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [Container(
                  height : 35,
                  width: 100,
                  color: Colors.green,
                  child: InkWell(
                    child: Text("Explore More"),
                  ),
                )],

              ))],
      ),
    );
  }
}
