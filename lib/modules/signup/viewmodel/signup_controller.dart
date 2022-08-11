import 'package:flutter/material.dart';
import 'package:login_firebase/models/auth_model/auth.dart';
import 'package:login_firebase/modules/login/view/signin_screen.dart';
import 'package:login_firebase/routes/routes.dart';

class SignUpController extends ChangeNotifier {
  final TextEditingController email = TextEditingController(),
      name = TextEditingController(),
      pass = TextEditingController(),
      rePass = TextEditingController();

  void signUpHere(AuthProvider provider, context) async {
    if (pass.text == rePass.text) {
      final msg = await provider.signUp(email.text, pass.text);
      if (msg == "") return   disposeMethod(context);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(msg.trim())));
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Password does't match")));
    }
  }

  void disposeMethod(context) {
    email.clear();
    pass.clear();
    name.clear();
    rePass.clear();
    RoutesManager.removeScreen(screen: const SignInScreen());
  }
}