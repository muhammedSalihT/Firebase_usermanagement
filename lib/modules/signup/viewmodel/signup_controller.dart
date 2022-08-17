import 'package:flutter/material.dart';
import 'package:login_firebase/models/user_model.dart';
import 'package:login_firebase/modules/login/viewmodel/auth_controller.dart';

class SignUpController extends ChangeNotifier {
  TextEditingController email = TextEditingController(),
      name = TextEditingController(),
      pass = TextEditingController(),
      rePass = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void signUpHere(AuthProvider provider, context) async {
    if (pass.text == rePass.text) {
      UserModel userModel = UserModel(
          uid: email.text,
          email: email.text,
          image: null,
          name: name.text,
          number: null);
      final msg = await provider.signUp(email.text, pass.text, userModel);
      if (msg == "") return disposeMethod(context);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(msg.trim())));
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Password does't match")));
    }
  }
  validator(provider, context) {
    if (formKey.currentState!.validate()) {
      return signUpHere(provider, context);
    } 
  }

  void disposeMethod(context) {
    email.clear();
    pass.clear();
    name.clear();
    rePass.clear();
  }
}
