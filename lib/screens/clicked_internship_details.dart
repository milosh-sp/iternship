import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iternship/main.dart';
import 'package:iternship/models/internships_model.dart';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/internship.dart';
import '../utils/internship_text_template.dart';
import '../utils/image_banner.dart';

class IntDetails extends StatefulWidget {
  final int _locationID;

  IntDetails(this._locationID);

  @override
  _IntDetailsState createState() => _IntDetailsState();
}

class _IntDetailsState extends State<IntDetails> {
  final refDatabase = FirebaseDatabase.instance;
  List<Internmodel> interns;
  String companyName;

  String _url;

  @override
  Widget build(BuildContext context) {
    final ref = refDatabase.reference().child('test');
    final refApplied = refDatabase.reference().child('internshipsApplied');
    bool disabled = true;

    void disableONclick() {
      setState(() {
        disabled = false;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Internship details'),
        backgroundColor: Colors.grey[900],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05),
                    child: Image.network(
                        'https://cdn.freebiesupply.com/logos/large/2x/it-2-logo-png-transparent.png'),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: new FirebaseAnimatedList(
                    query: ref,
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      Map<dynamic, dynamic> ins = snapshot.value['ObjectTest'];

                      if (widget._locationID.toString() == ins['zid']) {
                        _url = ins['link'];
                        print(_url);
                        print(appliedSet);

                        if (appliedSet.contains(ins['zid'])) {
                          disabled = false;
                        }

                        return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    'Description',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      fontSize: 16.0
                                    ),
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                Container(
                                  child: Text(ins['description'],style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0
                                  ),),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                                Center(
                                  child: ElevatedButton(
                                    child: Text('Apply'),
                                    onPressed: disabled
                                        ? () => {
                                              refApplied
                                                  .push()
                                                  .child(FirebaseAuth
                                                      .instance.currentUser.uid)
                                                  .set(<String, Object>{
                                                "intenrshipName":
                                                    ins['intenrshipName'],
                                                "companyName":
                                                    ins['companyName'],
                                                "tags": ins['tags'],
                                                "userId": FirebaseAuth
                                                    .instance.currentUser.uid,
                                                "zid": ins['zid']
                                              }).asStream(),
                                              appliedSet.add(ins['zid']),
                                              disableONclick(),
                                            }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.blueGrey[900],
                                        elevation: 3.0),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => Share.share(
                                        '${ins['description']} \n \n You can view more details on the ITernship app download it for free for iOS or Android'
                                            '\n ITernship.com',
                                        subject: 'Great internship for you',
                                      ),
                                      child: Icon(Icons.share),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.blueGrey[900],
                                          elevation: 3.0),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => _launchURL(),
                                      child: Icon(Icons.location_on),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.blueGrey[900],
                                        elevation: 3.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ));
                      } else {
                        return Container();
                      }
                      //za brisanje ref.child(snapshot.key).remove
                    },
                  ),
                ),
              ]),
        ),
      ),
      backgroundColor: Colors.grey[900],
    );
  }

  List<Widget> textSection(Internship internship) {
    return internship.details
        .map((detail) =>
            InternDetails(internship.name, detail.description, detail.tags))
        .toList();
  }

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
