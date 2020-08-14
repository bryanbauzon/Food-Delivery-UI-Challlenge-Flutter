import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-commons.dart';
import 'package:food_delivery_ui_challenge/common/app-widgets.dart';
import 'package:food_delivery_ui_challenge/database/dbHelper.dart';
import 'package:food_delivery_ui_challenge/model/user.dart';
import 'package:food_delivery_ui_challenge/screen/homepage.dart';
import 'package:food_delivery_ui_challenge/screen/notification.dart';
import 'package:food_delivery_ui_challenge/screen/search.dart';

// ignore: must_be_immutable
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
  int notifCount = 0;
  int favCount = 0;
  Future<int> orderedCount;
  Future<int> favoriteCount;
  var dbHelper;
  int _selectedIndex = 0;
  int currenIndex = 0;
 final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState(){
      super.initState();
      title = widget.title;
      dbHelper = DBHelper();

      WidgetsBinding.instance
        .addPostFrameCallback((_){
          orderedCount = dbHelper.orderedCount(widget.user.id);
              orderedCount.then((value){
                basketCount = value;
              });
              favoriteCount = dbHelper.favoriteCount(widget.user.id);
              favoriteCount.then((value){
                favCount = value;
              });
        });
    
      print("BASKET COUNT = ");
      print(basketCount);
      print("FAVORITE COUNT = ");
      print(favCount);
      _selectedIndex = 0;
      
  }
  void refreshNotifCounts(){
    print("notifCount");
    Future<int>notificationCount = dbHelper.notificationCount(widget.user.id);
    notificationCount.then((value){
        setState(() {
          notifCount = value;
        });
    }).catchError((onError){
      print(onError);
    });
    print(notifCount);
  }

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
      currenIndex = _selectedIndex;
    });
  }
 
 Color itemTappedColorChanger(int index){
    return AppCommons.white;
 }
 

  @override
  Widget build(BuildContext context) {
     List<Widget> _widgetOptions = <Widget>[
    HomePage(title: title,user: widget.user,),
    Search(user: widget.user,),
    NotificationScreen(user: widget.user,)
  ];

refreshNotifCounts();

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
       key: _scaffoldKey,
       drawer: AppWidgets().foodDrawer(context),
       body: Column(
         children: <Widget>[
              AppWidgets().foodAppBar(context, true,basketCount,favCount,widget.user,"N",_scaffoldKey),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: _widgetOptions.elementAt(_selectedIndex),
                ),
              )
         ],
       ),
       bottomNavigationBar: Container(
         height: 55,
         decoration: BoxDecoration(
           color: AppCommons.appColor,
           borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight:Radius.circular(20))
         ),
         child: Padding(
           padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
           child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
             Container(
                decoration: BoxDecoration(
                  border: Border(
                    top:BorderSide(
                        width: 3,
                       color:  (currenIndex == 0)?AppCommons.white:AppCommons.appColor,
                    )
                  ),
               ),
               child: IconButton(icon: Icon(
               (currenIndex == 0)?Icons.restaurant:Icons.home,
                 color: itemTappedColorChanger(0),
             ), onPressed: (){
                  _onItemTapped(0);
             }),
             ),
            Container(
               decoration: BoxDecoration(
                  border: Border(
                    top:BorderSide(
                      width: 3,
                       color:  (currenIndex == 1)?AppCommons.white:AppCommons.appColor,
                    )
                  ),
               ),
              child:  IconButton(icon: Icon(Icons.search,
                color: itemTappedColorChanger(1),
             ), onPressed: (){
                 _onItemTapped(1);
             }),
            ),
             Container(
                decoration: BoxDecoration(
                  border: Border(
                    top:BorderSide(
                        width: 3,
                       color:  (currenIndex == 2)?AppCommons.white:AppCommons.appColor,
                    )
                  ),
               ),
               child: notifCount == 0?IconButton(icon: Icon(Icons.notifications,
                      color: itemTappedColorChanger(2),
                  ), onPressed: (){
                        _onItemTapped(2);
                  }):Badge(
                    badgeContent:Text(notifCount.toString(),
                      style: TextStyle(
                        color:AppCommons.white
                      ),
                    ),
                    child: IconButton(icon: Icon(Icons.notifications,
                      color: itemTappedColorChanger(2),
                  ), onPressed: (){
                        _onItemTapped(2);
                        dbHelper.updateNotifStatusByUserId(widget.user.id);
                  }),
                  ),
             )
           ],
         ),
         )
       ),
     ),
     onWillPop: ()async =>false);
  }
}