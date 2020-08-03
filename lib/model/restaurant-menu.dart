import 'package:flutter/material.dart';

class RestaurantMenu{
  int id;
  int resId;//restaurantID
  String imagePath;
  String name;
  String reviews;
  String descriptions;
  double price;

  RestaurantMenu({
    Key key,
    @required this.id,
    @required this.resId,
    @required this.imagePath,
    @required this.name,
    @required this.reviews,
    @required this.descriptions,
    @required this.price,
  });
   Map<String, dynamic>toMap(){
     var map = <String, dynamic>{
      'id':id,
      'resId':resId,
      'imagePath':imagePath,
      'name':name,
      'reviews':reviews,
      'descriptions':descriptions,
      'price':price,
     };
     return map;
  }
  RestaurantMenu.fromMap(Map<String, dynamic> map){
      id = map['id'];
      resId = map['resId'];
     imagePath = map['imagePath'];
     name = map['name'];
     reviews = map['reviews'];
     descriptions = map['descriptions'];
     price = map['price'];
  }
}