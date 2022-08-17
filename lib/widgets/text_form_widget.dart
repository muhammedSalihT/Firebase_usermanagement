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
  final Color textColor;
  final dynamic validator;

  const TextFormWidget({
    Key? key,
    required this.hideData,
    required this.hint,
    required this.icon,
    required this.textType,
    required this.label,
    required this.controller,
    this.suffixIcon,
    required this.textColor,
    this.validator,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0, right: 35.0),
      child: Column(
        children: [
          TextFormField(
            validator: validator,
            controller: controller,
            keyboardType: textType,
            obscureText: hideData,
            style: TextStyle(
              color: textColor,
              fontSize: 22.0,
              fontWeight: FontWeight.w900,
            ),
            // controller: _mobileController,
            decoration: InputDecoration(
              label: Text(
                label,
                style: const TextStyle(color: greyColor),
              ),
              prefixIcon: Icon(icon, color: greyColor),
              suffix: suffixIcon,
              border: const OutlineInputBorder(
                borderSide: BorderSide(),
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
