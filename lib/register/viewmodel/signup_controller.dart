import 'package:flutter/material.dart';
import 'package:login_firebase/authentication/viewmodel/auth.dart';
import 'package:login_firebase/login/view/signin_screen.dart';
import 'package:login_firebase/routes/routes.dart';

class SignUpController extends ChangeNotifier {
  final TextEditingController email = TextEditingController(),
      name = TextEditingController(),
      pass = TextEditingController();

  void signUpHere(AuthProvider provider, context) async {
    final msg = await provider.signUp(email.text, pass.text);
    if (msg == "") return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg.trim())));
  }

  void disposeMethod(context) {
    email.clear();
    pass.clear();
    RoutesManager.removeScreen(screen: const SignInScreen());
  }
}
