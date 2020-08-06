import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-commons.dart';
import 'package:food_delivery_ui_challenge/database/dbHelper.dart';
import 'package:food_delivery_ui_challenge/model/user.dart';
import 'package:food_delivery_ui_challenge/screen/homepage.dart';
// ignore: must_be_immutable
class FoodAppBar extends StatefulWidget{

  final bool isMainScreen;
   final User user;
   final String name;
   final String tag;
   final String image;
   final int basketCount;

  FoodAppBar({
    Key key,
    @required this.isMainScreen,
    @required this.user,
     this.name,
     this.tag,
     this.image,
     @required this.basketCount
  });

  @override
  _FoodAppBarState createState()=>_FoodAppBarState();
}
class _FoodAppBarState extends State<FoodAppBar>{
  bool search = false;
  bool isCheckout = false;

  var dbHelper;
    @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
     
  }
      
  @override
  Widget build(BuildContext context) {
  
  
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
            width: MediaQuery.of(context).size.width - 140,
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
                        context,MaterialPageRoute(builder: (_)=>HomePage(title: AppCommons.appName,user: widget.user,basketCount: widget.basketCount,))
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
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppCommons.white,
                    border:Border.all(color: AppCommons.appColor),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: widget.basketCount>0?Badge(
                  badgeContent: Text(widget.basketCount.toString(), style:TextStyle(color:AppCommons.white)),
                  child: Icon(Icons.shopping_basket,color:AppCommons.appColor),
                ):Icon(Icons.shopping_basket,color:AppCommons.appColor),
                )
              ),
            GestureDetector(
                onTap:(){
                  // if(widget.favorites.length > 0){
                  //   showModalBottomSheet(
                  //     context: context,
                  //     useRootNavigator: true,
                  //     backgroundColor: Colors.white,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(20.0),
                  //     ),
                  //     elevation: 10,
                  //     builder: (builder)=>favoriteContainer
                  //   );
                  // }
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
                  badgeContent: Text("", style:TextStyle(color:AppCommons.white)),
                  child: Icon(Icons.favorite,color:Colors.red),
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