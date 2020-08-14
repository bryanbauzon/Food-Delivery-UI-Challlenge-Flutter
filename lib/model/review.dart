import 'package:flutter/material.dart';
class Review{
  int id;
  int userId;
  int resId;
  int restaurantMenuId;
  String reviews;
  String upddt;

  Review({
    Key key,
    @required this.id,@required this.userId,
    @required this.resId, @required this.restaurantMenuId,
    @required this.reviews,@required this.upddt
  });

   Map<String, dynamic>toMap(){
     var map = <String, dynamic>{
      'id':id,
      'userId':userId,
      'resId':resId,
      'restaurantMenuId':restaurantMenuId,
      'reviews':reviews,
      'upddt':upddt,
     };
     return map;
  }
  Review.fromMap(Map<String, dynamic> map){
      id = map['id'];
      userId = map['userId'];
     resId = map['resId'];
     restaurantMenuId = map['restaurantMenuId'];
     reviews = map['reviews'];
     upddt = map['upddt'];
  }
}