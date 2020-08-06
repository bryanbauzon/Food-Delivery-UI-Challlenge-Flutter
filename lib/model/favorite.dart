import 'package:flutter/material.dart';
class Favorite{
  int id;
  int userId;
  int resId;
  int restaurantMenuId;
  String name;
  double price;

  Favorite({Key key,
    @required this.id,@required this.userId,
    @required this.resId, @required this.restaurantMenuId,
    @required this.name,@required this.price});

   Map<String, dynamic>toMap(){
     var map = <String, dynamic>{
      'id':id,
      'userId':userId,
      'resId':resId,
      'restaurantMenuId':restaurantMenuId,
      'name':name,
      'price':price,
     };
     return map;
  }
  Favorite.fromMap(Map<String, dynamic> map){
      id = map['id'];
      userId = map['userId'];
      resId = map['resId'];
        restaurantMenuId = map['restaurantMenuId'];
     name = map['name'];
     price = map['price'];
  }
}