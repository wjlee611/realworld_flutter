import 'package:flutter/material.dart';

class AppFont extends StatelessWidget {
  final String text;

  const AppFont(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
