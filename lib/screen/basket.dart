import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-commons.dart';
import 'package:food_delivery_ui_challenge/common/app-widgets.dart';
import 'package:food_delivery_ui_challenge/database/dbHelper.dart';
import 'package:food_delivery_ui_challenge/model/food-order.dart';
import 'package:food_delivery_ui_challenge/model/restaurant-menu.dart';
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
    List<String> menuName;
 Future<List<FoodOrder>> foodOrderedList;
 
  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
    orderedCount = dbHelper.orderedCount(widget.user.id);
    favoriteCount = dbHelper.favoriteCount(widget.user.id);
    setState(() {
      foodOrderedList = dbHelper.orderedFoodByUserId(widget.user.id);
    });
  
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
    Future.delayed(Duration(seconds: 5),(){
      setState(() {
        isReloaded =  true;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    void refreshCountsAndBasketContainer(){
      if(!isReloaded){
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
        setState(() {
           foodOrderedList = dbHelper.orderedFoodByUserId(widget.user.id);
        });
      }
   
  }
   //Future<RestaurantMenu>getFoodDetailsByResId = dbHelper.getFoodDetailsByResId(orderDetails.resId);
  myBasketList( FoodOrder orderDetails, int index){
    print("index");
    print(index);
    
    return Container(
        height: 30,
        decoration: BoxDecoration(
          color:AppCommons.appColor,
        ),
        child:Padding(
          padding: const EdgeInsets.only(left:10, right:10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(menuName[index]),
              Text(orderDetails.quantity.toString()),
                Text(orderDetails.quantity.toString()),
                                          
            ],
          ),
        )
      );
      
  }
  
    refreshCountsAndBasketContainer();
    return Scaffold(
      body: WillPopScope(child: Column(
        children:[
          //*APP BAR
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
            ),
          //*APP BAR end
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.only(left:20),
                     child: Align(
                     alignment: Alignment.centerLeft,
                     child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.shopping_basket,
                        color:AppCommons.appColor
                      ),
                      SizedBox(width: 10,),
                      Text("My Basket",
                    style:TextStyle(
                      color:AppCommons.appColor,
                      fontSize:26,
                      fontWeight:FontWeight.bold
                    )
                  ),
                    ],
                  ),
                   ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(left:10, right:10),
                     child: Container(
                     height: 40,
                     decoration: BoxDecoration(
                       border: Border.all(color:AppCommons.appColor),
                       borderRadius: BorderRadius.circular(20)
                     ),
                     child: Padding(
                       padding: const EdgeInsets.only(left:10, right:10),
                       child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: <Widget>[
                         Text("Menu",
                            style:TextStyle(
                              fontWeight:FontWeight.bold
                            )
                         ),
                         Text("Quantity",
                            style:TextStyle(
                              fontWeight:FontWeight.bold
                            )),
                         Text("Total",
                            style:TextStyle(
                              fontWeight:FontWeight.bold
                            )),
                       ],
                     ),
                     )
                   ),
                   ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left:10, right:10),
                      child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child:FutureBuilder<List<FoodOrder>>(
                        future:foodOrderedList,
                        builder: (context, snapshot){
                           if(snapshot.connectionState != ConnectionState.done){

                            }
                            if(snapshot.hasError){
                              print("ERROR!!");
                              print(snapshot.hasError);
                            }
                            
                        List<FoodOrder> orderedList = snapshot.data ?? [];
                        return ListView.builder(
                          itemCount: orderedList.length,
                          itemBuilder: (context, index){
                              FoodOrder orderDetails = orderedList[index];
                               
                              return myBasketList(orderDetails,index);
                          }
                        );
                        },
                      )
                    ),
                    )
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap:(){},
                     child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                         color: AppCommons.appColor,
                        borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight:Radius.circular(30))   
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.check, color:AppCommons.white),
                          SizedBox(width:10),
                          Text("Proceed to Checkout",
                              style:TextStyle(
                                color:AppCommons.white,
                                fontWeight: FontWeight.bold,
                                 fontSize: 18
                              )
                          )
                        ],
                      ),
                    ),
                  )
                    
                ],
              ),
            ),
          )
            
         
        ]
      ), onWillPop: ()async=>false),
    );
  }
  
}