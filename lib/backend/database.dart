// ignore_for_file: invalid_required_positional_param

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:serensic_sale/model/company.dart';
import 'package:serensic_sale/model/user.dart';

class Database extends ChangeNotifier {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference visitCollection =
      FirebaseFirestore.instance.collection("Visits");

  Future creatVisit({
    companyName,
    phoneNumber,
    hostName,
    longiTude,
    latiTude,
    reason,
    checkInTime,
    checkOutTime,
  }) async {
    Visit visit = Visit(
      companyName: companyName,
      number: phoneNumber,
      hostName: hostName,
      longitude: longiTude,
      latitude: latiTude,
      reason: reason,
      checkInTime: checkInTime,
      checkOutTime: checkOutTime,
    );

    var data = visit.toJson();
    await visitCollection.doc().set(data).whenComplete(() {
      if (kDebugMode) {
        print("Visit Data Added");
      }
    }).catchError((e) {
      if (kDebugMode) {
        print(e);
      }
    });
  }

  storeUserData({required String userName, userRole, userEmail, uID}) async {

    DocumentReference documentReferencer = userCollection.doc(uID);

    User user = User(
      uID: uID,
      name: userName,
      present: true,
      role: "User",
      email: userEmail,
    );

    var data = user.toJson();

    await documentReferencer.set(data).whenComplete(() {
      print("User data added");
    }).catchError((e) {
      print(e);
    });
  }

  getUserData() async{
    
  }
}
