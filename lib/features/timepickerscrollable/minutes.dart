import 'package:flutter/material.dart';

class MyMinutes extends StatelessWidget {
  final int mins;

  MyMinutes({required this.mins});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        // height: 100, 
        // width: 100, 
       // color: Colors.blue,
        child: Center(
          child: Text(
            mins < 10 ? '0$mins' : mins.toString(),
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