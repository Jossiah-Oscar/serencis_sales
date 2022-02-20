// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serensic_sale/backend/database.dart';
import 'package:serensic_sale/model/company.dart';
import 'package:serensic_sale/screens/checkin/checkin.dart';
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
                  }),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.0,
              // ),

              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.88,
                // color: Colors.amberAccent,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CheckinPage();
                            },
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width * 0.4,
                          // color: Colors.red,
                          child: Card(
                            elevation: 7.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check,
                                  size: 80,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                Text(
                                  "Check In",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return VisitsPage();
                            },
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width * 0.4,
                          // color: Colors.red,
                          child: Card(
                            elevation: 7.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.map,
                                  size: 80,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                Text(
                                  "Visits",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  "FOR ADMINS ONLY",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                // color: Colors.amberAccent,
                child: Column(
                  children: [
                    FutureBuilder<f_User.User?>(
                        future: readUser(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final user = snapshot.data;
                            return ListTile(
                                title: Center(
                              child: Text("${user!.name}'s  Recent Visits"),
                            ));
                          } else if (snapshot.hasError) {
                            return Text("Opps Somethings Went Wrong");
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                    StreamBuilder<List<Visit>>(
                        stream: Provider.of<Database>(context, listen: false)
                            .readRecentVisits(finalUID),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final _recentVisits = snapshot.data!;

                            return Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.342,
                              // color: Colors.red,
                              child: ListView.builder(
                                  itemCount: _recentVisits.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: ListTile(
                                        // tileColor: Colors.lightBlueAccent,
                                        title: Text(
                                            "${_recentVisits[index].companyName}"),
                                        subtitle: Text(
                                            "Reason for visit: ${_recentVisits[index].reason}\nLocation: ${_recentVisits[index].streetName}"),

                                        trailing: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: _recentVisits[index]
                                                          .checkOutTime ==
                                                      null
                                                  ? Colors.red
                                                  : Colors.green),
                                          onPressed: () async {
                                            String? docID =
                                                _recentVisits[index].documentID;

                                            if (_recentVisits[index]
                                                    .checkOutTime ==
                                                null) {
                                              await Provider.of<Database>(
                                                      context,
                                                      listen: false)
                                                  .checkOut(
                                                      DateTime.now().toString(),
                                                      docID);

                                              // print(_recentVisits[index]
                                              //     .checkOutTime);
                                            } else {
                                              Center(
                                                child: Text(
                                                    "This location has been checked out"),
                                              );
                                            }
                                          },
                                          child: _recentVisits[index]
                                                      .checkOutTime ==
                                                  null
                                              ? Text(
                                                  "Check Out",
                                                )
                                              : Text(
                                                  "Checked Out",
                                                ),
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          } else if (snapshot.hasError) {
                            return Text("Opps Something Went Wrong");
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ],
                ),
              )
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
