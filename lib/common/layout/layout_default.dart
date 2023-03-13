import 'package:flutter/material.dart';

class LayoutDefault extends StatelessWidget {
  final Widget body;
  final Color colorBG;

  const LayoutDefault({
    Key? key,
    required this.body,
    this.colorBG = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBG,
      body: body,
    );
  }
}
