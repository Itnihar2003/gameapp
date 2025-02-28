import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:cricketcoach/screens/dashboardpages/dashboard.dart';
import 'package:coachui/screen2/dashboardpages/dashboard.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
//import 'package:cricketcoach/screens/paymentpages/payment.dart';
import 'package:coachui/screen2/paymentpages/payment.dart';
//import 'package:cricketcoach/screens/manage/manage1.dart';
import 'package:coachui/screen2/manage/manage1.dart';
//import 'package:cricketcoach/screens/profilepages/profile.dart';
import 'package:coachui/screens/profile/profile.dart';
class Navigation2 extends StatefulWidget {
  const Navigation2({super.key});

  @override
  State<Navigation2> createState() => _NavigationState2();
}

class _NavigationState2 extends State<Navigation2> {
  PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.holiday_village_outlined),
        title: "Home",  // Adding name below the icon
        activeColorPrimary: Color(0xFF6A41B8),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.monetization_on_rounded),
        title: "Payment",  // Adding name below the icon
        activeColorPrimary: Color(0xFF6A41B8),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.work_history_outlined),
        title: "Manage",  // Adding name below the icon
        activeColorPrimary: Color(0xFF6A41B8),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_2_outlined),
        title: "Profile",  // Adding name below the icon
        activeColorPrimary: Color(0xFF6A41B8),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [
      DashboardScreen(),
      PaymentHistoryPage(),
      ManagePage(),
      ProfilePage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,  
    );
  }
}
