import 'package:flutter/material.dart';

class AppFont extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const AppFont(
    this.text, {
    super.key,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}
