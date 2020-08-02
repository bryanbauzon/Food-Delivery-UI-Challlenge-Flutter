import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-commons.dart';
import 'package:food_delivery_ui_challenge/common/food-appbar.dart';
import 'package:food_delivery_ui_challenge/model/favorite.dart';
import 'package:food_delivery_ui_challenge/model/food-order.dart';
// ignore: must_be_immutable
class Restaurant extends StatefulWidget{
  final String title;
  final String tag;
  final String image;
   List<FoodOrder>orders;
   List<Favorite> favs;
  
  Restaurant({
    Key key,
    @required this.title,
    @required this.tag,
    @required this.image,
    @required this.orders,
    @required this.favs
  });
  
  @override
  _RestaurantState createState() => _RestaurantState();
}
class _RestaurantState extends State<Restaurant>{
 bool search = false;
 int basketCount = 0;
   int selectedIndex = 0;
   List<int> indexList = [];
   double total = 0;
   bool isCheckout = false;
   List<FoodOrder> orderList = [];
   List<Favorite> favoriteList = [];
   List<int> favIndexList = [];
    var listToRemove = [];
   List<Favorite> toRemoveListFav = [];
  var listToAddIndexFav = [];
   List<Favorite> toAddListFav = [];
   var toRemoveFav = [];
   int selectedFavIndex = 0;
   int favSize = 0;
   bool isOrderEmpty = false;
 final scaffoldKey = GlobalKey<ScaffoldState>();
  bool duplicate = false;
                      var duplicateVal = 0;
                      var counter = 0;
  @override
    void initState(){
      super.initState();
      if(widget.orders.isEmpty){
        setState(() {
          widget.orders = orderList;
        });
      }
      setState(() {
        basketCount = widget.orders.length;
      });

    }
 void removeDuplicateIndex(){
  setState(() {
     if(duplicate){
       if(duplicateVal > 0){
            favIndexList.removeWhere((element) => element == duplicateVal);
            favoriteList.removeWhere((element)=>element.id == duplicateVal);
            duplicate = false;
            duplicateVal = 0;
       }
     }
  });
}
void setToFalseCheckout(){
  setState(() {
            isCheckout = false;
          });
}
  @override
  Widget build(BuildContext context) {

setToFalseCheckout();
   removeDuplicateIndex();

    return Scaffold(
      backgroundColor: AppCommons.white,
      body:WillPopScope(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          FoodAppBar(isMainScreen: false,basketCount: basketCount,orders: orderList,favorites: favoriteList,favoriteCount: favoriteList.length,total: total,name: widget.title,tag: widget.tag,image: widget.image,),
         Expanded(
           child: ListView(
             children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Hero(tag: widget.tag, child: Image.asset(widget.image)),
              ),
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
              foodMenu(1,"Chimichurri",widget.title,'images/k-m1.jpg',230),
              foodMenu(2,"Sweet and Sour",widget.title,'images/sas.jpg',190),
              foodMenu(3,"Dinuguan",widget.title,'images/dinuguan.jpg',90),
              foodMenu(4,"Adobong Manok",widget.title,'images/adobo.jpg',75),
              foodMenu(5,"Lechon",widget.title,'images/lechon.jpg',320),
              foodMenu(6,"Pork Sisig",widget.title,'images/sisig.jpg',80),
              foodMenu(7,"Kare Kare",widget.title,'images/karekare.jpg',120),
             ],
           ),
         )
        ],
      ),
       onWillPop: ()async=>false),
       
    );
  }
  Widget foodMenu(int index,String name,String restaurant,String image, double price)=> Padding(
    padding: const EdgeInsets.only(top:10,left:10,right: 10),
    child: Container(
            height: 160,
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              color:AppCommons.grey,
              border: Border.all(width:2,color:(indexList.contains(index))?AppCommons.appColor:AppCommons.grey),
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
                            FoodOrder order = FoodOrder(id:index,image: image,name: name,price: price);
                            print(index);
                             if(!indexList.contains(index)){
                                setState(() {
                                  selectedIndex = index;
                                  total += price;
                                  indexList.add(selectedIndex);
                                  orderList.add(order);
                                  basketCount = orderList.length;
                                });
                             }else{
                               setState(() {
                                 orderList.removeWhere((element) => element.id == index);
                                 indexList.removeWhere((element) => element == index);
                                 total -= price;
                                  basketCount = orderList.length;
                               });
                             }
                          },
                          child:Container(
                            width: 110,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border:Border.all(color:AppCommons.appColor),
                              color: indexList.contains(index)?AppCommons.appColor:AppCommons.grey
                            ),
                            child: Center(
                              child: Text(!indexList.contains(index)?"Add to Basket":"Remove to Basket",
                                style: TextStyle(
                                  fontWeight:FontWeight.bold,
                                  color:!indexList.contains(index)?AppCommons.appColor:AppCommons.white
                                ),
                              ),
                            ),
                          )
                        ),
                   
                    IconButton(
                      icon: Icon(favIndexList.contains(index)?Icons.favorite:Icons.favorite_border,color:Colors.red), onPressed: (){
                      Favorite favorite = Favorite(id: index, name: name, price: price);
                      setState(() {
                         if(favIndexList.contains(index) ){
                           duplicate = true;
                           duplicateVal = index;
                        }
                        favoriteList.add(favorite);
                        favIndexList.add(index);
                    });
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