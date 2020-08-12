import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-commons.dart';
import 'package:food_delivery_ui_challenge/model/user.dart';
import 'package:food_delivery_ui_challenge/screen/basket.dart';
import 'package:food_delivery_ui_challenge/screen/init.dart';

class AppWidgets{
  AppWidgets();
  Widget foodAppBar(BuildContext context, bool isMainScreen, int basketCount, int favCount,User user, String prevScreen,GlobalKey<ScaffoldState> _scaffoldKey,)=>
  SafeArea(
    child: Container(
      height: 80,
      child:Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:20),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          if(!isMainScreen){
                            Navigator.push(context, 
                              MaterialPageRoute(builder: (_)=>Init(title: AppCommons.appName,user: user,))
                            );
                          }else{
                            _scaffoldKey.currentState.openDrawer();
                          }
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
             ( basketCount > 0)?
              Badge(
                badgeContent: Text(basketCount.toString(),
                  style:TextStyle(
                    color:AppCommons.white
                  )
                ),
                child: IconButton(icon: Icon(Icons.shopping_basket,
                  color:AppCommons.appColor
                ), onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (_)=>Basket(user: user,)));
                }),
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
                ),
                SizedBox(width:10)
            ],
          ),
          )
        ],
      )
    )
  );

 Widget foodDrawer(BuildContext context)=>
 Drawer(
   child: Container(
     height:MediaQuery.of(context).size.height,
     child:ListView(
       shrinkWrap: true,
     children:[
        DrawerHeader(
          child: Center(
            child:Text(
              AppCommons.appName,
              style:TextStyle(
                color:AppCommons.white,
                fontWeight: FontWeight.bold,
                fontSize:22
              )
            )
          ),
          decoration: BoxDecoration(
            color:AppCommons.appColor,
            borderRadius: BorderRadius.only(bottomRight:Radius.circular(50))
          ),
        ),
         ListTile(
           dense: true,
          leading:Icon(Icons.help_outline,
              color:AppCommons.appColor
          ),
          title: Text(AppCommons.about),
          onTap:(){
              showModalBottomSheet(
                            context: context,
                            useRootNavigator: true,
                             backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 10,
                            builder: (builder)=>Container(
                              height: 220,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                        Text(
                                          "Flutter #UIChallenge",
                                          style:TextStyle(
                                            color:AppCommons.flutterColor,
                                            fontWeight:FontWeight.bold
                                          )
                                        ),
                                        Text(
                                          "Theme: Food Delivery UI",
                                          style:TextStyle(
                                            color:AppCommons.appColor,
                                            fontWeight:FontWeight.bold
                                          )
                                        ),
                                        Text(
                                          "Developer: "+AppCommons.developer,
                                          style:TextStyle(
                                            color:AppCommons.grey,
                                            fontWeight:FontWeight.bold
                                          )
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Container(
                                          height: 40,
                                          width: 180,
                                          decoration: BoxDecoration(
                                            color:AppCommons.appColor,
                                            borderRadius:BorderRadius.circular(50)
                                          ),
                                          child: GestureDetector(
                                            onTap: (){
                                              Navigator.pop(context);
                                            },
                                            child: Center(
                                              child: Text("Close",
                                                style:TextStyle(
                                                  color:AppCommons.white,
                                                  fontWeight:FontWeight.bold
                                                )
                                              ),
                                            ),
                                          ),
                                        )
                                  ],
                                ),
                              ),
                            )
              );
          }
        ),
        ListTile(
           dense: true,
          leading:Icon(Icons.exit_to_app,
              color:AppCommons.appColor
          ),
          title: Text(AppCommons.signout),
        ),
        
       
     ]
   ),
   )
 ); 
}