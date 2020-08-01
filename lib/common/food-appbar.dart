import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-commons.dart';
import 'package:food_delivery_ui_challenge/main.dart';
import 'package:food_delivery_ui_challenge/model/food-order.dart';
class FoodAppBar extends StatefulWidget{

  final bool isMainScreen;
  final int basketCount;
 final List<FoodOrder> orders;
  FoodAppBar({
    Key key,
    @required this.isMainScreen,
    @required this.basketCount,
    @required this.orders
  });

  @override
  _FoodAppBarState createState()=>_FoodAppBarState();
}
class _FoodAppBarState extends State<FoodAppBar>{
  bool search = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: BoxDecoration(
        color: AppCommons.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
           Container(
                width: 60,
                height: 40,
                decoration: BoxDecoration(
                  color: AppCommons.appColor,
                  borderRadius: BorderRadius.only(topRight:Radius.circular(20),bottomRight: Radius.circular(20)),
                ),
                child: Center(
                  child: widget.isMainScreen?Icon(Icons.short_text, color:AppCommons.white):
                  IconButton(
                    icon:Icon(Icons.arrow_back, color:AppCommons.white),
                    onPressed: (){
                      Navigator.push(
                        context,MaterialPageRoute(builder: (_)=>HomePage(title: AppCommons.appName,basketCount: widget.basketCount,orders: widget.orders,))
                      );
                    },
                  ),
                )
              ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right:15),
                child: Container(
                  width: 320,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                               width: 250,
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
              ),
            )
            ],
          ),
           
        ],
      ),
      )
    );
  }

}