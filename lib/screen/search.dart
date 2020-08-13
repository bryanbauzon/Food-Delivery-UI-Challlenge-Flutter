import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-commons.dart';
import 'package:food_delivery_ui_challenge/database/dbHelper.dart';
import 'package:food_delivery_ui_challenge/model/restaurant-menu.dart';

class Search extends StatefulWidget{
  @override
  _SearchState createState() => _SearchState();
}
class _SearchState extends State<Search>{
  TextEditingController searchController;
  final _formKey = GlobalKey<FormState>();
  var dbHelper;
  List<RestaurantMenu> searchResult;
   Future<List<RestaurantMenu>>searchRestaurantsMenuByName ;
   bool isWidgetsReady = false;
  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
    searchRestaurantsMenuByName = dbHelper.getRestaurantMenu();
    searchRestaurantsMenuByName.then((value) {
        searchResult = value;
    }).catchError((error){
      print(error);
    });

    Future.delayed(Duration(seconds: 2),(){
      isWidgetsReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
     return Column(
       children: <Widget>[
         Padding(
           padding: const EdgeInsets.only(bottom:20),
           child:  Align(
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
                   child:  Icon(Icons.search, color:AppCommons.appColor),
                 ),
                  SizedBox(width: 20,),
                  Text("Search menu",
                  style: TextStyle(
                     color:AppCommons.white,
                    fontWeight: FontWeight.bold,
                    fontSize:22
                  ),
                  ),
                    SizedBox(width: 20,),
                    
                ],
              ),
                )
              )
          ),
         ),

          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left:20, right:20),
              child: TextFormField(
                enabled: isWidgetsReady,
                      controller: searchController,
                      validator: (text){
                        if(text.isEmpty){
                          return AppCommons.searchField+"is empty.";
                        }
                        return null;
                      },
                      onChanged: (text){
                       searchRestaurantsMenuByName = dbHelper.searchRestaurantsMenuByName(text);
                        setState(() {
                          searchRestaurantsMenuByName.then((value){
                            setState(() {
                              searchResult = value;
                            });
                          }).catchError((onError)=>print(onError));
                        
                        });
                      },
                      style: TextStyle(
                        color:isWidgetsReady?AppCommons.appColor:AppCommons.grey,
                        fontWeight:FontWeight.bold
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search,
                          color:isWidgetsReady?AppCommons.appColor:AppCommons.grey
                        ),
                          hintText: AppCommons.search,
                          hintStyle: TextStyle(
                            color:isWidgetsReady?AppCommons.appColor:AppCommons.grey
                          ),
                          enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(width: 1,color:AppCommons.appColor),
                            ),
                             disabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(width: 1,color:AppCommons.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(width: 2,color: AppCommons.appColor),
                            ),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(width: 2,color: Colors.red),
                            ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(width: 2,color: AppCommons.appColor),
                            ),
                      ),
                    ),
            )
          ),
            isWidgetsReady? Expanded(
            child: Container(
               height: MediaQuery.of(context).size.height,
               width: MediaQuery.of(context).size.width,
               
               child: Padding(
                 padding: const EdgeInsets.only(top:5),
                 child: searchResult.length > 0?FutureBuilder<List<RestaurantMenu>>(
                  future: searchRestaurantsMenuByName,
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
                        RestaurantMenu menus  = restaurantList[index];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child:Align(
                            alignment: (index % 2 == 0)?Alignment.centerLeft:Alignment.centerRight,
                            child:  Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width - 40,
                            decoration: BoxDecoration(
                              color:AppCommons.appColor
                            ),
                            child: Row(
                              children: [
                                Image.asset(menus.imagePath)
                              ],
                            ),
                          ),
                          )
                        );
                      }
                    );
                  },
               ):Text("No result found")
               )
            ),
          ):Padding(
            padding: const EdgeInsets.only(top:30),
            child: Column(
              children: [
                Text("Fetching restaurants menu...",
                  style: TextStyle(
                    color:AppCommons.grey,
                    fontSize:18,
                    fontWeight:FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(AppCommons.appColor),
                          backgroundColor: AppCommons.white,
               ),
              ],
            )
          )
       ],
     );
  }

}