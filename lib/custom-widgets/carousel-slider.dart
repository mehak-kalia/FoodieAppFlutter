import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trial/util/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Carouselslider extends StatefulWidget {
  const Carouselslider({Key? key}) : super(key: key);

  @override
  _CarouselsliderState createState() => _CarouselsliderState();
}

List<String> imagesList = [];


class _CarouselsliderState extends State<Carouselslider> {


  Future fetchCarouselpics() async {
    await FirebaseFirestore.instance.collection(Util.EXTRA_COLLECTION).doc('carousel-photos').get()
        .then((value){
      setState(() {
        List.from(value['imageUrl']).forEach((element) {
          var url = (element);

          imagesList.add(url);
          print("images: ${imagesList}");

        });
      });

      return imagesList;
    });
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: fetchCarouselpics(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          //print("List: ${}");

          return CarouselSlider(items: [
            Image.network(imagesList[0]),
            Image.network(imagesList[1]),
            Image.network(imagesList[2]),
            Image.network(imagesList[3]),
            Image.network(imagesList[4])] ,
              options: CarouselOptions(
                autoPlayInterval: Duration(seconds: 3),
                autoPlay: true,
              ));

        });

  }
}
