import 'package:flutter/material.dart';
import 'package:food_delivery_ui_challenge/common/app-commons.dart';
import 'package:food_delivery_ui_challenge/database/dbHelper.dart';
import 'package:food_delivery_ui_challenge/model/restaurant-m.dart';
import 'package:food_delivery_ui_challenge/model/restaurant-menu.dart';
import 'package:food_delivery_ui_challenge/screen/login.dart';

class Splash extends StatefulWidget{
  @override
  _SplashState createState() => _SplashState();
}
class _SplashState extends State<Splash>{

var dbHelper;
  void initState(){
    super.initState();
      Future.delayed(Duration(seconds:8),(){
    dbHelper = DBHelper();
    FocusScope.of(context).unfocus();
          //Check if the restaurant list has been initialized
  Future<List<RestaurantM>> restaurantList = dbHelper.getRestaurantList();
  restaurantList.then((value){
  if(value.length == 0){
      List<RestaurantM> resList = [];
       RestaurantM cabalen = 
      RestaurantM(id: null, name: "Cabalen", description: AppCommons.lorem, ratings:0, reviews: "", imagePath: AppCommons.cabalenIP);
      RestaurantM crisostomo = 
      RestaurantM(id: null, name: "Crisostomo", description: AppCommons.lorem, ratings:0, reviews: "", imagePath: AppCommons.crisostomoIP);
       RestaurantM kuyaj = 
      RestaurantM(id: null, name: "Kuya-J", description:  AppCommons.lorem, ratings: 0, reviews: "", imagePath: AppCommons.kuyaJIP);
      RestaurantM yoshinoya = 
      RestaurantM(id: null, name: "Yoshinoya", description:  AppCommons.lorem, ratings: 0, reviews: "", imagePath: AppCommons.yoshinoyaIP);
      RestaurantM gerry = 
      RestaurantM(id: null, name: "Gerry's Grill", description:  AppCommons.lorem, ratings: 0, reviews: "", imagePath: AppCommons.gerryIP);
      
      resList.add(cabalen);
      resList.add(crisostomo);
      resList.add(kuyaj);
      resList.add(yoshinoya);
      resList.add(gerry);

      dbHelper.initRestaurant(resList);
      restaurantList = dbHelper.getRestaurantList();
      
      restaurantList.then((restaurant){
        for(RestaurantM m in restaurant){
            // RestaurantMenu menu1 = RestaurantMenu(
            //   id: null,
            //   resId: m.id,
            //   imagePath: 'images/adobo.jpg',
            //   name: 'Adobo',
            //   reviews: 'No Reviews',
            //   description: AppCommons.lorem,
            //   price: 120
            // );
             
            RestaurantMenu menu3 = RestaurantMenu(
              id: null,
              resId: m.id,
              imagePath: 'images/dinuguan.jpg',
              name: 'Dinuguan',
              reviews: 'No Reviews',
              description: AppCommons.lorem,
              price: 150
            );
            //  RestaurantMenu menu4 = RestaurantMenu(
            //   id: null,
            //   resId: m.id,
            //   imagePath: 'images/karekare.jpg',
            //   name: 'Bicol Express',
            //   reviews: 'No Reviews',
            //   description: AppCommons.lorem,
            //   price: 150
            // );
              RestaurantMenu menu5 = RestaurantMenu(
              id: null,
              resId: m.id,
              imagePath: 'images/sisig.jpg',
              name: 'Sisig',
              reviews: 'No Reviews',
              description: AppCommons.lorem,
              price: 150
            );
            // dbHelper.initRestaurantMenu(menu1);
            
            // dbHelper.initRestaurantMenu(menu3);
            // dbHelper.initRestaurantMenu(menu4);
            for(int i = 1; i <= 100;i++){
               dbHelper.initRestaurantMenu(menu5);
               dbHelper.initRestaurantMenu(menu3);
            }
           
        }
      });
    
  } 
  });
        Navigator.push(context, //Login
          MaterialPageRoute(builder: (context)=>Login())
          //HomePage(title: AppCommons.appName,basketCount: 0,orders: [],favoriteCount: 0,favorites: [],total: 0,)
        );
      });
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
     // backgroundColor:ExpenseTrackerCommons.appColor ,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppCommons.appColor
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Text(
              AppCommons.appName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppCommons.white,
                fontSize: 22
              ),
          ),
          SizedBox(height: 20,),
          CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(AppCommons.appColor),
            backgroundColor:AppCommons.white,
          )
          ],
        )
      ),
    );
  }

}