import 'package:delivery_codefactory/user/route/route_user_login.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

var logger = Logger(printer: PrettyPrinter(methodCount: 1));
var loggerDetail = Logger(printer: PrettyPrinter(methodCount: 3));

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Notosans'),
      home: const RouteUserLogin(),
    );
  }
}
