import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-commons.dart';
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
    WidgetsBinding.instance
        .addPostFrameCallback((_) => dbHelper.updateNotifStatusByUserId(widget.user.id));
 
  }
  @override
  Widget build(BuildContext context) {
     return Column(
       children: <Widget>[
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width - 60,
                decoration: BoxDecoration(
                  color:AppCommons.appColor,
                  borderRadius: BorderRadius.only(topRight:Radius.circular(50),bottomRight:Radius.circular(50))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left:20),
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                 Container(
                   decoration:BoxDecoration(
                     color:AppCommons.white,
                     borderRadius: BorderRadius.circular(50)
                   ),
                   child:  Icon(Icons.notifications, color:AppCommons.appColor),
                 ),
                  SizedBox(width: 20,),
                  Text("Notifications",
                  style: TextStyle(
                     color:AppCommons.white,
                    fontWeight: FontWeight.bold,
                    fontSize:22
                  ),
                  ),
                    SizedBox(width: 20,),
                    
                ],
              ),
                )
              )
          ),
       ],
     );
  }
    
}