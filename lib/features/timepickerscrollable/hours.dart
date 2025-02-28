import 'package:flutter/material.dart';

class MyHours extends StatelessWidget {
  final int hours;

  MyHours({required this.hours});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        // height: 100, // Example height
        // width: 100, // Example width
        //color: Colors.blue, // Example background color
        child: Center(
          child: Text(
            hours.toString(),
            style: TextStyle(
              fontSize: 40,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}