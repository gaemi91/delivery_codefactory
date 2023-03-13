import 'package:delivery_codefactory/common/const/colors.dart';
import 'package:delivery_codefactory/common/layout/layout_default.dart';
import 'package:delivery_codefactory/restaurant/route/route_restaurant.dart';
import 'package:flutter/material.dart';

class RouteCommonTap extends StatefulWidget {
  const RouteCommonTap({Key? key}) : super(key: key);

  @override
  State<RouteCommonTap> createState() => _RouteCommonTapState();
}

class _RouteCommonTapState extends State<RouteCommonTap> with SingleTickerProviderStateMixin {
  late TabController tabController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(tabListener);
  }

  @override
  void dispose() {
    tabController.removeListener(tabListener);
    tabController.dispose();
    super.dispose();
  }

  tabListener() {
    setState(() {
      currentIndex = tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutDefault(
      title: '개미 딜리버리',
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          RestaurantRoute(),
          Text('음식'),
          Text('주문'),
          Text('프로필'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color_Main,
        unselectedItemColor: Color_Text,
        onTap: (value) {
          tabController.index = value;
          tabController.animateTo(value);
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(label: '홈', icon: Icon(Icons.home_outlined)),
          BottomNavigationBarItem(label: '음식', icon: Icon(Icons.fastfood_outlined)),
          BottomNavigationBarItem(label: '주문', icon: Icon(Icons.receipt_outlined)),
          BottomNavigationBarItem(label: '프로필', icon: Icon(Icons.person_outline)),
        ],
      ),
    );
  }
}
