import 'package:flutter/material.dart';

class Subtitle extends StatelessWidget {
  final title;

  Subtitle({this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        color: Colors.black54,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
