import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:iternship/main.dart';
import 'package:iternship/models/internships_model.dart';
import 'package:iternship/ui/bottom_nav_bar.dart';
import 'package:iternship/utils/notifications.dart';

import '../utils/drawer_user_profile.dart';

Map<dynamic, dynamic> ins;

class ListInternships extends StatefulWidget {
  final FirebaseApp app;

  ListInternships({this.app});

  @override
  _ListInternshipsState createState() => _ListInternshipsState();
}

class _ListInternshipsState extends State<ListInternships> {
  final refDatabase = FirebaseDatabase.instance;

  bool showFloating = false;


  List<Internmodel> interns;

  List<List<String>> lists = [[]];

  int filter = 0;

  String filString = "";

  List<String> memes = [];

  Set<String> setTagsNew = {};

  void _update(bool lol) {
    setState(() {
      showFloating = lol;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ref = refDatabase.reference().child('test');

    change = !change;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Internships',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.approval),
              onPressed: () => _onAppliedTap(context),
              color: Colors.white,
            )
          ],
          backgroundColor: Colors.grey[900],
        ),
        body: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: Column(
            children: [
              Flexible(
                child: FirebaseAnimatedList(
                  shrinkWrap: true,
                  query: ref,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    ins = snapshot.value['ObjectTest'];

                    List<String> tagsSplit = ins['tags'].toString().split('#');
                    tagsSplit.forEach((element) => setTagsNew.add(element));

                    if (ins == null) {
                      return Container();
                    }

                    if (memes.length <= index) {
                      memes.add(ins['tags'].toString());
                    }

                    if (tagsSplit.contains(filString)) {
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
                            color: Colors.grey[900]),
                        onTap: () => _onLocationTap(context, index),
                      );
                    } else if (filString == ' ') {
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
                            color: Colors.grey[900]),
                        onTap: () => _onLocationTap(context, index),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              Notifications(),
            ],
          ),
        ),
        floatingActionButton: showFloating ? FloatingActionButton.extended(
          onPressed: () => _openPopup(context),
          label: Text('Filter'),
          icon: Icon(Icons.filter_alt),
          backgroundColor: Colors.blueGrey[900],
        ) : Container(),
        drawer: UserProfileDrawer(),
        bottomNavigationBar: BottomBar(update: _update),
        backgroundColor: Colors.grey[600]
    );
  }

  _onLocationTap(BuildContext context, int intID) {
    Navigator.pushNamed(context, InternshipDetailRoute,
        arguments: {"id": intID});
  }

  _onAppliedTap(BuildContext context) {
    Navigator.pushNamed(context, AppliedRoute);
  }

  _openPopup(context) {
    showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
            title: Text(
              'Choose a tag',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 1; i <= setTagsNew.length - 1; i++)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          filString = '${setTagsNew.elementAt(i)}';
                        });
                      },
                      child: Text(
                        setTagsNew.elementAt(i),
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey[900]),
                    )
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    filString = ' ';
                  });
                },
                child: Text('Reset tags', style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),),
              ),
            ],
            backgroundColor: Colors.grey[700],
          ),
    );
  }

}


