import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {

  //key
  static String userLoggedinKey = "LOGGEDİNKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USERMAİLKEY";

  //saving data


  //getting data
static Future<bool?> getUserLoggedinStatus() async{
  SharedPreferences sf = await SharedPreferences.getInstance();
  return sf.getBool(userLoggedinKey);
}
}