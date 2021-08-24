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

  int initialValue=0;

  @override
  Widget build(BuildContext context) {

    updateDishInCart(){
      Dish cartDish = Dish(name: widget.dish!['name'].toString(),
          price: widget.dish!['price'],
          quantity: initialValue,
          totalPrice: initialValue * (widget.dish!['price'] as int)
      );

      // here you need to now add the dish with quantity as 1 in dishes cart
      FirebaseFirestore.instance.collection(Util.USERS_COLLECTION)
          .doc(Util.appUser!.uid)
          .collection(Util.CART_COLLECTION).doc(widget.dish!['docId']).set(cartDish.toMap());

    }

    deleteDishFromCart(){
      FirebaseFirestore.instance.collection(Util.USERS_COLLECTION)
          .doc(Util.appUser!.uid)
          .collection(Util.CART_COLLECTION).doc(widget.dish!['docId']).delete();
    }

    return  Container(width: (MediaQuery.of(context).size.width)/2,


        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10) ,
            border: Border(
              bottom: BorderSide(color: Colors.green),
              left: BorderSide(color: Colors.green) ,
              right: BorderSide(color: Colors.green) ,
              top: BorderSide(color: Colors.green)
            )
        ),
        child: initialValue == 0?Row(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            TextButton(onPressed: (){
             setState(() {
             initialValue++;
             updateDishInCart();
              });
             }, child: Text("ADD", style: TextStyle(color: Colors.green, fontSize: 20),),)
        ],)
        :Row(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            TextButton(onPressed: (){
              setState(() {
                if(initialValue <= 0) {
                  initialValue = 0;
                }else{
                  initialValue--;
                  deleteDishFromCart();
                }
              });
            }, child: Text("-", style: TextStyle(color: Colors.green, fontSize: 20),),
            ),
            Spacer(),
            Text(initialValue.toString(), style: TextStyle(color: Colors.black, fontSize: 16),),
            Spacer(),
            TextButton(onPressed: (){
              setState(() {
                initialValue++;
                updateDishInCart();
              });
            }, child: Text("+", style: TextStyle(color: Colors.green, fontSize: 20),),
            )
          ],
        ),
      );

  }
}