import 'package:flutter/material.dart';

import '../core/colors.dart';

class TextFormWidget extends StatelessWidget {
  final bool hideData;
  final String hint;
  final IconData icon;
  final TextInputType textType;
  final String label;
  final TextEditingController controller;
  final Widget? suffixIcon;

  const TextFormWidget({
    Key? key,
    required this.hideData,
    required this.hint,
    required this.icon,
    required this.textType,
    required this.label,
    required this.controller,  this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0, right: 35.0),
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter Something";
              } else {
                return null;
              }
            },
            controller: controller,
            keyboardType: textType,
            obscureText: hideData,
            style: TextStyle(
              color: blackColor,
              fontSize: 22.0,
              fontWeight: FontWeight.w900,
            ),
            // controller: _mobileController,
            decoration: InputDecoration(
              label: Text(label),
              prefixIcon: Icon(icon),
              suffix: suffixIcon,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
