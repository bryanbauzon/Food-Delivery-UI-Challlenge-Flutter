import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/database/dbHelper.dart';
import 'package:food_delivery_ui_challenge/model/user.dart';

class NotificationScreen extends StatefulWidget{

  final User user;
  NotificationScreen({
    Key key,
    @required this.user
  });
    @override
    _NotificationState createState() => _NotificationState();


}
class _NotificationState extends State<NotificationScreen>{

  var dbHelper;

  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
 dbHelper.updateNotifStatusByUserId(widget.user.id);
  }
  @override
  Widget build(BuildContext context) {
     return Column(
       children: <Widget>[

       ],
     );
  }
    
}