import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-commons.dart';
import 'package:food_delivery_ui_challenge/common/food-appbar.dart';
import 'package:food_delivery_ui_challenge/model/food-order.dart';
import 'package:food_delivery_ui_challenge/screen/checkout.dart';
import 'package:food_delivery_ui_challenge/screen/restaurant.dart';

class HomePage extends StatefulWidget{ 
  final String title;
   int basketCount;
  final List<FoodOrder> orders;

  HomePage({
    Key key,
    @required this.title,
    @required this.basketCount,
    @required this.orders
  });

    @override
    _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>{
   List<int> indexList = [];
    List<FoodOrder> orderList = [];
   double total = 0;
  bool search = false;
  String bcStr = "";
  int bc = 0;
  bool isEmptyListOrder = false;
   var scaffoldKey;
   bool isCheckout = false;
  @override
  void initState(){
    super.initState();
    scaffoldKey =   GlobalKey<ScaffoldState>();
    setState(() {
      orderList = widget.orders;
      bcStr = widget.basketCount.toString();
      if(orderList.toString() == "[]"){
        isEmptyListOrder = true;
      }else{
       for(int i = 0; i < orderList.length; i++){
        FoodOrder orderTotal = orderList[i];
        setState(() {
          total += orderTotal.price;
        });
      }
      }
      
    });
  }




  @override
  Widget build(BuildContext context) {
  
 Widget basketContainer = Container(
   height: 420,
   decoration:BoxDecoration(color: AppCommons.white),
   child: Column(
     children: <Widget>[
       Padding(
         padding: const EdgeInsets.only(top:20, left:20),
         child:Row(
         children: <Widget>[
           Badge(
             badgeContent: Text(bcStr, style: TextStyle(color:AppCommons.white),),
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
       (!isEmptyListOrder)?Container(
         height: 260,
        child: ListView.builder(
         itemCount: orderList.length,
         itemBuilder: (BuildContext context, int index){
           FoodOrder orders = orderList[index];
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
        ),
       ):Center(
         child: Text("No Orders"),
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
              Text(total.toString())
            ],
            ),
       ),
      ),

     Padding(
       padding: const EdgeInsets.only(top:20, left:20, right:20),
       child:  GestureDetector(
        onTap:(){

          setState(() {
            widget.basketCount = 0;
            orderList.clear();
            bcStr = "";
            isCheckout = true;
          });
          
          if(isCheckout){
            Navigator.pop(context);
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
              Text("Proceed to checkout",
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

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppCommons.white,
      body: Column(
        children: <Widget>[
         FoodAppBar(isMainScreen: true,basketCount: widget.basketCount,orders: widget.orders,),
          Expanded(
            child:Container(
              height:MediaQuery.of(context).size.height,
              child:ListView(
                scrollDirection: Axis.vertical,
                children:[
                  Align(
            alignment: Alignment.centerLeft,
            child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width - 60,
                decoration: BoxDecoration(
                  color:AppCommons.appColor,
                  borderRadius: BorderRadius.only(topRight:Radius.circular(50),bottomRight:Radius.circular(50))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left:20),
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                 Container(
                   decoration:BoxDecoration(
                     color:AppCommons.white,
                     borderRadius: BorderRadius.circular(50)
                   ),
                   child:  Icon(Icons.local_dining, color:AppCommons.appColor),
                 ),
                  SizedBox(width: 20,),
                  Text("Special Offers",
                  style: TextStyle(
                     color:AppCommons.white,
                    fontWeight: FontWeight.bold,
                    fontSize:22
                  ),
                  ),
                    SizedBox(width: 20,),
                    Icon(Icons.arrow_forward, color:AppCommons.white)
                ],
              ),
                )
              )
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
                    padding: const EdgeInsets.only(top:20, left:20),
                    child: Container(
                    height: 260,
                     width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                    //  color: Colors.red
                    ),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            specialOffers('images/salad.jpg','Salad','Lorem Ipsum',4.5),
                            specialOffers('images/salad.jpg','Salad','Lorem Ipsum',4.5),
                           specialOffers('images/salad.jpg','Salad','Lorem Ipsum',4.5)
                          ],
                        )
                      ],
                    ),
                  ),
                  )
          ),
            Padding(
              padding: const EdgeInsets.only(top:10, bottom:10),
              child:   Align(
            alignment: Alignment.centerLeft,
            child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width - 60,
                decoration: BoxDecoration(
                  color:AppCommons.appColor,
                  borderRadius: BorderRadius.only(topRight:Radius.circular(50),bottomRight:Radius.circular(50))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left:20),
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                 Container(
                   decoration:BoxDecoration(
                     color:AppCommons.white,
                     borderRadius: BorderRadius.circular(50)
                   ),
                   child:  Icon(Icons.restaurant, color:AppCommons.appColor),
                 ),
                  SizedBox(width: 20,),
                  Text("Popular Restaurant",
                  style: TextStyle(
                     color:AppCommons.white,
                    fontWeight: FontWeight.bold,
                    fontSize:22
                  ),
                  ),
                    SizedBox(width: 20,),
                    Icon(Icons.arrow_downward, color:AppCommons.white)
                ],
              ),
                )
              )
          ),
            ),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                popularRestaurant('Crisostomo','images/crisostomo.jpg',"1",4.5),//
                popularRestaurant('Kenny Rogers','images/kenny.jpg',"2",4.2),//
                popularRestaurant('Cabalen','images/cabalen.jpg',"3",4.1),
                popularRestaurant('Jollibee','images/jollibee.jpg',"4",3),
              ],
            )
          )
           
                ]
              )
            )
          )
        ],
      ),
      floatingActionButton: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
           Padding(
             padding: const EdgeInsets.only(left:20),
             child: GestureDetector(
                onTap:(){
                  // if(widget.basketCount > 0){
                  //   showModalBottomSheet(
                  //                   context: context,
                  //                   useRootNavigator: true,
                  //                   backgroundColor: Colors.white,
                  //                   shape: RoundedRectangleBorder(
                  //                     borderRadius: BorderRadius.circular(20.0),
                  //                   ),
                  //                   elevation: 10,
                  //                   builder: (builder)=>basketContainer
                  //   );
                  // }
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppCommons.white,
                    border:Border.all(color: AppCommons.appColor),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Badge(
                  badgeContent: Text(widget.basketCount.toString(), style:TextStyle(color:AppCommons.white)),
                  child: Icon(Icons.favorite,color:Colors.red),
                ),
                )
              ),
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
                  height: 50,
                  width: 50,
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
    );
  }
  Widget popularRestaurant(String name,String image, String tag,double ratings)=>
            Padding(
                    padding: const EdgeInsets.only(top:10, right:10,left:10, bottom:20),
                    child: Container(
                    height: 360,
                     width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                    ),
                    child: Card(
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.only(top:20),
                        child: Column(
                        children: <Widget>[
                           Container(
                             height: 180,
                             child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child:Hero(
                              tag:tag,
                              child: Image.asset(image,fit:BoxFit.fitWidth),
                            )
                          ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(top:20),
                             child: Text(name,
                                style:TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                                )
                               ),
                           ),
                           Divider(),
                           Padding(
                             padding: const EdgeInsets.only(left:20, right:20),
                             child: Center(child:
                              Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam magna erat, blandit vulputate urna semper, gravida dictum risus. Duis efficitur nisl quis tempor dictum.",
                                textAlign: TextAlign.center,
                              ),)
                           ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                             children: <Widget>[
                               Row(
                                 children: <Widget>[
                                   Icon(Icons.star, color:AppCommons.appColor),
                                   Text(ratings.toString())
                                 ],
                               ),
                               Row(
                                 children: <Widget>[
                                   Icon(Icons.pin_drop, color:AppCommons.appColor),
                                   Text("Restaurant location")
                                 ],
                               ),
                                IconButton(icon: Icon(Icons.open_in_new,color:AppCommons.appColor), 
                               onPressed: (){
                                 if(widget.basketCount > 0){
                                    final snackbar = SnackBar(content: Text("You need to proceed to checkout first."));
                                   scaffoldKey.currentState.showSnackBar(snackbar);
                                //  Scaffold.of(context).showSnackBar(SnackBar(content: Text("You need to proceed to checkout first."),));
                                 }else{
                                    Navigator.push(context, MaterialPageRoute(builder: (_)=>Restaurant(title:name,tag:tag,image: image,orders: orderList,)));
                                 }
                               })
                             ],
                           )
                        ],
                      ),
                      )
                    )
                  ),
            );
  Widget specialOffers(String image,String name,String description,double ratings)=>   Card(
                               elevation: 2,
                               child:Container(
                              height: 260,
                              width: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.circular(20),
                                color: AppCommons.white,
                                //border: Border.all(color:AppCommons.appColor)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius:BorderRadius.circular(20),
                                    child:Image.asset(image,
                                      fit: BoxFit.fill,
                                  )
                                  ),
                                  SizedBox(height: 20,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(Icons.star,size: 20,),
                                      Text(ratings.toString()),
                                      Column(
                                        children: <Widget>[
                                          Text(name,
                                            style: TextStyle(
                                              fontSize:22
                                            ),
                                          ),
                                          Text(description)
                                        ],
                                      ),
                                      Icon(Icons.favorite_border,color:Colors.red)
                                    ],
                                  )
                                ],
                              ),
                              )
                            ),
                             );
}
