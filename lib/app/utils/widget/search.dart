// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildSearch({required dynamic Controller}) {
  final TextEditingController searchController = TextEditingController();
  searchController.text = Controller.querydata.value;

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
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                Controller.filterWords(value);
              },
              style: const TextStyle(fontSize: 16),
              decoration: const InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(fontSize: 16, color: Color(0xFF3193F5)),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),

          /// Clear button (reactive to controller state)
          Obx(() {
            return Controller.querydata.value.isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      searchController.clear();
                      Controller.filterWords("");
                    },
                    child: const Icon(
                      Icons.clear,
                      color: Colors.blue,
                      size: 20,
                    ),
                  )
                : const SizedBox.shrink();
          }),
        ],
      ),
    ),
  );
}
