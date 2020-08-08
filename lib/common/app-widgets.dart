import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-commons.dart';
import 'package:food_delivery_ui_challenge/model/user.dart';
import 'package:food_delivery_ui_challenge/screen/init.dart';

class AppWidgets{
  AppWidgets();
  Widget foodAppBar(BuildContext context, bool isMainScreen, int basketCount, int favCount,User user, String prevScreen)=>
  SafeArea(
    child: Container(
      height: 80,
      child:Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:20),
            child:     Row(
            children: <Widget>[
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width - 120,
                decoration: BoxDecoration(
                  color: AppCommons.appColor,
                  borderRadius: BorderRadius.only(topRight:Radius.circular(50), bottomRight:Radius.circular(50))
                ),
                child: Row(
                  children: <Widget>[
                    IconButton(icon: Icon(isMainScreen?Icons.short_text:Icons.home,color:AppCommons.white),
                     onPressed:(){
                        Navigator.push(context, 
                            MaterialPageRoute(builder: (_)=>Init(title: AppCommons.appName,user: user,))
                        );
                     } ),
                     Text(AppCommons.appName,
                      style: TextStyle(
                        color:AppCommons.white,
                        fontWeight:FontWeight.bold,
                        fontSize:22
                      ),
                     )
                  ],
                ),
              ),
              basketCount > 0?
              Badge(
                badgeContent: Text(basketCount.toString(),
                  style:TextStyle(
                    color:AppCommons.white
                  )
                ),
                child: IconButton(icon: Icon(Icons.shopping_basket,
                  color:AppCommons.appColor
                ), onPressed: null),
              ):Icon(Icons.shopping_basket,
                  color:AppCommons.appColor
                ),
                favCount > 0?
              Badge(
                badgeContent: Text(favCount.toString(),
                  style:TextStyle(
                    color:AppCommons.white
                  )
                ),
                child: IconButton(icon: Icon(Icons.favorite,
                  color:Colors.red
                ), onPressed: null),
              ):Icon(Icons.favorite,
                  color:Colors.red
                )
            ],
          ),
          )
        ],
      )
    )
  );
}