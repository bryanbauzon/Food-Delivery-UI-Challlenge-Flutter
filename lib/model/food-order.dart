import 'package:flutter/material.dart';

class FoodOrder{
  int id;
  String image;
  String name;
  double price;

  FoodOrder({
    @required this.id,
    @required this.image,
    @required this.name,
    @required this.price
  });
}