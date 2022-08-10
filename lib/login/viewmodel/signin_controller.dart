import 'package:flutter/material.dart';
import 'package:login_firebase/authentication/viewmodel/auth.dart';

class SigninController with ChangeNotifier {
  bool hidePassword = true;

  final email = TextEditingController();
  final pass = TextEditingController();

  void signInHere(AuthProvider provider, context) async {
    final msg = await provider.signIn(email.text, pass.text);
    if (msg == "") {
      return;
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(msg.trim())));
    }
  }

  hideButton() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

  Widget onTap() {
    return InkWell(
      onTap: hideButton,
      child: hidePassword
          ? const Icon(Icons.visibility_off)
          : const Icon(Icons.visibility),
    );
  }

  void disposeMethod(context) {
    email.clear();
    pass.clear();
  }
}
