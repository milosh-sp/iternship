import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}


class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String token;

  @override
  Widget build(BuildContext context) {

    getKey();
    FirebaseMessaging.instance.getToken().then((value) => print(value));
    

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    return Container();
  }

  void getKey() async {
      token = await messaging.getToken(
      vapidKey: "BGcEqguxPVbIv8E6KpJfQb0b3g263lFdJme3-tU-Ga22On_H9Fhc8sygmzC2Nks9A1npM1-ddYdIICFJoiYEVfQ",
    );
  }


}
