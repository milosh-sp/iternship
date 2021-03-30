import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iternship/authentication_service.dart';
import 'package:iternship/models/CustomDatabase.dart';
import 'package:iternship/screens/register_screen.dart';
import 'package:iternship/screens/sign_in_screen.dart';
import 'package:provider/provider.dart';

import 'screens/clicked_internship_details.dart';
import 'screens/internships_cards.dart';
import 'screens/applied.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

const InternshipsRoute = '/';
const SignInRoute = '/sign_in';
const InternshipDetailRoute = '/int_list';
const AppliedRoute = '/applied';
const RegisterRoute = '/register';

Set<String> appliedSet = {};

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}


class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (_) =>
            context
                .read<AuthenticationService>()
                .authStateChnages)
      ],
      child: Consumer<AuthenticationService>(
          builder: (context, authData, child) {
            return MaterialApp(
              home:  FirebaseAuth.instance.currentUser != null ?
                  ListInternships()
            :
            SignInScreen(),
                onGenerateRoute: _routes());
          }
      ),
    );
  }

  RouteFactory _routes() {
    return (settings) {
      final Map<String, dynamic> arguments = settings.arguments;
      Widget screen;
      switch (settings.name) {
        case RegisterRoute:
          screen = RegistrationForm();
          break;
        case SignInRoute:
          screen = SignInScreen();
          break;
        case InternshipsRoute:
          if (FirebaseAuth.instance.currentUser != null){
            screen = ListInternships();
          }
          screen = SignInScreen();
          break;
        case InternshipDetailRoute:
          screen = IntDetails(arguments['id']);
          break;
        case AppliedRoute:
          screen = AppliedInternships();
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }
}
