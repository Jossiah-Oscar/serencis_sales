import 'package:flutter/material.dart';
import 'package:serensic_sale/screens/checkin/checkin.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(""),
      // ),
      body: SafeArea(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              // ignore: prefer_const_constructors
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              ListTile(
                leading: Icon(Icons.menu),
                title: Text(
                  "Welcome Back",
                  style: Theme.of(context).textTheme.headline4,
                ),
                subtitle: Text(
                  "Esther Lugoe",
                  style: Theme.of(context).textTheme.headline5,
                ),
                trailing: Icon(Icons.person),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),

              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.88,
                // color: Colors.amberAccent,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CheckinPage();
                            },
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width * 0.4,
                          // color: Colors.red,
                          child: Card(
                            elevation: 7.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check,
                                  size: 80,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                Text(
                                  "Check In",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.4,
                        // color: Colors.red,
                        child: Card(
                          elevation: 7.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.map,
                                size: 80,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Text(
                                "Visits",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Container(
              //   height: MediaQuery.of(context).size.height * 0.1,
              //   width: MediaQuery.of(context).size.width * 0.75,
              //   color: Colors.amberAccent,
              //   child: ElevatedButton(
              //     onPressed: () {},
              //     child: Text(
              //       "Check In",
              //       style: TextStyle(fontSize: 20),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
