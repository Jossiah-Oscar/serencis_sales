// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:serensic_sale/backend/database.dart';
import 'package:serensic_sale/screens/home/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart' as address;
// import 'package:serensic_sale/database/database.dart';

class CheckinPage extends StatefulWidget {
  const CheckinPage({Key? key}) : super(key: key);

  @override
  _CheckinPageState createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> {
  final _companyNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _openingStockController = TextEditingController();
  final _closingStockController = TextEditingController();

  final _hostNameController = TextEditingController();
  final _reasonController = TextEditingController();

  double? _longitude2 = 0;
  double? _latitude2 = 0;
  String? _checkInTime;

  String? _streetName;

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
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
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
                      controller: _openingStockController,
                      decoration: InputDecoration(
                        label: Text("Opening Stock"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: TextField(
                      controller: _closingStockController,
                      decoration: InputDecoration(
                        label: Text("Closing Stock"),
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
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Card(
                          elevation: 5.0,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.45,
                            // color: Colors.amberAccent,
                            child: image != null
                                ? Image.file(image!)
                                : Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _imgFromCamera();
                                      },
                                      child: Text("Opening Stock Image"),
                                    ),
                                  ),
                          ),
                        ),
                        Card(
                          elevation: 5.0,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.45,
                            // color: Colors.amberAccent,
                            child: image1 != null
                                ? Image.file(image!)
                                : Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _imgFromCamera1();
                                      },
                                      child: Text("Closing Stock Image"),
                                    ),
                                  ),
                          ),
                        ),
                      ],
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
                        List<address.Placemark> placemarks =
                            await address.placemarkFromCoordinates(
                                _latitude2!, _longitude2!);
                        setState(() {
                          _streetName = placemarks[0].street;
                        });

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
                          streetName: _streetName,
                          checkInTime: _checkInTime.toString(),
                          reason: _reasonController.text,
                          UID: finalUID,
                          openingStock: _openingStockController.text,
                          closingStock: _closingStockController.text,
                          result: image,
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
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     await _getLocation();
                  //     List<address.Placemark> placemarks = await address
                  //         .placemarkFromCoordinates(_latitude2!, _longitude2!);

                  //     print(
                  //         "${placemarks[0].street} + ${placemarks[1].street} + ${placemarks[2].street} + ${placemarks[3].street} + ${placemarks[4].street}");
                  //     setState(() {
                  //       _streetName = placemarks[0].street;
                  //     });
                  //   },
                  //   child: Text("${_checkInTime}"),
                  // ),
                ],
              ),
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
      _longitude2 = _locationData.longitude;
      _latitude2 = _locationData.latitude;
      _checkInTime = DateTime.now().minute.toString();
    });

    return _locationData;
  }

  File? image;
  File? image1;

  _imgFromCamera() async {
    final images = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    final File? tempImage = File(images!.path);

    setState(() {
      print(images.name);
      this.image = tempImage;
    });
  }

  _imgFromCamera1() async {
    final images = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    final File? tempImage = File(images!.path);

    setState(() {
      this.image1 = tempImage;
    });
  }
}
