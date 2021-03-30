import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iternship/models/internships_model.dart';
import 'package:provider/provider.dart';

import '../authentication_service.dart';
import '../main.dart';

class UserProfileDrawer extends StatefulWidget {
  @override
  _UserProfileDrawerState createState() => _UserProfileDrawerState();
}

class _UserProfileDrawerState extends State<UserProfileDrawer> {
  final refDatabase = FirebaseDatabase.instance;

  Set<String> emailsSet = {};

  @override
  Widget build(BuildContext context) {
    final ref = refDatabase.reference().child('userdetails');
    List<Internmodel> userDetails;

    return Drawer(
      child: Container(
        child: FirebaseAnimatedList(
          shrinkWrap: true,
          query: ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map<dynamic, dynamic> ins = snapshot.value['users'];

            if (ins != null) {
            } else {
              return Container();
            }

            if (FirebaseAuth.instance.currentUser.email.toString() ==
                ins['email'].toString()) {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          DrawerHeader(
                            child: Align(
                              child: Text(
                                'Welcome, ${ins['firstname']} ${ins['lastname']}',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.04),
                            child: Align(
                              child: Text(
                                'Qualification',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.white),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              ins['qualification'],
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.04),
                            child: Align(
                              child: Text(
                                'University',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.white),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              ins['university'],
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.04),
                            child: Align(
                              child: Text(
                                'Email',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.white),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              ins['email'],
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      ListTile(
                          title: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                              color: Colors.black,
                            ),
                            child: Center(
                              child: Text(
                                'Logout',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          onTap: () async => await context
                              .read<AuthenticationService>()
                              .signOut()),
                    ]),
              );
            } else {
              return Container();
            }
          },
        ),
        color: Colors.blueGrey[900],
      ),
    );
  }
}
