import 'package:flutter/material.dart';

class FoodOrder{
  int id;
  int userId;
  String name;
  String restaurantName;
  int restaurantMenuId;
  int resId; //restaurant id
  int quantity;
  double price;

  FoodOrder({
    Key key,
    @required this.id,
    @required this.userId,
    @required this.name,
    @required this.restaurantName,
    @required this.restaurantMenuId,
    @required this.resId,
    @required this.quantity,
    @required this.price
  });
   Map<String, dynamic>toMap(){
     var map = <String, dynamic>{
      'id':id,
      'userId':userId,
       'name':name,
        'restaurantName':restaurantName,
      'restaurantMenuId':restaurantMenuId,
      'resId':resId,
      'quantity':quantity,
      'price':price,
     };
     return map;
  }
  FoodOrder.fromMap(Map<String, dynamic> map){
      id = map['id'];
      userId = map['userId'];
     name = map['name'];
       restaurantName = map['restaurantName'];
     restaurantMenuId = map['restaurantMenuId'];
     resId = map['resId'];
     quantity = map['quantity']; 
     price = map['price']; 
  }
}