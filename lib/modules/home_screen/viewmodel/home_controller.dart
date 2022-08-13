import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_firebase/modules/login/viewmodel/auth_controller.dart';
import 'package:login_firebase/routes/routes.dart';

class HomeController extends ChangeNotifier {
  final authpro = AuthProvider();
  String img = '';


  void pickImageFromCamera(source,String email) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(
        source: source, preferredCameraDevice: CameraDevice.rear);

    if (image == null) return;
    File imageFile = File(image.path);
    final bytes = imageFile.readAsBytesSync();
    img = base64Encode(bytes);
    authpro.updateToFireStore(email,img);
    notifyListeners();
    RoutesManager.backScreen();
  }
}
