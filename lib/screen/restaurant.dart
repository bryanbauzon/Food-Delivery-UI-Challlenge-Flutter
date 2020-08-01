import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-commons.dart';
import 'package:food_delivery_ui_challenge/common/food-appbar.dart';
import 'package:food_delivery_ui_challenge/model/food-order.dart';
import 'package:food_delivery_ui_challenge/screen/checkout.dart';
class Restaurant extends StatefulWidget{
  final String title;
  final String tag;
  final String image;
   List<FoodOrder>orders;
  
  Restaurant({
    Key key,
    @required this.title,
    @required this.tag,
    @required this.image,
    @required this.orders
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
   bool isOrderEmpty = false;
 final scaffoldKey = GlobalKey<ScaffoldState>();

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
 
  @override
  Widget build(BuildContext context) {

   

    //checkBasketCount();
  Widget basketContainer=!isOrderEmpty?Container(
   height: 420,
   decoration:BoxDecoration(color: AppCommons.white),
   child:  Column(
     children: <Widget>[
       Padding(
         padding: const EdgeInsets.only(top:20, left:20),
         child:Row(
         children: <Widget>[
           Badge(
             badgeContent: Text(basketCount.toString(), style: TextStyle(color:AppCommons.white),),
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
         itemCount: orderList.length,
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
              orderList.clear();
              widget.orders.clear();
               isCheckout = true;
               basketCount = 0;
          });
           
          if(isCheckout)
          {   Navigator.pop(context);
            
          
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
 ):Container(
   height: 200,
   color: AppCommons.white,
   child: Center(
     child: Text("No order found."),
   ),
 );
    return Scaffold(
      backgroundColor: AppCommons.white,
      body:WillPopScope(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          FoodAppBar(isMainScreen: false,basketCount: basketCount,orders: orderList,),
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
              padding: const EdgeInsets.only(top:20,left:20, bottom:20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.restaurant_menu, color:AppCommons.appColor),
                    SizedBox(width: 20,),
                    Text(widget.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Icons.pin_drop, color:AppCommons.appColor),
                      Text("Restaurant Location")
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Icons.timer, color:AppCommons.appColor),
                      Text("35-45 Mins")
                    ],
                  ),
                  )
                ],
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
       floatingActionButton: new GestureDetector(
                onTap:(){
                  if(basketCount > 0){
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
                child:Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppCommons.white,
                    border:Border.all(color: AppCommons.appColor),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Badge(
                  badgeContent: Text(basketCount.toString(), style:TextStyle(color:AppCommons.white)),
                  child: Icon(Icons.shopping_basket,color:AppCommons.appColor),
                ),
                )
              ),
    );
  }
  Widget foodMenu(int index,String name,String restaurant,String image, double price)=> Padding(
    padding: const EdgeInsets.only(top:10,left:10,right: 10),
    child: Container(
            height: 160,
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              color:AppCommons.grey,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(topRight:Radius.circular(20),bottomRight: Radius.circular(20)),
                  child: Image.asset(image,width: 200,fit: BoxFit.fitHeight,),
                ),
                Column(
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
                        Text("78 Review",
                          style:TextStyle(
                            fontWeight:FontWeight.w400
                          )
                        )
                      ],
                    ),
                    Align(
                      alignment:Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top:20, bottom:20),
                        child: Text("P "+price.toString()),
                      ),
                    ),
                    Visibility(child: GestureDetector(
                      onTap:(){
                        FoodOrder order = FoodOrder(id:index,image: image,name: name,price: price);

                        setState(() {
                          selectedIndex = index;
                          total += price;
                          indexList.add(selectedIndex);
                          orderList.add(order);
                        });

                       
                        if(basketCount < 10){
                          setState(() {
                            basketCount +=1;
                          });
                        } 
                      },
                      child:Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border:Border.all(color:AppCommons.appColor)
                        ),
                        child: Center(
                          child: Text("Add to Basket",
                            style: TextStyle(
                              fontWeight:FontWeight.bold,
                              color:AppCommons.appColor
                            ),
                          ),
                        ),
                      )
                    ),
                    visible: (indexList.contains(index))?false:true,
                    )
                  ],
                ),
                SizedBox(width:20)
              ],
            ),
          ),
  );
    
}