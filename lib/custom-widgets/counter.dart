import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trial/model/dish.dart';
import 'package:flutter_trial/util/constants.dart';

class Counter extends StatefulWidget {
  Map<String, dynamic>? dish;

  Counter({Key? key, @required this.dish}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {

  int initialValue = 0;


  fetchDishes() {
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection(
        "users").doc(Util.appUser!.uid).collection('cart').snapshots();
    return stream;
  }

  updateDishInCart() async {
    Dish cartDish = Dish(
      name: widget.dish!['name'],
      price: widget.dish!['price'] as int,
      quantity: initialValue,
      totalPrice: widget.dish!['price'] * initialValue,

    );

    await FirebaseFirestore.instance.collection("users").doc(Util.appUser!.uid)
        .collection('cart').doc(widget.dish!['docID'])
        .set(cartDish.toMap());
  }

  deleteDishFromCart() async {
    await FirebaseFirestore.instance.collection("users").doc(Util.appUser!.uid)
        .collection('cart').doc(widget.dish!['docID'])
        .delete();
  }



  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: fetchDishes(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Something Went Wrong", style: TextStyle(color: Colors.red),),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Container(),
          );
        }
        List snapshots = snapshot.data.docs;
        snapshots.forEach((document) {
          Map map = document.data();
          map['docID'] = document.id.toString();
          if (map['docID'] == widget.dish!['docID']) {
            initialValue = map['quantity'];
          }
        });

        return Container(width: (MediaQuery
            .of(context)
            .size
            .width) / 2,


            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                border: Border(
                    bottom: BorderSide(color: Colors.green),
                    left: BorderSide(color: Colors.green),
                    right: BorderSide(color: Colors.green),
                    top: BorderSide(color: Colors.green)
                )
            ),
            child: initialValue == 0 ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(onPressed: () {
                  setState(() {
                    if (Util.appUser!.email!=null) {
                      initialValue++;
                      updateDishInCart();
                    } else{}
                  });
                },
                  child: Text("ADD",
                    style: TextStyle(color: Colors.green, fontSize: 20),),)
              ],)
                : Row(mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                TextButton(
                  onPressed: (){
                  setState(() async{
                    if(initialValue<=0){
                      initialValue = 0;
                    }else{
                      initialValue--;
                      updateDishInCart();
                      if(initialValue <= 0){
                        deleteDishFromCart();
                      }
                    }
                  });
                },
                  child: Text(
                    "-", style: TextStyle(color: Colors.green, fontSize: 20),),
                ),
                Spacer(),
                Text(initialValue.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 16),),
                Spacer(),
                TextButton(onPressed: () {
                  setState(() {
                    initialValue++;
                    updateDishInCart();
                  });
                },
                  child: Text(
                    "+", style: TextStyle(color: Colors.green, fontSize: 20),),
                )
              ],
            )
        );
      },
    );
  }
}