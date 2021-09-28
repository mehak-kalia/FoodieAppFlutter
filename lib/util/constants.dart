import 'package:flutter_trial/model/user.dart';


// final String APP_NAME = "Foodie";
// final String USERS_COLLECTION = "users";
// final String RESTAURNAT_COLLECTION = "restaurants";
// final String DISHES_COLLECTION = "dishes";
// AppUser? user;

class Util {
  static String APP_NAME = "Foodie";
  static String USERS_COLLECTION = "users";
  static String RESTAURANT_COLLECTION = "restaurants";
  static String DISHES_COLLECTION = "dishes";
  static String CART_COLLECTION = "cart";
  static String ADDRESS_COLLECTION = "addresses";
  static String EXTRA_COLLECTION = "extras";
  static String ORDER_COLLECTION = "orders";
  static AppUser? appUser;
  static Map total={};
  static bool checkpath=false;
  static String filter="all";
  static List filterlist=["all"];
  static String const_chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
}

class Locale{

  static populateMap(){
    englishLocaleMap['appTitle'] = "Foodie";
    englishLocaleMap['register'] = "Register";

    hindiLocaleMap['appTitle'] = "खाने का शौकीन";
    hindiLocaleMap['register'] = "रजिस्टर करें";
  }

  static Map<String, String> englishLocaleMap = new Map<String, String>();
  static Map<String, String> hindiLocaleMap = new Map<String, String>();
  static int localeType = 2;
  static Map<String, String> locale = hindiLocaleMap;
}