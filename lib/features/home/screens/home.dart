import 'package:flutter/material.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/features/analytic/screens/analytic_screen.dart';
import 'package:hedagent/features/home/screens/dashboard_screen.dart';
import 'package:hedagent/features/messages/screen/message_screen.dart';
import 'package:hedagent/features/profile/screens/profile_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final List<Widget> widgetOptions = <Widget>[
      DashBoardScreen(),
      AnalyticsScreen(),
      MessageScreen(),
      ProfileScreen(),
    ];
    return Scaffold(
      body: widgetOptions[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: whiteColor),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.0 / 390 * size.width,
            vertical: 19,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomNavigationBar(
                elevation: 0,
                backgroundColor: whiteColor,
                currentIndex: _selectedIndex,
                selectedLabelStyle: AppTextStyle.tenStyle,
                unselectedLabelStyle: AppTextStyle.ninStyle,
                type: BottomNavigationBarType.fixed,
                onTap: _onItemTapped,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.dashboard,
                      color: _selectedIndex == 0 ? primaryColor : thirGreyColor,
                    ),
                    label: 'Dashboard',
                    backgroundColor: _selectedIndex == 0
                        ? primaryColor
                        : thirGreyColor,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.analytics,
                      color: _selectedIndex == 1 ? primaryColor : thirGreyColor,
                    ),
                    label: 'Analytics',
                    backgroundColor: _selectedIndex == 1
                        ? primaryColor
                        : thirGreyColor,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.message,
                      color: _selectedIndex == 2 ? primaryColor : thirGreyColor,
                    ),
                    label: 'Messages',
                    backgroundColor: _selectedIndex == 2
                        ? primaryColor
                        : thirGreyColor,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                      color: _selectedIndex == 3 ? primaryColor : thirGreyColor,
                    ),
                    label: 'Profile',
                    backgroundColor: _selectedIndex == 3
                        ? primaryColor
                        : thirGreyColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
