import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coachui/screens/homepage/dashboard.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:coachui/screens/paymentpages/paymenthistory.dart';
import 'package:coachui/features/percentageindicator/circularindicator.dart';
import 'package:coachui/screens/profile/profile.dart';
class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
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
        title: "Fee History",  // Adding name below the icon
        activeColorPrimary: Color(0xFF6A41B8),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.work_history_outlined),
        title: "Activity",  // Adding name below the icon
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
      const CircularPercentageIndicator(),
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
      navBarStyle: NavBarStyle.style6,  // You can use other styles like NavBarStyle.style3 if needed
    );
  }
}
