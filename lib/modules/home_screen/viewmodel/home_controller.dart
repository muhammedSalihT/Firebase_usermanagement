import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_firebase/core/colors.dart';
import 'package:login_firebase/models/user_model.dart';
import 'package:login_firebase/modules/login/viewmodel/auth_controller.dart';
import 'package:login_firebase/routes/routes.dart';
import 'package:login_firebase/widgets/labelediconbutton.dart';
import 'package:provider/provider.dart';

class HomeController extends ChangeNotifier {
  final authpro = AuthProvider();
  String img = '';

  final TextEditingController controller = TextEditingController();
  

  void pickImageFromCamera(source, String email) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(
        source: source, preferredCameraDevice: CameraDevice.rear);

    if (image == null) return;
    File imageFile = File(image.path);
    final bytes = imageFile.readAsBytesSync();
    img = base64Encode(bytes);
    authpro.updateToFireStore(email, img, "image");
    notifyListeners();
    RoutesManager.backScreen();
  }

  updateContent(String email, String edittedContent, String content, context) {
    authpro.updateToFireStore(email, edittedContent, content);
    const snackBar =
        SnackBar(duration: Duration(seconds: 1), content: Text('editted'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.of(context).pop();
  }
  Future<dynamic> imageSelection(BuildContext context, UserModel user) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 80,
            width: double.infinity,
            color: whiteColor,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    LabeledIconButton(
                        icon: Icons.camera,
                        label: "Camera",
                        onPress: () {
                          Provider.of<HomeController>(context, listen: false)
                              .pickImageFromCamera(
                                  ImageSource.camera, user.email.toString());
                        }),
                    LabeledIconButton(
                        icon: Icons.store_mall_directory,
                        label: "Storage",
                        onPress: () {}),
                    LabeledIconButton(
                        icon: Icons.delete,
                        label: "Delete photo",
                        onPress: () {}),
                  ],
                )
              ],
            ),
          );
        });
  }
   Future<dynamic> editDialogBox(BuildContext context, UserModel user,
      String? editingContent, String edittingKey) {
    return showDialog(
      context: context,
      builder: (BuildContext ctx) {
        editingContent!=null?context.read<HomeController>().controller.text = editingContent:context.read<HomeController>().controller.text = "ADD PHONE NUMBER";
        return AlertDialog(
          backgroundColor: const Color.fromARGB(15, 0, 0, 0),
          content: TextFormField(
            controller:context.read<HomeController>().controller,
            style: TextStyle(color: whiteColor),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  context.read<HomeController>().updateContent(
                      user.email!,
                      context.read<HomeController>().controller.text,
                      edittingKey,
                      context);
                },
                child: const Text('edit'))
          ],
        );
      },
    );
  }
}
