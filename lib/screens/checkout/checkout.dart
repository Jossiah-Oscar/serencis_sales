// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:serensic_sale/backend/database.dart';
import 'package:serensic_sale/model/company.dart';
import 'package:serensic_sale/screens/home/homepage.dart';

class CheckOutPage extends StatefulWidget {
  Visit visit;
  CheckOutPage({Key? key, required this.visit}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ListTile(
              title: Text("Company Name: "),
              subtitle: Text("${widget.visit.companyName.toString()}"),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            ListTile(
              title: Text("Host Name:"),
              subtitle: Text("${widget.visit.hostName.toString()}"),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            ListTile(
              title: Text("Phone Number:"),
              subtitle: Text("${widget.visit.number.toString()}"),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            ListTile(
              title: Text("Opening Stock: "),
              subtitle: Text("${widget.visit.openingStock.toString()}"),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            ListTile(
              title: Text("Closing Stock:"),
              subtitle: Text("${widget.visit.closingStock.toString()}"),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            ListTile(
              title: Text("Reason: "),
              subtitle: Text("${widget.visit.reason.toString()}"),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            // Container(
            //   height: MediaQuery.of(context).size.height * 0.15,
            //   width: MediaQuery.of(context).size.width,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       Card(
            //         elevation: 5.0,
            //         child: Container(
            //           height: MediaQuery.of(context).size.height * 0.15,
            //           width: MediaQuery.of(context).size.width * 0.45,
            //           // color: Colors.amberAccent,
            //           child: widget.visit.openingStockImage != null
            //               ? Image.network(widget.visit.openingStockImage!)
            //               : Center(
            //                   child: ElevatedButton(
            //                     onPressed: () {
            //                       _imgFromCamera();
            //                     },
            //                     child: Text("Opening Stock Image"),
            //                   ),
            //                 ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
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
                                child: Text("Closing Stock Image"),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton(
                onPressed: () async {
                  final docID = widget.visit.documentID;

                  if (widget.visit.checkOutTime == null) {
                    await Provider.of<Database>(context, listen: false)
                        .checkOut(DateTime.now().toString(), docID, image!);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MyHomePage();
                        },
                      ),
                    );
                 
                  } else {
                    Center(
                      child: Text("This location has been checked out"),
                    );
                  }
                },
                child: Text("Check Out"),
              ),
            )
          ],
        ),
      ),
    );
  }

  File? image;
  _imgFromCamera() async {
    final images = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    final File? tempImage = File(images!.path);

    setState(() {
      this.image = tempImage;
    });
  }
}

