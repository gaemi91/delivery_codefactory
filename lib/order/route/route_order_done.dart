import 'package:delivery_codefactory/common/const/colors.dart';
import 'package:delivery_codefactory/common/layout/layout_default.dart';
import 'package:delivery_codefactory/common/route/route_common_tap.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteOrderDone extends StatelessWidget {
  static String get routeName => 'orderDone';

  const RouteOrderDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutDefault(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.thumb_up_alt_outlined, size: 50.0, color: Color_Main),
            const SizedBox(height: 30.0),
            const Text('결제가 완료되었습니다.'),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                context.goNamed(RouteCommonTap.routeName);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Color_Main),
              child: const Text('홈으로'),
            )
          ],
        ),
      ),
    );
  }
}
