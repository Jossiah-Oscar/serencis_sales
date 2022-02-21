// ignore_for_file: invalid_required_positional_param, non_constant_identifier_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:serensic_sale/model/company.dart';
import 'package:serensic_sale/model/user.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

class Database extends ChangeNotifier {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference visitCollection =
      FirebaseFirestore.instance.collection("Visits");

  Future creatVisit({
    String? companyName,
    phoneNumber,
    hostName,
    streetName,
    reason,
    checkInTime,
    UID,
    openingStock,
    closingStock,
    File? result,
  }) async {
    if (result != null) {
      String filename = basename(result.path);

      firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('Serensic/$filename');
      final firebase_storage.UploadTask uploadTask = storageRef.putFile(result);
      final firebase_storage.TaskSnapshot downloadUrl = await uploadTask;
      final String mediaLink = (await downloadUrl.ref.getDownloadURL());

      //getting media link and writing it to the database
      if (mediaLink != null) {
        try {
          String docId =
              FirebaseFirestore.instance.collection("Visits").doc().id;
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
            openingStockImage: mediaLink,
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
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      }
    } else {
      return;
    }
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

  checkOut(@required String checkOutTime, docID, File result) async {
    if (result != null) {
      String filename = basename(result.path);

      firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('Serensic/$filename');
      final firebase_storage.UploadTask uploadTask = storageRef.putFile(result);
      final firebase_storage.TaskSnapshot downloadUrl = await uploadTask;
      final String mediaLink = (await downloadUrl.ref.getDownloadURL());

      //getting media link and writing it to the database
      if (mediaLink != null) {
        try {
          await visitCollection.doc(docID).update(
            {
              'CheckOutTime': checkOutTime,
              'Closing Stock Image': mediaLink,
            },
          );
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      }
    } else {
      return;
    }
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
