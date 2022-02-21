// ignore_for_file: invalid_required_positional_param, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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
    streetName,
    reason,
    checkInTime,
    UID,
    openingStock,
    closingStock,
  }) async {
    String docId = FirebaseFirestore.instance.collection("Visits").doc().id;
    Visit visit = Visit(
      companyName: companyName,
      number: phoneNumber,
      hostName: hostName,
      streetName: streetName,
      reason: reason,
      checkInTime: checkInTime,
      uID: UID,
      documentID: docId,
      openingStock: openingStock,
      closingStock: closingStock,
      picture: [],
    );

    var data = visit.toJson();
    await visitCollection.doc(docId).set(data).whenComplete(() {
      if (kDebugMode) {
        print("Visit Data Added with $docId");
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

    var setDoc = await documentReferencer.set(data).whenComplete(() {
      if (kDebugMode) {
        print("User data added");
      }
    }).catchError((e) {
      if (kDebugMode) {
        print(e);
      }
    });
  }

  checkOut(@required String checkOutTime, docID) async {
    await visitCollection.doc(docID).update(
      {
        'CheckOutTime': checkOutTime,
      },
    );
  }

  Stream<List<Visit>> readRecentVisits(String? PrefUID) {
    Stream<List<Visit>> recentVisits = FirebaseFirestore.instance
        .collection('Visits')
        .where('UID', isEqualTo: PrefUID)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Visit.fromJson(doc.data())).toList());

    return recentVisits;
  }

  Stream<List<Visit>> readVisits() {
    Stream<List<Visit>> visits = FirebaseFirestore.instance
        .collection("Visits")
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Visit.fromJson(doc.data())).toList());

    return visits;
  }

  //Testing

}
