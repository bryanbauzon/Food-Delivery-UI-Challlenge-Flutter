import 'package:flutter/material.dart';

class FoodOrder{
  int id;
  int userId;
  int restaurantMenuId;
  int resId; //restaurant id
  int quantity;

  FoodOrder({
    Key key,
    @required this.id,
    @required this.userId,
    @required this.restaurantMenuId,
    @required this.resId,
    @required this.quantity
  });
   Map<String, dynamic>toMap(){
     var map = <String, dynamic>{
      'id':id,
      'userId':userId,
      'restaurantMenuId':restaurantMenuId,
      'resId':resId,
      'quantity':quantity,
     };
     return map;
  }
  FoodOrder.fromMap(Map<String, dynamic> map){
      id = map['id'];
      userId = map['userId'];
     restaurantMenuId = map['restaurantMenuId'];
     resId = map['resId'];
     quantity = map['quantity']; 
  }
}