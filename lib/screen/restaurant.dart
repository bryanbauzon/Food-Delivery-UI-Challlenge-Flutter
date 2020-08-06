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
  final int basketCount;
  
  
  Restaurant({
    Key key,
    @required this.title,
    @required this.tag,
    @required this.image,
    @required this.user,
     @required this.resId,
     @required this.basketCount,
 
  });
  
  @override
  _RestaurantState createState() => _RestaurantState();
}
class _RestaurantState extends State<Restaurant>{
 bool search = false;
   int basketCount = 0;
 final scaffoldKey = GlobalKey<ScaffoldState>();
  var dbHelper;
 Future<List<RestaurantMenu>>getRestaurantMenuByResId;
 bool existInd = false;
 Future<List<FoodOrder>> foodOrderedList;
 
 List<int>foodOrderIndex = [];
 List<int>favoriteIndex = [];
             Future<bool>checkIfFavoriteExist;
              Future<bool> isFoodExist;
               Future<int>orderedCount;
  @override
    void initState(){
      super.initState();
      dbHelper = DBHelper();
      
    //  foodOrderIndex
   
        basketCount = widget.basketCount;
     
      setState(() {
        
          foodOrderedList = dbHelper.orderedFoodByUserId(widget.user.id);
          getRestaurantMenuByResId = dbHelper.getRestaurantMenuByResId(widget.resId);
         foodOrderedList.then((value){
            for(FoodOrder ordered in value){
              foodOrderIndex.add(ordered.id);
              print(ordered.id);
            }
         });
         
      });
      print(foodOrderIndex);
  }
 
 
 
  @override
  Widget build(BuildContext context) {
 
   
    return Scaffold(
      backgroundColor: AppCommons.white,
      body:WillPopScope(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          FoodAppBar(isMainScreen: false,name: widget.title,tag: widget.tag,image: widget.image,user: widget.user,basketCount: basketCount,),
         Expanded(
           child: Column(
             children: <Widget>[
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
                    return GridView.count(
                      crossAxisCount: 2,
                     children:List.generate(restaurantList.length, (index){
                       RestaurantMenu menus = restaurantList[index];
                       return Padding(
                         padding: const EdgeInsets.all(5),
                         child: Container(
                         height: 150,
                         decoration: BoxDecoration(
                           border: Border.all(color:AppCommons.appColor),
                           borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20),bottomRight:Radius.circular(20))
                         ),
                         child: Column(
                           children: <Widget>[
                             Padding(
                               padding: const EdgeInsets.all(6),
                               child: Stack(
                                 overflow: Overflow.clip,
                                 children: <Widget>[
                                   Container(
                                     height: 130,
                                     child: Align(
                                       alignment: Alignment.bottomCenter,
                                       child:Padding(
                                         padding: const EdgeInsets.only(left:10, right:10),
                                         child: Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text(menus.name,
                                                    style: TextStyle(
                                                      color:AppCommons.appColor,
                                                      fontWeight:FontWeight.bold
                                                    ),
                                                ),
                                                Text("P "+menus.price.toString(),
                                                    style: TextStyle(
                                                      fontWeight:FontWeight.bold
                                                    ),
                                                )
                                              ],
                                            ),
                                       )
                                     ),
                                   ),
                                     Image.asset(menus.imagePath,fit: BoxFit.fill,),
                                   Padding(
                                     padding: const EdgeInsets.only(top:10),
                                     child: Container(
                                       height: 20,
                                       width: 70,
                                       decoration:BoxDecoration(
                                       //  border: Border.all(color:AppCommons.appColor),
                                         color: AppCommons.white,
                                         borderRadius:BorderRadius.only(topRight:Radius.circular(20),bottomRight:Radius.circular(20))
                                       ),
                                       child:Center(
                                         child:  Text(menus.id.toString(),
                                          style: TextStyle(
                                            color:AppCommons.appColor,
                                            fontWeight: FontWeight.bold
                                          ),
                                       ),
                                       )
                                     ),
                                   )
                                 ],
                               )
                             ),
                             
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: IconButton(icon: Icon(Icons.shopping_basket,
                                    color:foodOrderIndex.contains(menus.id)?AppCommons.appColor:AppCommons.grey),
                                     onPressed: (){
                                        FoodOrder basket = 
                                              FoodOrder(id: null, userId: widget.user.id, restaurantMenuId: menus.id,resId: widget.resId, quantity: 1);
                                               isFoodExist = dbHelper.checkFoodIfExist( widget.user.id,menus.id);
                                              isFoodExist.then((value){
                                                  print(value);
                                                  if(!value){
                                                     setState(() {
                                                        isFoodExist = dbHelper.checkFoodIfExist( widget.user.id,menus.id);
                                                       dbHelper.createFoodOrder(basket);
                                                       foodOrderIndex.add(menus.id);
                                                      orderedCount = dbHelper.orderedCount(widget.user.id);
                                                       orderedCount.then((value){
                                                          basketCount = value;
                                                       });
                                                     });
                                                  }else{
                                                    setState(() {
                                                      dbHelper.removeFoodOrder(widget.user.id,menus.id);
                                                      foodOrderIndex.removeWhere((element) => element == menus.id);
                                                      orderedCount = dbHelper.orderedCount(widget.user.id);
                                                       orderedCount.then((value){
                                                          basketCount = value;
                                                       });
                                                    });
                                                  }
                                                  
                                              }).catchError((onError){
                                                print(onError);
                                              });
                                     }),
                                  ),
                                  Container(
                                    child: IconButton(icon: Icon(favoriteIndex.contains(menus.id)?Icons.favorite:Icons.favorite_border,color:Colors.red),
                                     onPressed: (){
                                       Favorite fav= Favorite(
                                                  id: null,
                                                  userId: widget.user.id,
                                                  name: menus.name,
                                                  price: menus.price
                                                );
                              Future<bool>checkIfFavoriteExist = dbHelper.checkIfFavoriteExist(menus.id);
                              checkIfFavoriteExist.then((value){
                                print(value);
                                print(menus.id);
                                  if(!value){
                                    
                                      setState(() {
                                          dbHelper.addToFavorite(fav);
                                        favoriteIndex.add(menus.id);
                                      });
                                  }
                              });
                                        
                                     }),
                                  )
                                ],
                              )
                           ],
                         ),
                       ),
                       );
                     })
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
  
}