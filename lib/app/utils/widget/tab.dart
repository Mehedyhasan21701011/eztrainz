import 'package:flutter/material.dart';

Widget buildTab(String title, bool isSelected) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    curve: Curves.easeInOut,
    padding: const EdgeInsets.symmetric(vertical: 12),
    decoration: BoxDecoration(
      color: isSelected ? const Color(0xFFF6F585) : Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.yellow.withOpacity(0.5), width: 1.5),
    ),
    child: Center(
      child: FittedBox(
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: isSelected
                ? const Color(0xFF3193F5)
                : Colors.black.withOpacity(.7),
          ),
        ),
      ),
    ),
  );
}
