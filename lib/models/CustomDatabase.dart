import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../models/internships_model.dart';

class CustomDatabase extends StatefulWidget {
  final FirebaseApp app;

  CustomDatabase({this.app});

  @override
  _CustomDatabaseState createState() => _CustomDatabaseState();
}

class _CustomDatabaseState extends State<CustomDatabase> {
  final refDatabase = FirebaseDatabase.instance;

  List<Internmodel> interns;

  TextEditingController textString = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController tagsString = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController zid =TextEditingController();
  TextEditingController link =TextEditingController();



  @override
  Widget build(BuildContext context) {
    final ref = refDatabase.reference().child('test');

    return Scaffold(
      appBar: AppBar(
        title: Text('Add screen (only for companies) '),
      ),
      body: Column(
        children: [
          Text('id'),
          TextField(
            controller: zid,
          ),
          Text('internship name'),
          TextField(
            controller: textString,
          ),
          Text('company name'),
          TextField(
            controller: companyName,
          ),
          Text('description'),
          TextField(
            controller: description,
          ),
          Text('tags'),
          TextField(
            controller: tagsString,
          ),
          Text('link'),
          TextField(
            controller: link,
          ),

          ElevatedButton(
            child: Text('send'),
            onPressed: () =>
                ref.push().child('ObjectTest').set(<String, Object>{
                  "intenrshipName": textString.text,
                  "companyName": companyName.text,
                  "tags": tagsString.text,
                  "description":description.text,
                  "zid": zid.text,
                  "link": link.text
                }).asStream(),
          ),
          Flexible(
            child: new FirebaseAnimatedList(
              shrinkWrap: true,
              query: ref,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                Map<dynamic,dynamic> ins =snapshot.value['ObjectTest'];
                interns = ins.entries.map((e) => Internmodel(e.value, e.value, e.value,e.value,e.value)).toList();
                print(interns[1].id);

                return new ListTile(
                  title: new Text(interns[0].internshipName),
                  subtitle: new Text(interns[1].companyName),
                  leading: new Text(interns[3].tags),
                  isThreeLine: true,
                );
                //za brisanje ref.child(snapshot.key).remove
              },
            ),
          )
        ],
      ),
    );
  }
}
