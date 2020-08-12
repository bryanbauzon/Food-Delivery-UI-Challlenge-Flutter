import 'package:flutter/material.dart';

class NotificationM{
  int id;
  int userId;
  String message;
  String status;
  String updDt;

  NotificationM({
    Key key,
    @required this.id,
    @required this.userId,
    @required this.message,
    @required this.status,
    @required this.updDt
  });

   Map<String, dynamic>toMap(){
     var map = <String, dynamic>{
      'id':id,
      'userId':userId,
      'message':message,
      'status':status,
      'updDt':updDt,
      
     };
     return map;
  }
  NotificationM.fromMap(Map<String, dynamic> map){
      id = map['id'];
      userId = map['userId'];
      message = map['message'];
      status = map['status'];
      updDt = map['updDt'];
  }
}