import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-commons.dart';
import 'package:food_delivery_ui_challenge/common/app-widgets.dart';
import 'package:food_delivery_ui_challenge/database/dbHelper.dart';
import 'package:food_delivery_ui_challenge/model/user.dart';

class Favorites extends StatefulWidget{
  final User user;

  Favorites({
    Key key,
    @required this.user
  });
  @override
  _FavoritesState createState()=>_FavoritesState();

}
class _FavoritesState extends State<Favorites>{
    Future<int> orderedCount;
      int basketCount = 0;
      var dbHelper;
      bool isReady = false;

      @override
      void initState(){
        super.initState();
        dbHelper = DBHelper();
           WidgetsBinding.instance
        .addPostFrameCallback((_){
          orderedCount = dbHelper.orderedCount(widget.user.id);
              orderedCount.then((value){
                basketCount = value;
              });
        });
        Future.delayed(Duration(seconds: 2),(){
            setState(() {
              isReady = true;
            });
        });
      }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body:WillPopScope(child: Column(
       children: [
         isReady?AppWidgets().foodAppBar(context, false,basketCount,0,widget.user,"RESTAURANT",null): Container(
              decoration: BoxDecoration(
                color:AppCommons.appColor
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.favorite,
                        color:AppCommons.white
                      ),
                      SizedBox(width: 10,),
                      Text("Please wait...",
                    style:TextStyle(
                      color:AppCommons.white,
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
            ),
         Expanded(
           child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite, color:Colors.red),
                  SizedBox(width: 10,),
                   Text("Favorites section",
                  style:TextStyle(
                    color: AppCommons.appColor,
                    fontWeight: FontWeight.bold,
                  )    
                )
             
                ],
              )
           ),
         )   
       ],
     ),
      onWillPop: ()async=>false)
   );
  }
}