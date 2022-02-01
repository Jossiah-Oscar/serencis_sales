// ignore_for_file: invalid_required_positional_param

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;

class Database extends ChangeNotifier {
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
    CollectionReference topic = FirebaseFirestore.instance.collection("Visits");

    try {
      await topic.add(
        {
          "Company Name": companyName,
          "Phone Number": phoneNumber,
          "Host Name": hostName,
          "Reason": reason,
          "Longitude": longiTude,
          "Latitude": latiTude,
          "CheckInTime": checkInTime,
          "CheckOutTime": checkOutTime,
          "UID": ""
        },
      );
    } catch (e) {
      print(e);
    }
  }

  notifyListeners();
}
