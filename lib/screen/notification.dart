import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-commons.dart';
import 'package:food_delivery_ui_challenge/database/dbHelper.dart';
import 'package:food_delivery_ui_challenge/model/notification-m.dart';
import 'package:food_delivery_ui_challenge/model/user.dart';

class NotificationScreen extends StatefulWidget{

  final User user;
  NotificationScreen({
    Key key,
    @required this.user
  });
    @override
    _NotificationState createState() => _NotificationState();


}
class _NotificationState extends State<NotificationScreen>{

  var dbHelper;
  bool isReady = false;
Future<List<NotificationM>>getNotifListByUserId;
int notifsCnt;Future<int>notificationCount;
  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
    WidgetsBinding.instance
        .addPostFrameCallback((_) {
           getNotifListByUserId = dbHelper.getNotifListByUserId(widget.user.id);
          dbHelper.updateNotifStatusByUserId(widget.user.id);
       
        } );
        notificationCount = dbHelper.notificationCount(widget.user.id);
      notificationCount.then((value){
        setState(() {
          notifsCnt = value;
        });
      });
  Future.delayed(Duration(seconds: 2),(){
      setState(() {
        isReady = true;
     
      });
  });
  }
  @override
  Widget build(BuildContext context) {
     return Column(
       children: <Widget>[
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
                   child:  Icon(Icons.notifications, color:AppCommons.appColor),
                 ),
                  SizedBox(width: 20,),
                  Text("Notifications",
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
              height: MediaQuery.of(context).size.height,
              width:  MediaQuery.of(context).size.width,
              child: !isReady?Center(
                child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(AppCommons.appColor),
                          backgroundColor: AppCommons.white,
                ),
              ):(notifsCnt> 0)?FutureBuilder<List<NotificationM>>(
                future: getNotifListByUserId,
                builder: (context, snapshot){
                  if(snapshot.connectionState != ConnectionState.done){

                    }
                    if(snapshot.hasError){
                      print("ERROR!!");
                      print(snapshot.error);
                    }
                    List<NotificationM>notisList = snapshot.data??[];
                    return ListView.builder(
                      itemCount: notisList.length,
                      itemBuilder: (context,index){
                          NotificationM notif = notisList[index];
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Card(
                              elevation: 2,
                              shadowColor: AppCommons.appColor,
                              child: Container(
                              height:60,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(notif.message,
                                    style: TextStyle(
                                      color:AppCommons.appColor,
                                      fontWeight:FontWeight.bold,
                                      fontSize: 18
                                    ),
                                  ),
                                  Text(notif.updDt,
                                    style: TextStyle(
                                      color:AppCommons.appColor,
                                    ),
                                  ),
                                      ],
                                    )
                                  ),
                                  IconButton(icon: Icon(Icons.close, color:AppCommons.appColor),
                                   onPressed: (){
                                      print(notif.id);
                                      dbHelper.removeNotifById(notif.id);
                                        notificationCount = dbHelper.notificationCount(widget.user.id);
                                        notificationCount.then((value){
                                          setState(() {
                                            notifsCnt = value;
                                          });
                                        });
                                      setState(() {
                                         getNotifListByUserId = dbHelper.getNotifListByUserId(widget.user.id);
                                        
                                      });
                                   })
                                ],
                              ),
                            ),
                            )
                          );
                      }
                    );
                }
              ):Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                child: Text("No notifications found."),
              ),
              )
            ),
            )
          )
       ],
     );
  }
    
}