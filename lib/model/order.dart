class Order{


  List dishes = [];
  int? total;
  String? address;
  String? restaurant_name;

  Order({this.restaurant_name, required this.dishes, this.total, this.address});


}