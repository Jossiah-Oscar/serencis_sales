// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serensic_sale/backend/database.dart';
import 'package:serensic_sale/model/company.dart';
import 'package:serensic_sale/screens/checkin/checkin.dart';
import 'package:serensic_sale/screens/home/homePageCards.dart';
import 'package:serensic_sale/screens/home/userRecentVisit.dart';
import 'package:serensic_sale/screens/visits/visits.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:serensic_sale/model/user.dart' as f_User;

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String checkOutTime = DateTime.now().toString();
  bool isCheckedOut = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(""),
      // ),
      body: SafeArea(
        child: Center(
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              // ignore: prefer_const_constructors

              FutureBuilder<f_User.User?>(
                future: readUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final user = snapshot.data;

                    return ListTile(
                      leading: Icon(Icons.menu),
                      title: Text(
                        "Welcome Back",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      subtitle: Text(
                        user!.name.toString(),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      trailing: Card(
                        child: TextButton(
                          child: Text(
                            "Logout",
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.remove("UID").then((value) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return CheckinPage();
                                  },
                                ),
                              );
                            });
                          },
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Something went wrong");
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.0,
              // ),

              HomePageCards(),
              UserRecentVisit(
                finalUID: finalUID,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? finalUID;

  Stream<List<Visit>> readVisits() {
    Stream<List<Visit>> visits = FirebaseFirestore.instance
        .collection("Visits")
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Visit.fromJson(doc.data())).toList());

    return visits;
  }

  Future<f_User.User?> readUser() async {
    //getting the saved shared Preference UID
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var obtainedUID = prefs.getString("UID");

    setState(() {
      finalUID = obtainedUID;
    });

    //Using the acquired UID to retrive the correct user document
    final docUser =
        FirebaseFirestore.instance.collection("Users").doc(finalUID);
    final snapshot = await docUser.get();

    // f_User.User user = f_User.User.fromJson(snapshot.data());

    if (snapshot.exists) {
      return f_User.User.fromJson(snapshot.data()!);
    }
    // return user;
  }
}
