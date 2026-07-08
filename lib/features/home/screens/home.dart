import 'package:flutter/material.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/features/analytic/screens/analytic_screen.dart';
import 'package:hedagent/features/authentication/data/user_storage_service.dart';
import 'package:hedagent/features/educator/screens/courses_screen.dart';
import 'package:hedagent/features/educator/screens/educator_alerts_screen.dart';
import 'package:hedagent/features/educator/screens/educator_dashboard_screen.dart';
import 'package:hedagent/features/educator/screens/educator_profile_screen.dart';
import 'package:hedagent/features/educator/screens/students_screen.dart';
import 'package:hedagent/features/home/screens/dashboard_screen.dart';
import 'package:hedagent/features/home/widgets/complete_student_profile_dialog.dart';
import 'package:hedagent/features/messages/screen/message_screen.dart';
import 'package:hedagent/features/profile/screens/profile_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  bool _isEducator = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRole();
  }

  Future<void> _loadRole() async {
    final user = await UserStorageService().getUser();
    if (!mounted) return;
    setState(() {
      _isEducator = user?.role == 'educator';
      _isLoading = false;
    });

    final studentProfile = user?.studentProfile;
    final needsProfileCompletion =
        user != null &&
        user.role == 'student' &&
        (studentProfile == null || !studentProfile.isClassified);
    if (needsProfileCompletion) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) showCompleteStudentProfileDialog(context);
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final size = MediaQuery.sizeOf(context);
    final List<Widget> widgetOptions = _isEducator
        ? const [
            EducatorDashboardScreen(),
            StudentsScreen(),
            CoursesScreen(),
            EducatorAlertsScreen(),
            EducatorProfileScreen(),
          ]
        : [DashBoardScreen(), AnalyticsScreen(), MessageScreen(), ProfileScreen()];

    final List<_NavItem> navItems = _isEducator
        ? const [
            _NavItem(icon: Icons.dashboard, label: 'Dashboard'),
            _NavItem(icon: Icons.groups, label: 'Students'),
            _NavItem(icon: Icons.menu_book, label: 'Courses'),
            _NavItem(icon: Icons.campaign, label: 'Alerts'),
            _NavItem(icon: Icons.person, label: 'Profile'),
          ]
        : const [
            _NavItem(icon: Icons.dashboard, label: 'Dashboard'),
            _NavItem(icon: Icons.analytics, label: 'Analytics'),
            _NavItem(icon: Icons.message, label: 'Messages'),
            _NavItem(icon: Icons.person, label: 'Profile'),
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
                  for (var i = 0; i < navItems.length; i++)
                    BottomNavigationBarItem(
                      icon: Icon(
                        navItems[i].icon,
                        color: _selectedIndex == i ? primaryColor : thirGreyColor,
                      ),
                      label: navItems[i].label,
                      backgroundColor: _selectedIndex == i
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

class _NavItem {
  const _NavItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}
