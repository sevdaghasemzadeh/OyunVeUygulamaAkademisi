import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:istanbul/helper/helper_function.dart';
import 'package:istanbul/pages/auth/login_page.dart';
import 'package:istanbul/pages/home_page.dart';
import 'package:istanbul/shared/constants.dart';

void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
    
    class MyApp extends StatefulWidget {
      const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedin = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedinStatus();
  }

  getUserLoggedinStatus() async {
await HelperFunctions.getUserLoggedinStatus().then((value){
  if(value!=null){
_isSignedin = value;
  }
});
  }

      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          theme: ThemeData(
            primaryColor: Constants().primaryColor,
            scaffoldBackgroundColor: Colors.white
          ),
          debugShowCheckedModeBanner: false,
          home: _isSignedin ? const HomePage () : const LoginPage(),
        );
      }
}


