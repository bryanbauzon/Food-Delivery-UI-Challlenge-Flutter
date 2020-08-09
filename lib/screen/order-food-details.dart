import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-commons.dart';
import 'package:food_delivery_ui_challenge/common/app-widgets.dart';
import 'package:food_delivery_ui_challenge/database/dbHelper.dart';
import 'package:food_delivery_ui_challenge/model/food-order.dart';
import 'package:food_delivery_ui_challenge/model/user.dart';
import 'package:food_delivery_ui_challenge/screen/init.dart';

class OrderFoodDetails extends StatefulWidget{
  
  final String image;
  final User user;
  final int basketCount;
   final int favCount;
  final FoodOrder order;
  final String name; 
  final double price;
  final String description;


  OrderFoodDetails({
    Key key,
    @required this.image,
    @required this.user,
     @required this.basketCount,
     @required this.favCount,
     @required this.order,
     @required this.name,
     @required this.price,
     @required this.description
  });


  @override
  _OrderFoodDetails createState()=> _OrderFoodDetails();
}
class _OrderFoodDetails extends State<OrderFoodDetails>{
  int quantity = 0;
  var dbHelper;
  double totalAmount =0;
  FoodOrder order;
  bool isAddToBasket = false;
  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper(); 
    quantity = 1;
    totalAmount = widget.price;
    order = widget.order;
  }
  @override
  Widget build(BuildContext context) {

  Widget qualityController(bool isIncrease)=>
    GestureDetector(
      onTap:(){
        print("TAPPED");
        if(isIncrease){
          setState(() {
            quantity += 1;
            totalAmount += widget.price;
          });
        }else{
          if(quantity > 0){
            setState(() {
            quantity -= 1;
             totalAmount -= widget.price;
          });
          }else if(quantity < 0){
            setState(() {
              quantity = 0;
               totalAmount = 0;
            });
          }
        }
      },
      child:Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          border:Border.all(color:AppCommons.grey),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child:Text(isIncrease?"+":"-",
            style:TextStyle(
              color:AppCommons.appColor,
              fontSize:24,
              fontWeight: FontWeight.bold
            )
          )
        ),
      )
    );
    return Scaffold(
      body:WillPopScope(child: Column(
        children: <Widget>[
           AppWidgets().foodAppBar(context, false,widget.basketCount,widget.favCount,widget.user,"RESTAURANT"),
          Image.asset(widget.image),
          Padding(
            padding: const EdgeInsets.only(top:10),
            child: Align(
              alignment: Alignment.centerLeft,
              child:Row(
                children: <Widget>[
                  Container(
                height: 40,
                width: 180,
                decoration: BoxDecoration(
                  color:AppCommons.appColor,
                  borderRadius: BorderRadius.only(topRight:Radius.circular(50),bottomRight:Radius.circular(50))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left:20,right:60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.restaurant_menu,
                        color:AppCommons.white
                      ),
                      Text(widget.name,
                        style:TextStyle(
                          color: AppCommons.white,
                          fontWeight: FontWeight.bold
                        )
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: 80,),
              Text("P "+widget.price.toString(),
                style:TextStyle(
                  color:AppCommons.appColor,
                  fontWeight:FontWeight.bold,
                  fontSize:24
                )
              )
                ],
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:40,left:20),
            child:Align(
              alignment: Alignment.centerLeft,
              child:Text(widget.description,
                style:TextStyle(
                  fontSize: 16
                )
              )
            )
          ),
         Expanded(
           child: Container(
           height:MediaQuery.of(context).size.height,
           decoration:BoxDecoration(
             border:Border.all(color: AppCommons.appColor,)
           ),
           child: Align(
             alignment: Alignment.bottomCenter,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.end,
               children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.only(bottom:20, left:20),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                   children: <Widget>[
                     qualityController(false),
                     Container(
                       height: 40,
                       width: 40,
                       child:Center(
                         child:  Text("$quantity",
                            style:TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            )
                         ),
                       ),
                     ),
                     qualityController(true),
                    SizedBox(width: 60,),
                     Text("Total Amount: $totalAmount",
                        style:TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        )
                     )
                   ],
                 ),
                 ),
                 GestureDetector(
                   onTap:(){
                     if(quantity > 0){
                        print(order.quantity);
                        setState(() {
                          order.quantity = quantity;
                          isAddToBasket = !(isAddToBasket);
                        });
                         print(order.quantity);
                         dbHelper.createFoodOrder(order);
                        Future.delayed(Duration(seconds: 3),(){
                           setState(() {
                                isAddToBasket = !(isAddToBasket);
                             });
                             Navigator.push(context,  MaterialPageRoute(builder: (_)=>Init(title: AppCommons.appName,user: widget.user,)));
                        });
                     }else{
                         Navigator.push(context,  MaterialPageRoute(builder: (_)=>Init(title: AppCommons.appName,user: widget.user,)));
                     }
                   },
                   child:Container(
                     height: 50,
                     decoration: BoxDecoration(
                       color: AppCommons.appColor,
                        borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight:Radius.circular(30))   
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        !isAddToBasket?
                        Icon((quantity > 0)?Icons.shopping_basket:Icons.home, color:AppCommons.white):
                        Container(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(AppCommons.appColor),
                          backgroundColor: AppCommons.white,
                        ),
                        ),
                        SizedBox(width: 20,),
                        Text(!isAddToBasket?(quantity > 0)?"Add to Basket":"Back to home":"Processing...",
                          style:TextStyle(
                            color:AppCommons.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          )
                        )
                      ],
                    ),
                   )
                 )
               ],
             ),
           ),
         ),
         )
        ],
      ), onWillPop: ()async => false)
    );
  }
  
}