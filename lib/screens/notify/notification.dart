import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Notification',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NotificationDateHeader(date: '10, July, 2024'),
              NotificationItem(
                imageAsset: 'assets/u8.png',
                message: 'Fee Due',
              ),
              NotificationItem(
                imageAsset: 'assets/u8.png',
                message: 'Attendance Marked',
              ),
              SizedBox(height: 16),
              NotificationDateHeader(date: '1, July, 2024'),
              NotificationItem(
                imageAsset: 'assets/u8.png',
                message: 'You have a match tomorrow!',
              ),
              NotificationItem(
                imageAsset: 'assets/u8.png',
                message: 'Welcome!',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationDateHeader extends StatelessWidget {
  final String date;

  const NotificationDateHeader({required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        date,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String imageAsset;
  final String message;

  const NotificationItem({
    required this.imageAsset,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Image.asset(
              imageAsset,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
