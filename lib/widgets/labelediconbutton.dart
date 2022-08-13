import 'package:flutter/material.dart';

class LabeledIconButton extends StatelessWidget {
  const LabeledIconButton({
    Key? key, required this.onPress, required this.icon, required this.label,
  }) : super(key: key);

  final Function onPress;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () async {
            onPress();
          },
          icon:  Icon(
            icon,
            size: 30,
          ),
        ),
        Text(label)
      ],
    );
  }
}
