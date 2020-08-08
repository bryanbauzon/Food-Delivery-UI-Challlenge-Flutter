import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-commons.dart';
import 'package:food_delivery_ui_challenge/common/app-widgets.dart';
import 'package:food_delivery_ui_challenge/database/dbHelper.dart';
import 'package:food_delivery_ui_challenge/model/user.dart';
import 'package:food_delivery_ui_challenge/screen/homepage.dart';
import 'package:food_delivery_ui_challenge/screen/profile.dart';
import 'package:food_delivery_ui_challenge/screen/search.dart';

class Init extends StatefulWidget{

  final String title;
    User user;

  Init({
    Key key,
    @required this.title,
    @required this.user
  });
  
    @override
    _InitState createState()=>_InitState();
}
class _InitState extends State<Init>{
  static String title;
  
  int basketCount = 0;
  int favCount = 0;
  Future<int> orderedCount;
  Future<int> favoriteCount;
  var dbHelper;
  int _selectedIndex = 0;
  int currenIndex = 0;
  
  @override
  void initState(){
      super.initState();
      title = widget.title;
      dbHelper = DBHelper();
      orderedCount = dbHelper.orderedCount(widget.user.id);
      orderedCount.then((value){
        basketCount = value;
      });
      favoriteCount = dbHelper.favoriteCount(widget.user.id);
      favoriteCount.then((value){
        favCount = value;
      });
      print("BASKET COUNT = ");
      print(basketCount);
      print("FAVORITE COUNT = ");
      print(favCount);
      _selectedIndex = 0;
      
  }

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
      currenIndex = _selectedIndex;
    });
  }
 
 Color itemTappedColorChanger(int index){
    return index == currenIndex?AppCommons.appColor:AppCommons.grey;
 }
 

  @override
  Widget build(BuildContext context) {
     List<Widget> _widgetOptions = <Widget>[
    HomePage(title: title,user: widget.user,),
    Search(),
    Profile()
  ];


  void refreshCounts(){
     orderedCount = dbHelper.orderedCount(widget.user.id);
      orderedCount.then((value){
        setState(() {
          basketCount = value;
        });
      });
      favoriteCount = dbHelper.favoriteCount(widget.user.id);
      favoriteCount.then((value){
        setState(() {
          favCount = value;
        });
      });
  }
  refreshCounts();
   return WillPopScope(
     child: Scaffold(
       body: Column(
         children: <Widget>[
              AppWidgets().foodAppBar(context, true,basketCount,favCount,widget.user),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: _widgetOptions.elementAt(_selectedIndex),
                ),
              )
         ],
       ),
       bottomNavigationBar: Padding(
         padding: const EdgeInsets.all(10),
         child: Container(
         height: 50,
         decoration: BoxDecoration(
           border: Border.all(color:AppCommons.appColor, width:2),
           borderRadius: BorderRadius.circular(20)
         ),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
             IconButton(icon: Icon(
               (currenIndex == 0)?Icons.restaurant:Icons.home,
                 color: itemTappedColorChanger(0),
             ), onPressed: (){
                  _onItemTapped(0);
             }),
             IconButton(icon: Icon(Icons.search,
                color: itemTappedColorChanger(1),
             ), onPressed: (){
                 _onItemTapped(1);
             }),
             IconButton(icon: Icon(Icons.notifications,
                color: itemTappedColorChanger(2),
             ), onPressed: (){
                  _onItemTapped(2);
             })
           ],
         ),
       ),
       
       )  
     ),
     onWillPop: ()async =>false);
  }
  
}