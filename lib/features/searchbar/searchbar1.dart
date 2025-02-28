import 'package:flutter/material.dart';

Widget buildSearchBar() {
  return Container(
    decoration: BoxDecoration(
    //  border: Border.all(color: Colors.grey),
    color: Color(0xFFF1F1F1),
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search...',
              ),
            ),
          ),

        ],
      ),
    ),
  );
}