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
      Future.delayed(Duration(seconds:10),(){
    dbHelper = DBHelper();
          //Check if the restaurant list has been initialized
  Future<List<RestaurantM>> restaurantList = dbHelper.getRestaurantList();
  restaurantList.then((value){
  if(value.length == 0){
      List<RestaurantM> resList = [];
       RestaurantM cabalen = 
      RestaurantM(id: null, name: "Cabalen", description: AppCommons.lorem, ratings:0, reviews: "", imgPath: AppCommons.cabalenIP);
      RestaurantM crisostomo = 
      RestaurantM(id: null, name: "Crisostomo", description: AppCommons.lorem, ratings:0, reviews: "", imgPath: AppCommons.crisostomoIP);
       RestaurantM kuyaj = 
      RestaurantM(id: null, name: "Kuya-J", description:  AppCommons.lorem, ratings: 0, reviews: "", imgPath: AppCommons.kuyaJIP);
      RestaurantM yoshinoya = 
      RestaurantM(id: null, name: "Yoshinoya", description:  AppCommons.lorem, ratings: 0, reviews: "", imgPath: AppCommons.yoshinoyaIP);
      RestaurantM gerry = 
      RestaurantM(id: null, name: "Gerry's Grill", description:  AppCommons.lorem, ratings: 0, reviews: "", imgPath: AppCommons.gerryIP);
      
      resList.add(cabalen);
      resList.add(crisostomo);
      resList.add(kuyaj);
      resList.add(yoshinoya);
      resList.add(gerry);

      dbHelper.initRestaurant(resList);
      restaurantList = dbHelper.getRestaurantList();
      List<RestaurantMenu> menuList;
      restaurantList.then((restaurant){
        for(RestaurantM m in restaurant){
            RestaurantMenu menu1 = RestaurantMenu(
              id: null,
              resId: m.id,
              imagePath: 'images/adobo.jpg',
              name: 'Adobo',
              reviews: 'No Reviews',
              descriptions: AppCommons.lorem,
              price: 120
            );
             RestaurantMenu menu2 = RestaurantMenu(
              id: null,
              resId: m.id,
              imagePath: 'images/bicol.jpg',
              name: 'Bicol Express',
              reviews: 'No Reviews',
              descriptions: AppCommons.lorem,
              price: 90
            );
            RestaurantMenu menu3 = RestaurantMenu(
              id: null,
              resId: m.id,
              imagePath: 'images/dinuguan.jpg',
              name: 'Dinuguan',
              reviews: 'No Reviews',
              descriptions: AppCommons.lorem,
              price: 150
            );
             RestaurantMenu menu4 = RestaurantMenu(
              id: null,
              resId: m.id,
              imagePath: 'images/karekare.jpg',
              name: 'Bicol Express',
              reviews: 'No Reviews',
              descriptions: AppCommons.lorem,
              price: 150
            );
              RestaurantMenu menu5 = RestaurantMenu(
              id: null,
              resId: m.id,
              imagePath: 'images/sisig.jpg',
              name: 'Sisig',
              reviews: 'No Reviews',
              descriptions: AppCommons.lorem,
              price: 150
            );
            menuList.add(menu1);
            menuList.add(menu2);
            menuList.add(menu3);
            menuList.add(menu4);
            menuList.add(menu5);
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
        child: Center(
        child: Text(
            AppCommons.appName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppCommons.white,
              fontSize: 22
            ),
        ),
      ),
      ),
    );
  }

}