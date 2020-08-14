import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/database/dbHelper.dart';
class Reviews extends StatefulWidget{

  @override
  _ReviewsState createState()=> _ReviewsState();
}

class _ReviewsState extends State<Reviews>{
  var dbHelper;

  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:WillPopScope(child: 
      Column(
        children: [

        ],
      )
      , onWillPop: ()async => false)
    );
  }

}