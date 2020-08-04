import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-commons.dart';
import 'package:food_delivery_ui_challenge/common/food-appbar.dart';
import 'package:food_delivery_ui_challenge/database/dbHelper.dart';
import 'package:food_delivery_ui_challenge/model/favorite.dart';
import 'package:food_delivery_ui_challenge/model/food-order.dart';
import 'package:food_delivery_ui_challenge/model/restaurant-menu.dart';
import 'package:food_delivery_ui_challenge/model/user.dart';
// ignore: must_be_immutable
class Restaurant extends StatefulWidget{
  final String title;
  final String tag;
  final String image;
  final User user;
  final int resId;
  
  
  Restaurant({
    Key key,
    @required this.title,
    @required this.tag,
    @required this.image,
    @required this.user,
     @required this.resId
  });
  
  @override
  _RestaurantState createState() => _RestaurantState();
}
class _RestaurantState extends State<Restaurant>{
 bool search = false;
 
 final scaffoldKey = GlobalKey<ScaffoldState>();
  var dbHelper;
Future<List<RestaurantMenu>>getRestaurantMenuByResId;
 bool existInd = false;
 List<String> foodExist = [];
  @override
    void initState(){
      super.initState();
      dbHelper = DBHelper();
      getRestaurantMenuByResId = dbHelper.getRestaurantMenuByResId(widget.resId);
    }
 
 
  @override
  Widget build(BuildContext context) {

 

    return Scaffold(
      backgroundColor: AppCommons.white,
      body:WillPopScope(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          FoodAppBar(isMainScreen: false,name: widget.title,tag: widget.tag,image: widget.image,user: widget.user,),
         Expanded(
           child: Column(
             children: <Widget>[
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   child: Hero(tag: widget.tag, child: Image.asset(widget.image,fit: BoxFit.fitWidth,)),
              // ),
           Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left:10,top:20, bottom:20),
              child:Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border:Border.all( color:AppCommons.appColor,),
                  borderRadius:BorderRadius.only(topLeft:Radius.circular(50),bottomLeft:Radius.circular(50))
                ),
                child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                     Container(
                       decoration: BoxDecoration(
                         border:Border.all(color:AppCommons.appColor),
                         borderRadius: BorderRadius.circular(50)
                       ),
                       child:  Icon(Icons.restaurant_menu, color:AppCommons.appColor),
                     ),
                    SizedBox(width: 20,),
                    Text(widget.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                       color:AppCommons.appColor
                    ),
                  ),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Icons.pin_drop, color:AppCommons.appColor),
                      Text("Restaurant Location",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                           color:AppCommons.appColor
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Icons.timer, color:AppCommons.appColor),
                      Text("35-45 Mins",
                      style: TextStyle(
                      fontWeight: FontWeight.bold,
                       color:AppCommons.appColor
                     ),
                      )
                    ],
                  ),
                  )
                ],
              ),
              )
            ),
          ),
          Expanded(
            child:Container(
               height: MediaQuery.of(context).size.height,
               width: MediaQuery.of(context).size.width,
               child: Padding(
                 padding: const EdgeInsets.only(top:5),
                  child: FutureBuilder<List<RestaurantMenu>>(
                  future: getRestaurantMenuByResId,
                  builder: (context, snapshot){
                    if(snapshot.connectionState != ConnectionState.done){

                    }
                    if(snapshot.hasError){
                      print("ERROR!!");
                      print(snapshot.hasError);
                    }
                    List<RestaurantMenu> restaurantList = snapshot.data ??[];
                    return ListView.builder(
                      itemCount: restaurantList.length,
                      itemBuilder: (context, index){
                        RestaurantMenu res  = restaurantList[index];
                        
                        return  foodMenu(index,res.name,res.imagePath,res.price,existInd);
                      }
                    );
                  },
               ),
               ),
            ) ,
          )
             ],
           ),
         )
        ],
      ),
       onWillPop: ()async=>false),
       
    );
  }
  Widget foodMenu(int index,String name,String image, double price, bool isExist)=> Padding(
    padding: const EdgeInsets.only(top:10,left:10,right: 10),
    child: Container(
            height: 160,
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              border: Border.all(width:2,color:AppCommons.appColor),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(topRight:Radius.circular(20),bottomRight: Radius.circular(20)),
                  child: Image.asset(image,width: 180,fit: BoxFit.fitHeight,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:20),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(name,
                      style: TextStyle(
                        fontSize:24,
                        color: AppCommons.appColor,
                         fontWeight: FontWeight.bold
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Icon(Icons.star,size: 16,),
                        Text("4.2"),
                        SizedBox(width:10),
                        Text("78 Reviews",
                          style:TextStyle(
                            fontWeight:FontWeight.w400
                          )
                        )
                      ],
                    ),
                    Align(
                      alignment:Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top:10,),
                        child: Text("P "+price.toString()),
                      ),
                    ),
                  Expanded(
                    child:  Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                        GestureDetector(
                          onTap:(){
                            FoodOrder basket = 
                            FoodOrder(id: null, userId: widget.user.id, restaurantMenuId: index, quantity: 1);
                            Future<bool> isFoodExist = dbHelper.checkFoodIfExist( widget.user.id,index);
                            isFoodExist.then((value){
                                print(value);
                                if(!value){
                                    dbHelper.createFoodOrder(basket);
                                }
                                
                            }).catchError((onError){
                              print(onError);
                            });
                          },
                          child:Container(
                            width: 110,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border:Border.all(color:AppCommons.appColor),
                            ),
                            child: Center(
                              child: Text(isExist?"Remove to Basket":"Add to Basket",
                                style: TextStyle(
                                  fontWeight:FontWeight.bold,
                                  color:AppCommons.appColor
                                ),
                              ),
                            ),
                          )
                        ),
                   
                    IconButton(
                      icon: Icon(Icons.favorite_border,color:Colors.red), onPressed: (){
                    // 
                    }),
                   
                     ],
                   ),
                  )
                  ],
                ),
                ),
                SizedBox(width:5)
              ],
            ),
          ),
  );
    
}