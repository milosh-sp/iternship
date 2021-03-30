import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:iternship/main.dart';
import 'package:iternship/models/internships_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

import '../models/internship.dart';

class AppliedInternships extends StatefulWidget {
  @override
  _AppliedInternshipsState createState() => _AppliedInternshipsState();
}

class _AppliedInternshipsState extends State<AppliedInternships> {
  final refDatabase = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    DatabaseReference ref = refDatabase.reference().child('internshipsApplied');

    bool displayBackground = false;

    return Scaffold(
      appBar: AppBar(
        title: Text('Applied internships'),
        backgroundColor: Colors.grey[900],
      ),
      body: displayBackground
          ? Image.network(
              'https://i.pinimg.com/originals/cb/0b/4a/cb0b4adae8b81f8b65e2d16ca19afab7.png')
          : Column(
              children: [
                Flexible(
                  child: FirebaseAnimatedList(
                    shrinkWrap: true,
                    query: ref,
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      Map<dynamic, dynamic> ins =
                          snapshot.value[FirebaseAuth.instance.currentUser.uid];

                      if (ins == null) {
                        return Container();
                      } else {
                        return GestureDetector(
                          child: Card(
                            child: ListTile(
                              leading: Image.network(
                                  'https://cdn.freebiesupply.com/logos/large/2x/it-2-logo-png-transparent.png'),
                              subtitle: Text(
                                ins['companyName'],
                                style: TextStyle(color: Colors.white),
                              ),
                              trailing: Text(
                                ins['tags'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              title: Text(ins['intenrshipName'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0)),
                              isThreeLine: true,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            color: Colors.grey[900],
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
      backgroundColor: Colors.grey[600],
    );
  }
}
