import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-commons.dart';
import 'package:food_delivery_ui_challenge/database/dbHelper.dart';
import 'package:food_delivery_ui_challenge/model/restaurant-m.dart';
import 'package:food_delivery_ui_challenge/model/user.dart';
import 'package:food_delivery_ui_challenge/screen/restaurant.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget{ 
  final String title;
  final User user;
  

  HomePage({
    Key key,
    @required this.title,
    @required this.user,
  
  });

    @override
    _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>{
    List<int> foodOrdered;
   var scaffoldKey;
    bool isCheckout = false;
   String imageP = "";
String tagP = "";
String nameP = "";
Future<List<RestaurantM>>restaurantList;
int basketCount = 0;
 Future<int> orderedCount;
    Future<int> favoriteCount;
            int favCount = 0;
var dbHelper;
  @override
  void initState(){
    super.initState();
    scaffoldKey =   GlobalKey<ScaffoldState>();
    dbHelper = DBHelper();
    restaurantList = dbHelper.getRestaurantList();
    
    print("ID:::::::::::");
    print(widget.user.id);
     favoriteCount = dbHelper.favoriteCount(widget.user.id);
             favoriteCount.then((value){
              setState(() {
              favCount = value;
              });
             });
  }

 


  @override
  Widget build(BuildContext context) {
  void refreshBasketCount(){
     orderedCount = dbHelper.orderedCount(widget.user.id);
         orderedCount.then((value){
            setState(() {
              basketCount = value;
            });
         });
  }
  refreshBasketCount();
     
    return Column(
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
                    padding: const EdgeInsets.only(top:10, left:20),
                    child: Container(
                    height: 140,
                     width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                    //  color: Colors.red
                    ),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            specialOffers('images/cinnabon.jpg','Cinnabon','13 reviews',4.5),
                            specialOffers('images/redvelvet.jpg','Red Velvet Cupcakes','27 Reviews',4.5),
                            specialOffers('images/salad.jpg','Salad','32 Reviews',4.5),
                            specialOffers('images/pizza.jpg','Pizza','32 Reviews',4.6)
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
        
          Expanded(
            child: Container(
               height: MediaQuery.of(context).size.height,
               width: MediaQuery.of(context).size.width,
               
               child:Padding(
                 padding: const EdgeInsets.only(top:5),
                 child: FutureBuilder<List<RestaurantM>>(
                  future: restaurantList,
                  builder: (context, snapshot){
                    if(snapshot.connectionState != ConnectionState.done){

                    }
                    if(snapshot.hasError){
                      print("ERROR!!");
                      print(snapshot.hasError);
                    }
                    List<RestaurantM> restaurantList = snapshot.data ??[];
                    return ListView.builder(
                      itemCount: restaurantList.length,
                      itemBuilder: (context, index){
                        RestaurantM res  = restaurantList[index];
                        return popularRestaurant(res.name,res.imagePath,res.id.toString(),res.ratings);
                      }
                    );
                  },
               ),
               )
            ),
          )
           
                ]
              );
  }
  Widget popularRestaurant(String name,String image, String tag,double ratings)=>
            Padding(
                    padding: const EdgeInsets.only(right:10,left:10,),
                    child: Container(
                    height: 360,
                     width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                    ),
                    child: Card(
                      shadowColor: AppCommons.appColor,
                      elevation: 3,
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
                                
                                 Navigator.push(context,
                                  MaterialPageRoute(builder: (_)=>Restaurant(title: name,tag: tag,image: image,user:widget.user,resId: int.parse(tag),basketCount: basketCount,))
                                 );
                               })
                             ],
                           )
                        ],
                      ),
                      )
                    )
                  ),
            );
  Widget specialOffers(String image,String name,String reviews,double ratings)=>  
                     Container( 
                     height: 130,
                    width: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(20),
                      color: AppCommons.white,
                              ),
                       child: Card(
                         child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius:BorderRadius.circular(20),
                                    child:Image.asset(image,
                                    height: 110,
                                      fit: BoxFit.fitWidth,
                                  )
                                  ),
                                    
                                ],
                              ),
                              )
                       ),
              );
                           
}
