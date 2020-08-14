import 'dart:io';
import 'package:food_delivery_ui_challenge/model/notification-m.dart';
import 'package:food_delivery_ui_challenge/model/favorite.dart';
import 'package:food_delivery_ui_challenge/model/food-order.dart';
import 'package:food_delivery_ui_challenge/model/restaurant-m.dart';
import 'package:food_delivery_ui_challenge/model/restaurant-menu.dart';
import 'package:food_delivery_ui_challenge/model/review.dart';
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
  static const NOTIFICATIONS = "NOTIFICATION";
  static const TBL_REVIEWS = "REVIEWS";
  //*Common Columns
  static const String ID = "id";
  static const String USER_ID = "userId";
  static const String NAME = "name";
  static const PRICE = "price";
  static const DESCRIPTION = "description";
  static const RATINGS = "ratings";
  static const REVIEWS = "reviews";
  static const IMG_PATH = "imagePath";
  static const UPD_DT = "updDt";
  //*[USER] - Column/s
  static const USERNAME = "username";
  //*[FAVORITE] - Column/s - declared in Common Columns
  //*[FOOD ORDER] - Column/s
  static const String RESTAURANT_MENU_ID = "restaurantMenuId";
  static const String QUANTITY = "quantity";
  static const String RESTAURANT_NAME = "restaurantName";
  //*[RESTAURANT_MENUT] Column/s
  static const String RES_ID = "resId";
  //*NOTIFICATION COLUMNS
  static const String STATUS = "status";
  static const String MESSAGE = "message";
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
    var db = await openDatabase(path, version:10, onCreate:_onCreate);
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
                                  $RES_ID INTEGER,
                                  $RESTAURANT_MENU_ID INTEGER,
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
                                 $NAME TEXT,
                                 $RESTAURANT_NAME TEXT,
                                 $RESTAURANT_MENU_ID INT,
                                 $RES_ID INT,
                                 $QUANTITY INT,
                                 $PRICE DOUBLE
                                 ) """;
    String notificationTable = """
      $CREATE_TABLE $NOTIFICATIONS(
        $ID INTEGER PRIMARY KEY,
        $USER_ID INT,
        $MESSAGE TEXT,
        $STATUS TEXT,
        $UPD_DT DATETIME
      )
    """;
    String reviewsTable = """
    $CREATE_TABLE $TBL_REVIEWS(
      $ID INTEGER PRIMARY KEY,
      $USER_ID INT,
      $RESTAURANT_MENU_ID INT,
      $REVIEWS TEXT,
      $UPD_DT DATETIME
    )
    """;
    await db.execute(usertable);
    await db.execute(favoriteTable);
    await db.execute(restaurantTable);
    await db.execute(restaurantMenuTable);
    await db.execute(foodOrderTable);
    await db.execute(notificationTable);
    await db.execute(reviewsTable);
  }

  //CREATE USER
  Future<User> createUserAccount(User user)async{
     var dbClient = await db;
     user.id = await dbClient.insert(USER, user.toMap());
     return user;
  }
  Future<NotificationM>createNotif(NotificationM notif)async{
     var dbClient = await db;
     notif.id = await dbClient.insert(NOTIFICATIONS, notif.toMap());
     return notif;
  }
  Future<Review>createReview(Review review)async{
     var dbClient = await db;
     review.id = await dbClient.insert(TBL_REVIEWS, review.toMap());
     return review;
  }
  Future<List<NotificationM>>getNotifListByUserId(int userId)async{
      print("getAllNotifByUserId | START");
    var dbClient = await db;
      List<Map> map =
       await dbClient.query(NOTIFICATIONS, columns:[
          ID,USER_ID,MESSAGE,STATUS,UPD_DT
       ],where: "$USER_ID = ?",whereArgs: [userId,"R"],orderBy: "id DESC");
     
     List<NotificationM> notifs = [];
      if(map.length > 0){
        for(int i = 0; i < map.length; i++){
          notifs.add(NotificationM.fromMap(map[i]));
        }
      }
    print("getAllNotifByUserId | END");
    return notifs;
  }
  Future<bool>updateNotifStatusByUserId(int userId)async{
    var dbClient = await db;
    int result = await dbClient.rawUpdate("""
      UPDATE $NOTIFICATIONS SET $STATUS = 'R' WHERE $USER_ID = '$userId'
    """);
    return (result > 0);
  }
  Future<int> deleteNotifById(int id)async{
    var dbClient = await db;
     return await dbClient.delete(NOTIFICATIONS, where: "$ID = ?", whereArgs: [id]);
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
  Future<RestaurantMenu>getFoodDetailsByResId(int resId)async{
     var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $RESTAURANT_MENU where $RES_ID = '$resId'");
   return (result.length > 0)? RestaurantMenu.fromMap(result.first):null;
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
Future<List<RestaurantMenu>>searchRestaurantsMenuByName(String name)async{
  var dbClient = await db;
  print("TESTESTES");
    List<Map> map = await dbClient.query(RESTAURANT_MENU,
        columns: [
          ID,RES_ID,IMG_PATH, NAME, REVIEWS, DESCRIPTION,PRICE
        ],where: "NAME LIKE ?",whereArgs: ['%'+name+'%'], orderBy: "$NAME ASC"
    );
    List<RestaurantMenu> res = [];
    if(map.length > 0){
      for(int i = 0; i < map.length; i++){
        res.add(RestaurantMenu.fromMap(map[i]));
      }
    }
    return res;
}

  Future<List<RestaurantMenu>>getRestaurantMenuByResId(int resId)async{
   var dbClient = await db;
    List<Map> map = await dbClient.query(RESTAURANT_MENU,
        columns: [
          ID,RES_ID,IMG_PATH, NAME, REVIEWS, DESCRIPTION,PRICE
        ],where:"$RES_ID = ?",whereArgs:[resId],orderBy: "$NAME ASC"
    );
    List<RestaurantMenu> res = [];
    if(map.length > 0){
      for(int i = 0; i < map.length; i++){
        res.add(RestaurantMenu.fromMap(map[i]));
      }
    }
    return res;
  }
   Future<List<RestaurantMenu>>getRestaurantMenu()async{
   var dbClient = await db;
    List<Map> map = await dbClient.query(RESTAURANT_MENU,
        columns: [
          ID,RES_ID,IMG_PATH, NAME, REVIEWS, DESCRIPTION,PRICE
        ],orderBy: "$NAME ASC"
    );
    List<RestaurantMenu> res = [];
    if(map.length > 0){
      for(int i = 0; i < map.length; i++){
        res.add(RestaurantMenu.fromMap(map[i]));
      }
    }
    return res;
  }
  Future<List<FoodOrder>>orderedFoodByUserId(int userId)async{
     var dbClient = await db;
    List<Map> map = await dbClient.query(FOOD_ORDER,
        columns: [
          ID,USER_ID,NAME,RESTAURANT_NAME,RESTAURANT_MENU_ID,RES_ID, QUANTITY,PRICE
        ],where: "$USER_ID = ?",whereArgs: [userId]
    );
    List<FoodOrder> res = [];
    if(map.length > 0){
      for(int i = 0; i < map.length; i++){
        res.add(FoodOrder.fromMap(map[i]));
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
  Future<int>initRestaurantMenu(RestaurantMenu menu)async{
     var dbClient = await db;
     var result = 0;
     print("HELLO");
     result = await dbClient.insert(RESTAURANT_MENU, menu.toMap());
     return result;
  }

  Future<bool> checkFoodIfExist(int userId, int resMenuId, int resId)async{
    var dbClient = await db;
     var result = await dbClient.rawQuery("SELECT * FROM $FOOD_ORDER where $USER_ID = '$userId' AND $RESTAURANT_MENU_ID = '$resMenuId' AND $RES_ID = '$resId'");
    return (result.length > 0);
  }
  Future<int> orderedCount(int userId)async{
 var dbClient = await db;
     var result = await dbClient.rawQuery("SELECT * FROM $FOOD_ORDER where $USER_ID = '$userId'");
    return result.length;
  }
  Future<int>notificationCount(int userId)async{
    var dbClient = await db;
     var result = await dbClient.rawQuery("SELECT * FROM $NOTIFICATIONS where $USER_ID = '$userId' AND $STATUS = 'U'");
    return result.length;
  }
  Future<FoodOrder> createFoodOrder(FoodOrder order)async{
      var dbClient = await db;
      print("createFoodOrder");
      print(order.resId);
     order.id = await dbClient.insert(FOOD_ORDER, order.toMap());
     return order;
  }
  Future<int> removeFoodOrder(int userId,int resMenuId, int resId)async{
       var dbClient = await db;
     return await dbClient.delete(FOOD_ORDER, where: "$USER_ID = ? AND $RESTAURANT_MENU_ID = ? AND $RES_ID = ?", whereArgs: [userId,resMenuId,resId]);
  }
    Future<int> removeFoodOrderByUserId(int userId)async{
       var dbClient = await db;
     return await dbClient.delete(FOOD_ORDER, where: "$USER_ID = ? ", whereArgs: [userId]);
  }
  Future<bool>checkIfFavoriteExist(int resMenuId,int resId,int userId)async{
     var dbClient = await db;
     var result = await dbClient.rawQuery("SELECT * FROM $FAVORITE where  $RES_ID = '$resId' AND $RESTAURANT_MENU_ID = '$resMenuId' AND $USER_ID = '$userId'");
    return (result.length > 0);
  }
  Future<Favorite>addToFavorite(Favorite favorite)async{
     var dbClient = await db;
     favorite.id = await dbClient.insert(FAVORITE, favorite.toMap());
     return favorite;
  }
  Future<int> removeFavorite(int resId,int resMenuId,int userId)async{
    var dbClient = await db;
     return await dbClient.delete(FAVORITE, where: "$RES_ID = ? AND $RESTAURANT_MENU_ID = ? AND $USER_ID = ?", whereArgs: [resId, resMenuId,userId]);
  }
  Future<int> favoriteCount(int userId)async{
    var dbClient = await db;
     var result = await dbClient.rawQuery("SELECT * FROM $FAVORITE  WHERE $USER_ID = '$userId'");
    return result.length;
  }
}