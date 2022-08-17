import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_firebase/models/user_model.dart';
import 'package:login_firebase/modules/login/view/signin_screen.dart';
import 'package:login_firebase/routes/routes.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth fb = FirebaseAuth.instance;
  bool _isLoading = false;
  UserModel loggedUser = UserModel();

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
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You are successfully logout")));
    RoutesManager.removeScreen(screen: const SignInScreen());
  }

  Future<String> signUp(
      String email, String password, UserModel usermodel) async {
    try {
      _isLoading = true;
      notifyListeners();

      await fb
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) => addToFireStore(usermodel));

      _isLoading = false;
      notifyListeners();
      return Future.value("");
    } on FirebaseAuthException catch (ex) {
      _isLoading = false;
      notifyListeners();
      return Future.value(ex.message);
    }
  }

  Future<UserModel> readData() async {
    User? user = fb.currentUser;
    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.email)
        .get();
    return UserModel.fromJson(snapshot.data()!);
  }

  getData() async {
    User? user = fb.currentUser;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.email)
        .get()
        .then((value) => loggedUser = UserModel.fromJson(value.data()!));
    notifyListeners();
  }

  Future addToFireStore(UserModel usermodel) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(usermodel.uid)
        .set(usermodel.toJson());
  }

  Future updateToFireStore(
      String userEmail, String edittedContent, String content) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userEmail)
        .update({"$content": edittedContent});
  }
}
