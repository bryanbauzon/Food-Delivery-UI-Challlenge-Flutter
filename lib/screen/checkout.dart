import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-commons.dart';
import 'package:food_delivery_ui_challenge/model/user.dart';
import 'package:food_delivery_ui_challenge/screen/init.dart';

class Checkout extends StatefulWidget{
  final User user;

  Checkout({
    Key key,
    @required this.user
  });

  @override
  _CheckoutState createState()=> _CheckoutState();
}
class _CheckoutState extends State<Checkout>{
  String status = "Looking for your driver..";
  bool isPrepare = false;
  bool gotOrder = false;
  IconData icData;
  void initState(){
    super.initState();
     icData = Icons.search;
      Future.delayed(Duration(seconds:3),(){
          setState(() {
            status = "Preparing for your food...";
            isPrepare = true;
            icData = Icons.timer;
          });
          if(isPrepare){
            Future.delayed(Duration(seconds: 5),(){
              setState(() {
                status = "The driver is on the way...";
                gotOrder = true;
                icData = Icons.motorcycle;
              });
              if(gotOrder){
                Future.delayed(Duration(seconds: 3),(){
                    Navigator.push(context, 
                          MaterialPageRoute(builder: (_)=>Init(title: AppCommons.appName,user: widget.user,))
                        );
                });
              }
            });
          }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
         color:AppCommons.appColor
        ),
         child:Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(50),
                color:AppCommons.white
              ),
              child:  Icon(icData, color:AppCommons.appColor),
            ),
            SizedBox(
              height: 20,
            ),
             Text(status,
            style:TextStyle(
              color: AppCommons.white,
              fontWeight: FontWeight.bold,
              fontSize: 26
            ) 
          ),
           ],
         )
      ),
    );
  }
  
}