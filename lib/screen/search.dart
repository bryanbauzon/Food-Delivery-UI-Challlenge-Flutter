import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-commons.dart';

class Search extends StatefulWidget{
  @override
  _SearchState createState() => _SearchState();
}
class _SearchState extends State<Search>{
  TextEditingController searchController;
  final _formKey = GlobalKey<FormState>();
  String searchResult = "";

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
                      controller: searchController,
                      validator: (text){
                        if(text.isEmpty){
                          return AppCommons.searchField+"is empty.";
                        }
                        return null;
                      },
                      onChanged: (text){
                        print(text);
                        setState(() {
                          searchResult = text;
                        });
                      },
                      style: TextStyle(
                        color:AppCommons.appColor,
                        fontWeight:FontWeight.bold
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search,
                          color:AppCommons.appColor
                        ),
                          hintText: AppCommons.search,
                          hintStyle: TextStyle(
                            color:AppCommons.appColor
                          ),
                          enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(width: 1,color:AppCommons.appColor),
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
          Text("$searchResult")
       ],
     );
  }

}