import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../service/auth_service.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(
            color:  Color.fromRGBO(77,76,84,1),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<dynamic> dataList = snapshot.data!;
          return Scaffold(
            backgroundColor: const Color.fromRGBO(211,207,199,1),
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(215,151,94,1),
            ),
            body: Center(
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                const Divider(
                  color: Color.fromRGBO(77,76,84,1),
                ),
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  dynamic data = dataList[index];
                  return ListTile(
                    title: Text(
                      data.toString(),
                      style: TextStyle(
                        color: Color.fromRGBO(77,76,84,1),
                        fontSize: 25,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }

  Future<List<dynamic>> fetchData() async {
    List<dynamic> calculations = [];
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference userRef = FirebaseFirestore.instance.collection('calculations').doc(uid);
    DocumentSnapshot userSnapshot = await userRef.get();
    if (userSnapshot.exists) {
      Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;
      if (userData != null && userData.containsKey('calculations')) {
        List<dynamic> calculations = userData['calculations'];
        return calculations;
      } else {
        ;
        return calculations;
      }
    } else {
      return calculations;
    }
  }
}
