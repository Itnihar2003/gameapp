import 'package:flutter/material.dart';

class ProgressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text('Attendance'),
        ),
      ),
      body: Center(
        child: Text(
          'Progress Page Content',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}