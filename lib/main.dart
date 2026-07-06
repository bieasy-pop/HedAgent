import 'package:flutter/material.dart';
import 'package:hedagent/constants/app_style.dart';
import 'package:hedagent/route/router.dart';

void main() {
  runApp(FlutterApp());
}

class FlutterApp extends StatelessWidget {
  FlutterApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'HedAgent',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.router,
    );
  }
}
