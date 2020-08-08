import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-widgets.dart';
import 'package:food_delivery_ui_challenge/database/dbHelper.dart';
import 'package:food_delivery_ui_challenge/model/user.dart';
import 'package:food_delivery_ui_challenge/screen/homepage.dart';

class Init extends StatefulWidget{

  final String title;
  final User user;

  Init({
    Key key,
    @required this.title,
    @required this.user
  });
  
    @override
    _InitState createState()=>_InitState();
}
class _InitState extends State<Init>{
  static String title;
  static User user;
  int basketCount = 0;
  int favCount = 0;
  Future<int> orderedCount;
  Future<int> favoriteCount;
  var dbHelper;

  @override
  void initState(){
      super.initState();
      title = widget.title;
      user = widget.user;
      dbHelper = DBHelper();
      orderedCount = dbHelper.orderedCount(widget.user.id);
      orderedCount.then((value){
        basketCount = value;
      });
      favoriteCount = dbHelper.favoriteCount(widget.user.id);
      favoriteCount.then((value){
        favCount = value;
      });
      print("BASKET COUNT = ");
      print(basketCount);
      print("FAVORITE COUNT = ");
      print(favCount);
  }

  List<Widget> _widgetOptions = <Widget>[
    HomePage(title: title,user: user,),
  ];

  @override
  Widget build(BuildContext context) {
   return WillPopScope(
     child: Scaffold(
       body: Column(
         children: <Widget>[
              AppWidgets().foodAppBar(context, true,basketCount,favCount,widget.user),
         ],
       ),
     ),
     onWillPop: ()async =>false);
  }
  
}