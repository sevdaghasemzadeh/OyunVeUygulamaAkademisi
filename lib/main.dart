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
        primarySwatch: color,
        scaffoldBackgroundColor: Colors.white,

      ),
      debugShowCheckedModeBanner: false,
      home: _isSignedin ? const HomePage () : const LoginPage(),
    );
  }
}

MaterialColor color = const MaterialColor(0xFFF69906, {
  50: Color(0xFFFFF6E0),
  100: Color(0xFFFFE6B3),
  200: Color(0xFFFFD180),
  300: Color(0xFFFFBF4D),
  400: Color(0xFFFFB536),
  500: Color(0xFFF69906),
  600: Color(0xFFCC8005),
  700: Color(0xFF996003),
  800: Color(0xFF664002),
  900: Color(0xFF332001),
});

