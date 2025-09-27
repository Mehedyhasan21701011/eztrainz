import 'package:flutter/material.dart';

Widget buildSearch() {
  return Flexible(
    child: Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF4FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          /// Search Icon
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Image.asset(
              "assets/search.png",
              color: Colors.blue,
              height: 20,
              width: 20,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.search, color: Colors.blue, size: 20);
              },
            ),
          ),

          /// Text Field
          const Expanded(
            child: TextField(
              style: TextStyle(fontSize: 16),
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(fontSize: 16, color: Color(0xFF3193F5)),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
