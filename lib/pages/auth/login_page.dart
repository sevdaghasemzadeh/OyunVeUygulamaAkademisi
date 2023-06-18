import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:istanbul/pages/RegistrationPage.dart';
import 'package:istanbul/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(49,49,49,1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(246,153,6,1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80 ) ,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                SizedBox(child: Image.asset("assets/mult.png"), height: 200, width: 200,),

                const SizedBox(height: 90),
                TextFormField(
                  decoration: textinputDecoration.copyWith(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide (width: 3, color: Color.fromRGBO(246,153,6,1),
                          )
                      ),
                    labelText: "Email",
                    prefixIcon: Icon(
                        Icons.email,
                        color: Color.fromRGBO(246,153,6,1),
                    )
                  ),
                  onChanged: (val){
                    email = val;
                  },
                  validator: (val){
                    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!) ? null : "Please enter a valid email";
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  obscureText: true,
                  decoration: textinputDecoration.copyWith(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide (width: 3, color: Color.fromRGBO(246,153,6,1),
                        )
                    ),
                      labelText: "Password",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color.fromRGBO(246,153,6,1)
                      ),
                  ),
                  validator: (val){
                    if(val!.length<6){
                      return"Your password must be at least 6 characters";
                    }
                  },
                  onChanged: (val){
                    password= val;
                  },

                ),
               const SizedBox(height: 20,),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(246,153,6,1),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                        )
                      ),
                      child: const Text("Log İn",
                      style: TextStyle(
                          color: Color.fromRGBO(49,49,49,1),
                        fontSize: 16
                      ),
                      ), onPressed: (){
                        login();
                    },
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Text.rich(TextSpan(
                  text: "Don't have an account?",
                    style: const TextStyle(
                      color: Color.fromRGBO(246,153,6,1),
                      fontSize: 14),
                  children:<TextSpan>[
                    TextSpan(
                      text: " Register Here",
                      style: const TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        nextScreen(context, const RegistrationPage());
                      }
                    )
                  ],
                  ),
                )
              ],
            ),
          ),
        ),
      ) ,
    );

  }
  login(){
    if (formKey.currentState!.validate()){

    }
  }
}
