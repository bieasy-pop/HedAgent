import 'package:flutter/material.dart';
import 'package:hedagent/constants/texts.dart';
import 'package:hedagent/constants/widgets/header_widget.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerWidget(ImagePath.smallIconPath, Texts.appNameText, [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_outlined),
        ),
        // ClipRRect(
        //   borderRadius: BorderRadius.circular(999),
        //   child: Image.asset(ImagePath.studentPicPath, fit: BoxFit.contain),
        // ),
      ]),
    );
  }
}
