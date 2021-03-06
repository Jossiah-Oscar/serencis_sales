// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serensic_sale/backend/database.dart';
import 'package:serensic_sale/model/company.dart';
import 'package:serensic_sale/model/user.dart' as f_User;
import 'package:serensic_sale/screens/checkout/checkout.dart';

class UserRecentVisit extends StatefulWidget {
  String? finalUID;
  UserRecentVisit({Key? key, required this.finalUID}) : super(key: key);

  @override
  _UserRecentVisitState createState() => _UserRecentVisitState();
}

class _UserRecentVisitState extends State<UserRecentVisit> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      // color: Colors.amberAccent,
      child: Column(
        children: [
          // ignore: prefer_const_constructors
          ListTile(
            title: Center(
              child: Text("Your Recent Visits"),
            ),
          ),
          StreamBuilder<List<Visit>>(
              stream: Provider.of<Database>(context, listen: false)
                  .readRecentVisits(widget.finalUID),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final _recentVisits = snapshot.data!;

                  return Container(
                    height: MediaQuery.of(context).size.height * 0.342,
                    // color: Colors.red,
                    child: ListView.builder(
                        itemCount: _recentVisits.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              // tileColor: Colors.lightBlueAccent,
                              title:
                                  Text("${_recentVisits[index].companyName}"),
                              subtitle: Text(
                                  "Reason for visit: ${_recentVisits[index].reason}\nLocation: ${_recentVisits[index].streetName}"),

                              trailing: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary:
                                        _recentVisits[index].checkOutTime ==
                                                null
                                            ? Colors.red
                                            : Colors.green),
                                onPressed: () async {
                                  if (_recentVisits[index].checkOutTime ==
                                      null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return CheckOutPage(
                                              visit: _recentVisits[index]);
                                        },
                                      ),
                                    );
                                  } else {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Visit Checked Out'),
                                        content: const Text(
                                            'This visit has already been Checked Out'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                                child: _recentVisits[index].checkOutTime == null
                                    ? Text(
                                        "Check Out",
                                      )
                                    : Text(
                                        "Checked Out",
                                      ),
                              ),
                            ),
                          );
                        }),
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text("Opps Something Went Wrong");
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      ),
    );
  }
}
