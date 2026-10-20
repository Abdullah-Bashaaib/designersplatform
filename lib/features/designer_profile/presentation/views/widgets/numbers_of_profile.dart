import 'package:flutter/material.dart';

class NumbersOfProfile extends StatelessWidget {
  final String number;
  final String field;
  const NumbersOfProfile(
      {super.key, required this.field, required this.number});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          field,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
