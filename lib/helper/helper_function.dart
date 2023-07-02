import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {

  //key
  static String userLoggedinKey = "LOGGEDİNKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USERMAİLKEY";

  //saving data
  static Future<bool> saveUserLoggedinStatus (bool isUserLoggedin) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedinKey, isUserLoggedin);
  }

  static Future<bool> saveUserNameSF (String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, userName);
  }

  static Future<bool> saveUserEmailSF (String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail );
  }

  //getting data
  static Future<bool?> getUserLoggedinStatus() async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedinKey);
  }
}