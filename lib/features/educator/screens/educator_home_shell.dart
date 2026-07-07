import 'package:flutter/material.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/features/educator/screens/alerts_screen.dart';
import 'package:hedagent/features/educator/screens/courses_screen.dart';
import 'package:hedagent/features/educator/screens/educator_dashboard_screen.dart';
import 'package:hedagent/features/educator/screens/students_screen.dart';
import 'package:hedagent/features/profile/screens/profile_screen.dart';

class EducatorHomeShell extends StatefulWidget {
  const EducatorHomeShell({super.key});

  @override
  State<EducatorHomeShell> createState() => _EducatorHomeShellState();
}

class _EducatorHomeShellState extends State<EducatorHomeShell> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final widgetOptions = <Widget>[
      const EducatorDashboardScreen(),
      const StudentsScreen(),
      const CoursesScreen(),
      const AlertsScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: widgetOptions[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: whiteColor),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12.0 / 390 * size.width,
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
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.groups_outlined,
                      color: _selectedIndex == 1 ? primaryColor : thirGreyColor,
                    ),
                    label: 'Students',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu_book_outlined,
                      color: _selectedIndex == 2 ? primaryColor : thirGreyColor,
                    ),
                    label: 'Courses',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.campaign_outlined,
                      color: _selectedIndex == 3 ? primaryColor : thirGreyColor,
                    ),
                    label: 'Alerts',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                      color: _selectedIndex == 4 ? primaryColor : thirGreyColor,
                    ),
                    label: 'Profile',
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
