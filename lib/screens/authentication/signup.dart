// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:serensic_sale/main.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // @override
  // void initState() {
  //   SystemChrome.setEnabledSystemUIOverlays([]);
  //   super.initState();
  // }

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
        body: Container(
          child: ListView(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.5,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xff6bceff), Color(0xff6bceff)],
                    ),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(90))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.person,
                        size: 90,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 32, right: 32),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 62),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 45,
                      padding: EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5)
                          ]),
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Full Name',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width / 1.2,
                    //   height: 45,
                    //   padding: EdgeInsets.only(
                    //       top: 4, left: 16, right: 16, bottom: 4),
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.all(Radius.circular(50)),
                    //       color: Colors.white,
                    //       boxShadow: [
                    //         BoxShadow(color: Colors.black12, blurRadius: 5)
                    //       ]),
                    //   child: TextField(
                    //     decoration: InputDecoration(
                    //       border: InputBorder.none,
                    //       hintText: 'Username',
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 45,
                      padding: EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5)
                          ]),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 45,
                      padding: EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5)
                          ]),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () async {
                        await SignUp();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MyHomePage();
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width / 1.2,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff6bceff),
                                Color(0xFF00abff),
                              ],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Center(
                          child: Text(
                            'Sign Up'.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Have an account ?"),
                    Text(
                      "Login",
                      style: TextStyle(color: Color(0xff6bceff)),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future SignUp() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await _auth.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } catch (e) {
      print(e);
    }
  }
}
