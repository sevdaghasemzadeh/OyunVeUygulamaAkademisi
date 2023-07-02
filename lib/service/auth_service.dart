import 'package:firebase_auth/firebase_auth.dart';
import 'package:istanbul/helper/helper_function.dart';
import 'database_service.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //register
  Future registerUserWithEmailAndPassword (String fullname, String email, String password) async{
    try{
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password)).user!;
      if (user!=null){
        //call our database service to update the user data.
        await DatabaseService(uid: user.uid).savingUserData(fullname, email);
        return true;
      }
    }
    on FirebaseAuthException catch (e){

      return e.message;
    }
  }

//login
  Future loginWithEmailAndPassword (String email, String password) async{
    try{
      User user = (await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password)).user!;
      if (user!=null){
        return true;
      }
    }
    on FirebaseAuthException catch (e){

      return e.message;
    }
  }


//signout

  Future signOut() async {
    try{
      await HelperFunctions.saveUserLoggedinStatus(false);
      await HelperFunctions.saveUserEmailSF("");
      await HelperFunctions.saveUserNameSF("");
      await firebaseAuth.signOut();
    }
    catch(e){
      return null;
    }
  }
}