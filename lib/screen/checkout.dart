import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-commons.dart';
import 'package:food_delivery_ui_challenge/main.dart';

class Checkout extends StatefulWidget{
  @override
  _CheckoutState createState()=> _CheckoutState();
}
class _CheckoutState extends State<Checkout>{
  String status = "Looking for your driver..";
  bool isPrepare = false;
  bool gotOrder = false;
  void initState(){
    super.initState();
      Future.delayed(Duration(seconds:3),(){
          setState(() {
            status = "Preparing for your food...";
            isPrepare = true;
          });
          if(isPrepare){
            Future.delayed(Duration(seconds: 5),(){
              setState(() {
                status = "Your order is on the way...";
                gotOrder = true;
              });
              if(gotOrder){
                Future.delayed(Duration(seconds: 3),(){
                    Navigator.pop(context);
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
         child: Center(
           child: Text(status,
            style:TextStyle(
              color: AppCommons.white,
              fontWeight: FontWeight.bold,
              fontSize: 22
            ) 
          ),
         ),
      ),
    );
  }
  
}