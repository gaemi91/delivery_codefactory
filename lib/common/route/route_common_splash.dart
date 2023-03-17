import 'package:delivery_codefactory/common/const/colors.dart';
import 'package:delivery_codefactory/common/layout/layout_default.dart';
import 'package:flutter/material.dart';

class RouteCommonSplash extends StatelessWidget {
  static String get routeName => 'splash';

  const RouteCommonSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutDefault(
      colorBG: Color_Main,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('asset/img/logo/logo.png', width: MediaQuery.of(context).size.width * 2 / 3),
            const SizedBox(height: 10.0),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
