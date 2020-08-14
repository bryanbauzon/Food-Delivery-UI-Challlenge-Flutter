import 'package:flutter/material.dart';

class User{
  int id;
  String username;

  User({
    Key key,
    @required this.id,
    @required this.username,
  });

   Map<String, dynamic>toMap(){
     var map = <String, dynamic>{
       'id':id,
      'username':username,
     };
     return map;
  }
  User.fromMap(Map<String, dynamic> map){
      id = map['id'];
      username = map['username'];
  }
}