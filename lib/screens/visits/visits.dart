// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:serensic_sale/model/company.dart';

class VisitsPage extends StatefulWidget {
  const VisitsPage({Key? key}) : super(key: key);

  @override
  _VisitsPageState createState() => _VisitsPageState();
}

class _VisitsPageState extends State<VisitsPage> {
  bool _customTileExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: StreamBuilder<List<Visit>>(
          stream: readVisits(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            } else if (snapshot.hasData) {
              final visits = snapshot.data!;

              return Container(
                height: MediaQuery.of(context).size.height * 1,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: visits.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ExpansionTile(
                          title: Text(visits[index]
                              .companyName
                              .toString()
                              .toUpperCase()),
                          subtitle: Text(visits[index]
                              .streetName
                              .toString()
                              .toUpperCase()),
                          trailing: Icon(
                            _customTileExpanded
                                ? Icons.arrow_drop_down_circle
                                : Icons.arrow_drop_down,
                          ),
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                "Host Name: ${visits[index].hostName}",
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "Check In Time: ${visits[index].checkInTime}",
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "Check Out Time: ${visits[index].checkOutTime}",
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "Phone Number: ${visits[index].checkInTime}",
                              ),
                            ),
                          ],
                          onExpansionChanged: (bool expanded) {
                            setState(() => _customTileExpanded = expanded);
                          },
                        ),
                        // ListTile(
                        // title: Text(
                        //   visits[index].companyName.toString().toUpperCase(),
                        //   ),
                        //   subtitle: Text(
                        //       "Visit Location: ${visits[index].streetName}"),
                        // ),
                      );
                    }),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Stream<List<Visit>> readVisits() {
    Stream<List<Visit>> visits = FirebaseFirestore.instance
        .collection("Visits")
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Visit.fromJson(doc.data())).toList());

    return visits;
  }
}
