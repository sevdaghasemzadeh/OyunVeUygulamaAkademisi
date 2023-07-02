import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //reference for our collection
  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection("users");


  //saving the userdata
  Future savingUserData(String fullname, String email) async{
    return await userCollection.doc(uid).set({
      "fullname" : fullname,
      "email" : email,
      "uid" : uid,
    });
  }

  //getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
    await  userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
}