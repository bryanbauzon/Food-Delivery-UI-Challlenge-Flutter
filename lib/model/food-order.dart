import 'package:flutter/material.dart';

class FoodOrder{
  int id;
  int userId;
  int restaurantMenuId;
  int quantity;

  FoodOrder({
    Key key,
    @required this.id,
    @required this.userId,
    @required this.restaurantMenuId,
    @required this.quantity
  });
   Map<String, dynamic>toMap(){
     var map = <String, dynamic>{
      'id':id,
      'userId':userId,
      'restaurantMenuId':restaurantMenuId,
      'quantity':quantity,
     };
     return map;
  }
  FoodOrder.fromMap(Map<String, dynamic> map){
      id = map['id'];
      userId = map['userId'];
     restaurantMenuId = map['restaurantMenuId'];
     quantity = map['quantity']; 
  }
}