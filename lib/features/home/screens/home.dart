import 'package:flutter/material.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/constants/colors.dart';
import 'package:hedagent/features/analytic/screens/analytic_screen.dart';
import 'package:hedagent/features/authentication/data/user_storage_service.dart';
import 'package:hedagent/features/educator/screens/educator_home_shell.dart';
import 'package:hedagent/features/home/screens/dashboard_screen.dart';
import 'package:hedagent/features/messages/screen/message_screen.dart';
import 'package:hedagent/features/profile/screens/profile_screen.dart';

/// Entry point for RouteNames.homeString. Renders the educator shell for
/// educator accounts and the student shell otherwise, based on the role
/// cached in secure storage at login/verification time.
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final Future<String?> _roleFuture;

  @override
  void initState() {
    super.initState();
    _roleFuture = UserStorageService().getUser().then((user) => user?.role);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _roleFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.data == 'educator') {
          return const EducatorHomeShell();
        }
        return const _StudentHomeShell();
      },
    );
  }
}

class _StudentHomeShell extends StatefulWidget {
  const _StudentHomeShell();

  @override
  State<_StudentHomeShell> createState() => _StudentHomeShellState();
}

class _StudentHomeShellState extends State<_StudentHomeShell> {
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
