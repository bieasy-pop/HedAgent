import 'package:flutter/material.dart';

Widget messageChip({required Color color, required Widget body}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20),
      shape: BoxShape.rectangle,
    ),
    child: body,
  );
}
