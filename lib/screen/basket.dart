import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-commons.dart';
import 'package:food_delivery_ui_challenge/common/app-widgets.dart';
import 'package:food_delivery_ui_challenge/database/dbHelper.dart';
import 'package:food_delivery_ui_challenge/model/user.dart';

class Basket extends StatefulWidget{
  final User user;

  Basket({
    Key key,
    @required this.user
  });
  
  @override
  _BasketState createState() => _BasketState();
}
class _BasketState extends State<Basket>{
  var dbHelper;
  int basketCount;
  int favCount;
  Future<int> orderedCount;
  Future<int> favoriteCount;
  bool isReloaded = false;

  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
    orderedCount = dbHelper.orderedCount(widget.user.id);
    favoriteCount = dbHelper.favoriteCount(widget.user.id);
  
    orderedCount.then((value){
       setState(() {
         basketCount = value;
       });
    });
    favoriteCount.then((value){
      setState(() {
        favCount = value;
      });
    });

    print(basketCount);
    print(favCount);
    Future.delayed(Duration(seconds: 3),(){
      setState(() {
        isReloaded =  true;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    void refreshCounts(){
      orderedCount.then((value){
      setState(() {
         basketCount = value;
      });
    });
    favoriteCount.then((value){
      setState(() {
        favCount = value;
      });
    });

      print(basketCount);
    print(favCount);
  }
    refreshCounts();
    return Scaffold(
      body: WillPopScope(child: Column(
        children:[
            isReloaded?AppWidgets().foodAppBar(context, false,basketCount,favCount,widget.user,"RESTAURANT"):
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.shopping_basket,
                        color:AppCommons.appColor
                      ),
                      SizedBox(width: 10,),
                      Text("Please wait...",
                    style:TextStyle(
                      color:AppCommons.appColor,
                      fontSize:24,
                      fontWeight:FontWeight.bold
                    )
                  ),
                    ],
                  ),
                  SizedBox(height: 20,),
                   CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(AppCommons.appColor),
                    backgroundColor: AppCommons.white,
                ),
                ],
              )
            )
            ,
         
        ]
      ), onWillPop: ()async=>false),
    );
  }
  
}