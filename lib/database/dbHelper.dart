import 'dart:io';
import 'package:food_delivery_ui_challenge/model/restaurant-m.dart';
import 'package:food_delivery_ui_challenge/model/restaurant-menu.dart';
import 'package:food_delivery_ui_challenge/model/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{
  static Database _db;
  //*Database Name
  static const DB_NAME = "FOOD_DELIVERY.db";
  //*Tables
  static const USER = "USER";
  static const FAVORITE = "FAVORITE";
  static const FOOD_ORDER = "FOOD_ORDER";
  static const RESTAURANT = "RESTAURANT";
  static const RESTAURANT_MENU = "RESTAURANT_MENU";
  //*Common Columns
  static const String ID = "id";
  static const String USER_ID = "user_id";
  static const String NAME = "name";
  static const PRICE = "price";
  static const DESCRIPTION = "description";
  static const RATINGS = "ratings";
  static const REVIEWS = "reviews";
  static const IMG_PATH = "imgPath";
  //*[USER] - Column/s
  static const USERNAME = "username";
  //*[FAVORITE] - Column/s - declared in Common Columns
  //*[FOOD ORDER] - Column/s
  static const String RESTAURANT_MENU_ID = "restaurantMenuId";
  static const String QUANTITY = "quantity";
  //*[RESTAURANT_MENUT] Column/s
  static const String RES_ID = "resId";
  //* CREATE TABLE TEMPLATE
  static const CREATE_TABLE = " CREATE TABLE ";
  Future<Database> get db async{
    if(_db != null){
      return _db;
    }
    _db = await _initDb();
    return _db;
  }
  
  _initDb() async{
    Directory docDirectory = await getApplicationSupportDirectory();
    String path = join(docDirectory.path,DB_NAME);
    var db = await openDatabase(path, version:3, onCreate:_onCreate);
    return db;
  }

  _onCreate(Database db, int version)async{
      String usertable = """$CREATE_TABLE $USER(
                                      $ID INTEGER PRIMARY KEY,
                                      $USERNAME TEXT
                        )""";
     String favoriteTable = """$CREATE_TABLE $FAVORITE(
                                  $ID INTEGER PRIMARY KEY,
                                  $USER_ID INTEGER,
                                  $NAME TEXT,
                                  $PRICE DOUBLE
                             )""";
     String restaurantTable = """$CREATE_TABLE $RESTAURANT(
                                $ID INTEGER PRIMARY KEY,
                                $NAME TEXT,
                                $DESCRIPTION TEXT,
                                $RATINGS DOUBLE,
                                $REVIEWS TEXT,
                                $IMG_PATH TEXT)""";
    String restaurantMenuTable = """$CREATE_TABLE $RESTAURANT_MENU(
                                  $ID INTEGER PRIMARY KEY,
                                  $RES_ID INT,
                                  $IMG_PATH TEXT,
                                  $NAME TEXT,
                                  $REVIEWS TEXT,
                                  $DESCRIPTION TEXT,
                                  $PRICE DOUBLE )""";
    String foodOrderTable = """$CREATE_TABLE $FOOD_ORDER(
                                 $ID INTEGER PRIMARY KEY,
                                 $USER_ID INT,
                                 $RESTAURANT_MENU_ID INT,
                                 $QUANTITY INT) """;
    await db.execute(usertable);
    await db.execute(favoriteTable);
    await db.execute(restaurantTable);
    await db.execute(restaurantMenuTable);
    await db.execute(foodOrderTable);
  }

  //CREATE USER
  Future<User> createUserAccount(User user)async{
     var dbClient = await db;
     user.id = await dbClient.insert(USER, user.toMap());
     return user;
  }
  Future<bool> isUsernameExist(String username)async{
     var dbClient = await db;
     var result = await dbClient.rawQuery("SELECT * FROM $USER where $USERNAME = '$username'");
    return (result.length > 0);
  }
  Future<User> checkLoginCredentialsByUsername(String username)async{
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $USER where $USERNAME = '$username'");
     
    return (result.length > 0)? User.fromMap(result.first):null;
  }
  Future<List<RestaurantM>>getRestaurantList()async{
    var dbClient = await db;
    List<Map> map = await dbClient.query(RESTAURANT,
        columns: [
          ID,NAME,DESCRIPTION, RATINGS, REVIEWS, IMG_PATH
        ],orderBy: "$NAME ASC"
    );
    List<RestaurantM> res = [];
    if(map.length > 0){
      for(int i = 0; i < map.length; i++){
        res.add(RestaurantM.fromMap(map[i]));
      }
    }
    return res;
  }
  Future<int> initRestaurant(List<RestaurantM> reslist) async{
     var dbClient = await db;
     var result = 0;
     for(RestaurantM rest in reslist){
        result = await dbClient.insert(RESTAURANT, rest.toMap());
     }
     return result;
  }
  Future<int>initRestaurantMenu(List<RestaurantMenu> menuList)async{
     var dbClient = await db;
     var result = 0;
     for(RestaurantMenu menu in menuList){
       result = await dbClient.insert(RESTAURANT_MENU, menu.toMap());
     }
     return result;
  }

}