import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_firebase/modules/login/view/signin_screen.dart';
import 'package:login_firebase/routes/routes.dart';



class AuthProvider extends ChangeNotifier {
  FirebaseAuth fb;
  AuthProvider(this.fb);
  bool _isLoading = false;

  Stream<User?> stream() => fb.authStateChanges();
  bool get loading => _isLoading;

  Future<String> signIn(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      await fb.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());

  

      _isLoading = false;
      notifyListeners();
      return Future.value("");
    } on FirebaseAuthException catch (ex) {
      _isLoading = false;
      notifyListeners();
      return Future.value(ex.message);
    }
  }

  Future<void> logOut(context) async {
    await fb.signOut();
     ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text  ("You are successfully logout")));
    RoutesManager.removeScreen(screen: const SignInScreen());
  }

  Future<String> signUp(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      await fb.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());

      _isLoading = false;
      notifyListeners();
      return Future.value("");
    } on FirebaseAuthException catch (ex) {
      _isLoading = false;
      notifyListeners();
      return Future.value(ex.message);
    }
  }

  
}
