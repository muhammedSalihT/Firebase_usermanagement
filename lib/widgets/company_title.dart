import 'package:flutter/material.dart';

class CompanyTitle extends StatelessWidget {
  const CompanyTitle({
    Key? key,
    required this.broColor,
    required this.containerColor,
    required this.typeColor, required this.size,
  }) : super(key: key);

  final Color broColor;
  final Color containerColor;
  final Color typeColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: containerColor,
          child: Text(
            "BRO",
            style: TextStyle(
                fontWeight: FontWeight.w900,
                color: broColor,
                fontSize: size,
                decoration: TextDecoration.none),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          "TOTYPE",
          style: TextStyle(
              fontWeight: FontWeight.w900,
              color: typeColor,
              fontSize: size,
              decoration: TextDecoration.none),
        )
      ],
    );
  }
}
