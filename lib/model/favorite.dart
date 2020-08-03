import 'package:flutter/material.dart';
class Favorite{
  int id;
  int userId;
  String name;
  double price;

  Favorite({Key key,
    @required this.id,@required this.userId,@required this.name,@required this.price});

   Map<String, dynamic>toMap(){
     var map = <String, dynamic>{
      'id':id,
      'userId':userId,
      'name':name,
      'price':price,
     };
     return map;
  }
  Favorite.fromMap(Map<String, dynamic> map){
      id = map['id'];
      userId = map['userId'];
     name = map['name'];
     price = map['price'];
  }
}