import 'package:flutter/material.dart';

class FoodOrder{
  int id;
  int userId;
  int restaurantMenuId;

  FoodOrder({
    @required this.id,
    @required this.userId,
    @required this.restaurantMenuId,
    
  });
   Map<String, dynamic>toMap(){
     var map = <String, dynamic>{
      'id':id,
      'userId':userId,
      'restaurantMenuId':restaurantMenuId,
     };
     return map;
  }
  FoodOrder.fromMap(Map<String, dynamic> map){
      id = map['id'];
      userId = map['userId'];
     restaurantMenuId = map['restaurantMenuId'];
  }
}