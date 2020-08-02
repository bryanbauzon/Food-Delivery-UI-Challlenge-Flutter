import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-commons.dart';
import 'package:food_delivery_ui_challenge/screen/homepage.dart';

class Splash extends StatefulWidget{
  @override
  _SplashState createState() => _SplashState();
}
class _SplashState extends State<Splash>{

  void initState(){
    super.initState();
      Future.delayed(Duration(seconds:8),(){
        Navigator.push(context, 
          MaterialPageRoute(builder: (context)=>HomePage(title: AppCommons.appName,basketCount: 0,orders: [],))
        );
      });
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
     // backgroundColor:ExpenseTrackerCommons.appColor ,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppCommons.appColor
        ),
        child: Center(
        child: Text(
            AppCommons.appName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppCommons.white,
              fontSize: 22
            ),
        ),
      ),
      ),
    );
  }

}