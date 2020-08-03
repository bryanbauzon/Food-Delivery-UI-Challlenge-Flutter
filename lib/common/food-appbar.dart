import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-commons.dart';
import 'package:food_delivery_ui_challenge/model/favorite.dart';
import 'package:food_delivery_ui_challenge/model/food-order.dart';
import 'package:food_delivery_ui_challenge/screen/checkout.dart';
import 'package:food_delivery_ui_challenge/screen/homepage.dart';
import 'package:food_delivery_ui_challenge/screen/restaurant.dart';
// ignore: must_be_immutable
class FoodAppBar extends StatefulWidget{

  final bool isMainScreen;
   int basketCount;
   int favoriteCount;
   List<Favorite> favorites;
   List<FoodOrder> orders;
   List<int>indexBasketList = [];
   final String name;
   final String tag;
   final String image;
   double total;
  FoodAppBar({
    Key key,
    @required this.isMainScreen,
    @required this.basketCount,
    @required this.orders,
    @required this.favorites,
    @required this.favoriteCount,
    @required this.total,
     this.name,
     this.tag,
     this.image
  });

  @override
  _FoodAppBarState createState()=>_FoodAppBarState();
}
class _FoodAppBarState extends State<FoodAppBar>{
  bool search = false;
  bool isCheckout = false;
  

     
  @override
  Widget build(BuildContext context) {
    
 Widget favoriteContainer = Container(
  height: 420,
   decoration:BoxDecoration(color: AppCommons.white),
   child: Column(
     children: <Widget>[
              Padding(
         padding: const EdgeInsets.only(top:20, left:20),
         child:Row(
         children: <Widget>[
           Badge(
             badgeContent: Text(widget.favorites.length.toString(), style: TextStyle(color:AppCommons.white),),
             child: Icon(Icons.favorite, color:Colors.red),
           ),
           SizedBox(width: 20,),
           Text(widget.favorites.length > 1?"My Favorites":"My Favorite",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),
           ),
          
           
         ],
       ),
       ),
        Container(
              height: 260,
              child: ListView.builder(
                itemCount: widget.favorites.length,
               itemBuilder: (BuildContext context, int index){
          Favorite orders = widget.favorites[index];
            return Padding(
              padding: const EdgeInsets.only(left:20, top:20),
              child:Align(
                alignment: Alignment.centerLeft,
                child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(orders.name,
                        style: TextStyle(color:AppCommons.appColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22
                        ),
                      ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right:20),
                        child:  Text(orders.price.toString()),
                      )
                    ],
                  ),
                  
                ],
              ),
              )
            );
               }
            )
           ),
              Padding(
       padding: const EdgeInsets.only(top:20, left:20, right:20),
       child:  GestureDetector(
        onTap:(){
            Navigator.pop(context);
        },
        child:Container(
          height:50,
          decoration:BoxDecoration(
           color:AppCommons.appColor,
           borderRadius: BorderRadius.circular(50)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.close, color:AppCommons.white),
              Text("Close",
                style:TextStyle(
                  color: AppCommons.white,
                  fontWeight: FontWeight.bold
                )
              )
            ],
          )
        )
      ),
     )
     ],
   ),

 );
  Widget basketContainer=Container(
   height: 420,
   decoration:BoxDecoration(color: AppCommons.white),
   child:  Column(
     children: <Widget>[
       Padding(
         padding: const EdgeInsets.only(top:20, left:20),
         child:Row(
         children: <Widget>[
           Badge(
             badgeContent: Text(widget.basketCount.toString(), style: TextStyle(color:AppCommons.white),),
             child: Icon(Icons.shopping_basket, color:AppCommons.appColor),
           ),
           SizedBox(width: 20,),
           Text("My Basket",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),
           )
           
         ],
       ),
       ),
       Container(
         height: 260,
        child: ListView.builder(
         itemCount: widget.orders.length,
         itemBuilder: (BuildContext context, int index){
           FoodOrder orders = widget.orders[index];
            return Padding(
              padding: const EdgeInsets.only(left:20, top:20),
              child:Align(
                alignment: Alignment.centerLeft,
                child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("",
                        style: TextStyle(color:AppCommons.appColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22
                        ),
                      ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right:20),
                        child:  Text(""),
                      )
                    ],
                  ),
                  
                ],
              ),
              )
            );
         }
        ),
       ),
      Padding(
        padding: const EdgeInsets.only(right:20,top:10),
        child:  Align(
        alignment: Alignment.centerRight,
         child: Row(
           mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
             Text("Total Amount: ",
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
             ),
              Text(widget.total.toString())
            ],
            ),
       ),
      ),

     Padding(
       padding: const EdgeInsets.only(top:20, left:20, right:20),
       child:  GestureDetector(
        onTap:(){
          setState(() {
              widget.orders.clear();
              widget.orders.clear();
               isCheckout = true;
               widget.basketCount = 0;
             if(widget.indexBasketList.isNotEmpty){
              widget.indexBasketList.clear();
             } 
            
          });
             
          if(isCheckout){
            if(widget.isMainScreen){
              Navigator.push(context, MaterialPageRoute(builder: (_)=> HomePage(title: AppCommons.appName,basketCount: 0,orders: widget.orders,favoriteCount: widget.favoriteCount,favorites: widget.favorites,total: widget.total,)));
            }else{
              Navigator.push(context, MaterialPageRoute(builder: (_)=>Restaurant(title:widget.name,tag:widget.tag,image: widget.image,orders: widget.orders,favs: widget.favorites,)));
            }
           
          }
          Navigator.push(context, MaterialPageRoute(builder: (_)=>Checkout()));
        },
        child:Container(
          height:50,
          decoration:BoxDecoration(
           color:AppCommons.appColor,
           borderRadius: BorderRadius.circular(50)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.check, color:AppCommons.white),
              Text(!isCheckout?"Proceed to checkout":"Go back to menu",
                style:TextStyle(
                  color: AppCommons.white,
                  fontWeight: FontWeight.bold
                )
              )
            ],
          )
        )
      ),
     )
     ],
   ) 
 );
    return SafeArea(
      child: Container(
      width: MediaQuery.of(context).size.width,
      height: 120,
      decoration: BoxDecoration(
        color: AppCommons.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom:20,right:10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
            height: 40,
            width: MediaQuery.of(context).size.width - 120,
          decoration: BoxDecoration(
                  color: AppCommons.appColor,
                  borderRadius: BorderRadius.only(topRight:Radius.circular(20),bottomRight: Radius.circular(20)),
                ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: Padding(
                  padding: const EdgeInsets.only(left:20),
                  child: Center(
                  child: widget.isMainScreen?Icon(Icons.short_text, color:AppCommons.white):
                  IconButton(
                    icon:Icon(Icons.arrow_back, color:AppCommons.white),
                    onPressed: (){
                      Navigator.push(
                        context,MaterialPageRoute(builder: (_)=>HomePage(title: AppCommons.appName,basketCount: widget.basketCount,orders: widget.orders,favoriteCount: widget.favoriteCount,favorites: widget.favorites,total: widget.total,))
                      );
                    },
                  ),
                ),
                ),
                ),
                SizedBox(width: 30,),
                Text(AppCommons.appName,
                  style: TextStyle(color: AppCommons.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
                ),
                 
           
              ],
            ),
          ),
            GestureDetector(
                onTap:(){
                  if(widget.favorites.length > 0){
                    showModalBottomSheet(
                      context: context,
                      useRootNavigator: true,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 10,
                      builder: (builder)=>favoriteContainer
                    );
                  }
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppCommons.white,
                    border:Border.all(color: AppCommons.appColor),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Badge(
                  badgeContent: Text(widget.favoriteCount.toString(), style:TextStyle(color:AppCommons.white)),
                  child: Icon(Icons.favorite,color:Colors.red),
                ),
                )
              ),
               GestureDetector(
                onTap:(){
                  if(widget.basketCount > 0){
                    showModalBottomSheet(
                                    context: context,
                                    useRootNavigator: true,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    elevation: 10,
                                    builder: (builder)=>basketContainer
                    );
                  }
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppCommons.white,
                    border:Border.all(color: AppCommons.appColor),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Badge(
                  badgeContent: Text(widget.basketCount.toString(), style:TextStyle(color:AppCommons.white)),
                  child: Icon(Icons.shopping_basket,color:AppCommons.appColor),
                ),
                )
              ),
          ],
              )
            ),
          ),
           
           Align(
              alignment: Alignment.centerLeft,
              child:  Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.pin_drop,color:AppCommons.pinDrop), 
                          onPressed: (){
                            if(search){
                              setState(() {
                               search = false;
                              });
                            }
                          }),
                          Visibility(child: Container(
                            height: 60,
                            width: 250,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Deliver to",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                    ),
                                  ),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: <Widget>[
                                       Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("#306 Maramba St., Tondol, Anda, Pangasinan",
                                              softWrap: true,
                                              style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                            ),
                                        ),
                                      ),
                                      Icon(Icons.arrow_drop_down)
                                     ],
                                   )
                              ],
                            ),
                          ),
                          visible: (search)?false:true,
                          )
                        ],
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                           Visibility(child: Expanded(
                             child:  IconButton(icon: Icon(Icons.search,color:AppCommons.searchIcon), onPressed: (){
                              setState(() {
                                search = !(search);
                              });
                            })
                           ),
                           visible: (search)?false:true,
                           ),
                           Visibility(
                             child:Container(
                               width: 320,
                               height: 70,
                               child: Center(
                                 child: TextFormField(
                                   cursorColor: AppCommons.appColor,
                                   style: TextStyle(
                                     color: AppCommons.appColor,
                                    // fontWeight: FontWeight.bold
                                   ),
                                   decoration: InputDecoration(
                                     hintText: "ex. Chicken, Pasta...",
                                     prefixIcon:Icon(Icons.search,color: AppCommons.appColor,),
                                     enabledBorder: OutlineInputBorder(
                                      //  borderSide: BorderSide(
                                      //    color: AppCommons.searchIcon
                                      //  ),
                                       borderRadius: BorderRadius.circular(50)
                                     ),
                                    focusedBorder: OutlineInputBorder(
                                       borderSide: BorderSide(
                                         color: AppCommons.appColor
                                       ),
                                       borderRadius: BorderRadius.circular(50)
                                     )
                                   ),
                                 ),
                               ),
                             ),
                             visible: (search)?true:false,
                           )
                          ],
                        )
                      )
                    ],
                  ),
                ),
            )
        ],
      ),
      )
    );
  }

}