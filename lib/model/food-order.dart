import 'package:flutter/material.dart';

class FoodOrder{
  int id;
  int userId;
  String image;
  String name;
  double price;

  FoodOrder({
    @required this.id,
    @required this.userId,
    @required this.image,
    @required this.name,
    @required this.price
  });
   Map<String, dynamic>toMap(){
     var map = <String, dynamic>{
      'id':id,
      'userId':userId,
      'name':name,
      'price':price,
     };
     return map;
  }
  FoodOrder.fromMap(Map<String, dynamic> map){
      id = map['id'];
      userId = map['userId'];
     name = map['name'];
     price = map['price'];
  }
}