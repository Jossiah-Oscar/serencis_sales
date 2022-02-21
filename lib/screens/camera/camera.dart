// ignore_for_file: unused_element

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:whatsapp_share/whatsapp_share.dart';

class ReceiptPage extends StatefulWidget {
  const ReceiptPage({Key? key}) : super(key: key);

  @override
  _ReceiptPageState createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  File? image;
  File? SendImage;
  List imageArray = [];

  _imgFromCamera() async {
    final images = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    imageArray.add(
      File(images!.path),
    );
    // final tempImage = File(image!.path);

    setState(() {
      imageArray;
      print(images.name);
      // this.image = tempImage;
    });
  }

  _imgFromGallery() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    final tempImage = File(image!.path);

    setState(() {
      this.image = tempImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.4,
                color: Colors.amberAccent,
                child: imageArray.isNotEmpty
                    ? Image.file(imageArray[0])
                    : Center(
                        child: ElevatedButton(
                          onPressed: () {
                            _imgFromCamera();
                          },
                          child: Text("Opening Stock Image"),
                        ),
                      ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.4,
                color: Colors.amberAccent,
                child: imageArray.length == 2
                    ? Image.file(imageArray[1])
                    : Center(
                        child: ElevatedButton(
                          onPressed: () {
                            _imgFromCamera();
                          },
                          child: Text("Closing Stock Image"),
                        ),
                      ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ElevatedButton(
                        onPressed: () {
                          _imgFromCamera();
                        },
                        child: Text("Camera"),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Gallery"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton(
                      onPressed: () async {
                        // await Share.shareFiles([image.path]);
                      },
                      child: Text("Send to Customer"),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
