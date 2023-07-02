import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:istanbul/helper/helper_function.dart';
import 'package:istanbul/pages/auth/login_page.dart';
import 'package:istanbul/pages/home_page.dart';
import '../service/auth_service.dart';
import '../widgets/widgets.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullname ="";
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(49,49,49,1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(246,153,6,1),
      ),
      body: _isLoading? Center(child: CircularProgressIndicator(color: Color.fromRGBO(246,153,6,1))) :
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80 ) ,
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  const Text("Create your account now!",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400, color: Color.fromRGBO(246,153,6,1),)
                    ,),

                  const SizedBox(height: 90),
                  TextFormField(
                    decoration: textinputDecoration.copyWith(

                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide (width: 3, color: Color.fromRGBO(246,153,6,1),
                            )
                        ),
                        labelText: "Full Name",
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color.fromRGBO(246,153,6,1),
                        )
                    ),
                    onChanged: (val){
                      fullname = val;
                    },
                    validator: (val){
                      if(val!.isNotEmpty){
                        return null;
                      }
                      else{
                        return "This field cannot be empty";
                      }
                    },
                  ),
                  const SizedBox(height: 15,),
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
                        child: const Text("Sign İn",
                          style: TextStyle(
                              color: Color.fromRGBO(49,49,49,1),
                              fontSize: 16
                          ),
                        ), onPressed: (){
                        register();
                      },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text.rich(TextSpan(
                    text: "Already have an account?",
                    style: const TextStyle(
                        color: Color.fromRGBO(246,153,6,1),
                        fontSize: 14),
                    children:<TextSpan>[
                      TextSpan(
                          text: " Log in Now",
                          style: const TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            nextScreen(context, const LoginPage());
                          }),
                    ],
                  )),
                ],
              )),
        ),
      ),
    );

  }
  register() async {
    if(formKey.currentState!.validate()){
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailAndPassword(fullname, email, password)
          .then((value) async {
        if (value == true){
          //saving the shared peference state
          await HelperFunctions.saveUserLoggedinStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(fullname);
          nextScreenReplace(context, const HomePage());
        } else {
          showSnackBar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}