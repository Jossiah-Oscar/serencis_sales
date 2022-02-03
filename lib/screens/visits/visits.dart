// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<List<Visit>>(
          future: readVisits().first,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            } else if (snapshot.hasData) {
              final visits = snapshot.data!;

              return Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: visits.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            visits[index].companyName.toString().toUpperCase(),
                          ),
                          subtitle: Text(
                              "Reason for visit: ${visits[index].reason.toString()}"),
                        ),
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
