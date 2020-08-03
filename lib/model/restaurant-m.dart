import 'package:flutter/material.dart';

class RestaurantM{
  int id;
  String name;
  String description;
  double ratings;
  String reviews;
  String imgPath;


  RestaurantM({
    Key key,
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.ratings,
    @required this.reviews,
    @required this.imgPath
  });
   Map<String, dynamic>toMap(){
     var map = <String, dynamic>{
      'id':id,
      'name':name,
      'description':description,
      'ratings':ratings,
       'reviews':reviews,
         'imgPath':imgPath,
     };
     return map;
  }
  RestaurantM.fromMap(Map<String, dynamic> map){
      id = map['id'];
      name = map['name'];
     description = map['description'];
     ratings = map['ratings'];
      reviews = map['reviews'];
    imgPath = map['imgPath'];
  }

}