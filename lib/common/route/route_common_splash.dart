import 'package:delivery_codefactory/common/const/colors.dart';
import 'package:delivery_codefactory/common/const/data.dart';
import 'package:delivery_codefactory/common/layout/layout_default.dart';
import 'package:delivery_codefactory/common/route/route_common_tap.dart';
import 'package:delivery_codefactory/common/secure_storage/secure_storage.dart';
import 'package:delivery_codefactory/user/route/route_user_login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RouteCommonSplash extends ConsumerStatefulWidget {
  const RouteCommonSplash({Key? key}) : super(key: key);

  @override
  ConsumerState<RouteCommonSplash> createState() => _RouteCommonSplashState();
}

class _RouteCommonSplashState extends ConsumerState<RouteCommonSplash> {
  @override
  void initState() {
    super.initState();
    checkToken();
  }

  void checkToken() async {
    try {
      final dio = Dio();
      final storage = ref.read(providerStorage);

      final refreshToken = await storage.read(key: Token_Key_Refresh);

      final resp = await dio.post(
        'http://$ip/auth/token',
        options: Options(headers: {authorization: 'Bearer $refreshToken'}),
      );

      await storage.write(key: Token_Key_Access, value: resp.data[Token_Key_Access]);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => RouteCommonTap()),
        (route) => false,
      );
    } catch (e) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => RouteUserLogin()),
        (route) => false,
      );
    }
  }

  void deleteToken() async {
    final storage = ref.read(providerStorage);

    await storage.deleteAll();
  }

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
