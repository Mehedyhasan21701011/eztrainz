import 'package:flutter/material.dart';

Widget buildAddButton() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.blue, width: 2),
    ),
    child: Center(child: Icon(Icons.add, color: Colors.blue, size: 24)),
  );
}
