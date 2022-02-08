// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:serensic_sale/backend/database.dart';
import 'package:serensic_sale/screens/home/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:serensic_sale/database/database.dart';

class CheckinPage extends StatefulWidget {
  const CheckinPage({Key? key}) : super(key: key);

  @override
  _CheckinPageState createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> {
  final _companyNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  final _hostNameController = TextEditingController();
  final _reasonController = TextEditingController();

  String? _longitude;
  String? _latitude;
  String? _checkInTime;
  String? _checkOutTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  title: Center(
                    child: Text(
                      "Visit Detail",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  subtitle: Center(
                    child: Text("Please Enter Visit Details"),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: TextField(
                    controller: _companyNameController,
                    decoration: InputDecoration(
                      label: Text("Company Name"),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: TextField(
                    controller: _hostNameController,
                    decoration: InputDecoration(
                      label: Text("Host Name"),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: TextField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      label: Text("Phone Number"),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: TextField(
                    controller: _reasonController,
                    decoration: InputDecoration(
                      label: Text("Reason for Visit"),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                    child: Text("Check In"),
                    onPressed: () async {
                      // getLocation();

                      await _getLocation();

                      //getting the shared preference UID saved to add it to the database
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      var obtainedUID = prefs.getString("UID");

                      setState(() {
                        finalUID = obtainedUID;
                      });

                      // .then((value) {});
                      Provider.of<Database>(context, listen: false)
                          .creatVisit(
                        hostName: _hostNameController.text,
                        companyName: _companyNameController.text,
                        phoneNumber: _phoneNumberController.text,
                        latiTude: _latitude.toString(),
                        longiTude: _longitude.toString(),
                        checkInTime: _checkInTime.toString(),
                        reason: _reasonController.text,
                        UID: finalUID,
                      )
                          .then((value) {
                        _hostNameController.clear();
                        _companyNameController.clear();
                        _phoneNumberController.clear();
                        _reasonController.clear();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MyHomePage();
                            },
                          ),
                        );
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                // Container(
                //   height: MediaQuery.of(context).size.height * 0.1,
                //   child: Column(
                //     children: [
                //       Text(
                //         "Latitude: $_latitude",
                //         style: TextStyle(fontSize: 20),
                //       ),
                //       Text(
                //         "Longitude: $_longitude",
                //         style: TextStyle(fontSize: 20),
                //       ),
                //       Text(
                //         "Time Stamp: $_checkInTime",
                //         style: TextStyle(fontSize: 20),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? finalUID;

  Future getValidationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var obtainedUID = prefs.getString("UID");

    setState(() {
      finalUID = obtainedUID;
    });
  }

  Future<LocationData?> _getLocation() async {
    Location location = Location();
    LocationData _locationData;

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();

    setState(() {
      _latitude = _locationData.latitude.toString();
      _longitude = _locationData.longitude.toString();
      _checkInTime = DateTime.now().toString();
    });

    return _locationData;
  }
}
