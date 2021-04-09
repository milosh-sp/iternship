import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:iternship/main.dart';

class AuthenticationService with ChangeNotifier
{
  final FirebaseAuth _firebaseAuth;

  Stream<User> get authStateChnages => _firebaseAuth.authStateChanges();

  AuthenticationService(this._firebaseAuth);

  Future<String> signOut() async{
    try {
      await _firebaseAuth.signOut();
      notifyListeners();
      return 'Logout';
    }
    on FirebaseAuthException catch (e)
    {
      return e.message;
    }
  }

  Future<String> signIn({String email, String password}) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
      return 'Signed';
    }
    on FirebaseAuthException catch (e)
    {
      print(e.message);
      return e.message;

    }

  }

  Future<String> signUp({String email, String password}) async {
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return 'registered';
    }
    on FirebaseAuthException catch (e)
    {
      return e.message;

    }

  }
}