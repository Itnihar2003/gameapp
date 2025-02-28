import 'package:flutter/material.dart';

class MatchViewScreen extends StatelessWidget {
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
          'View All',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              MatchContainer(
                matchType: 'FRIENDLY MATCH',
                time: '2:00 P.M.',
                status: 'UPCOMING',
                statusColor: Color(0xFF7850BF), // Purple color
                leftBatch: 'U-13',
                rightBatch: 'U-13',
              ),
              MatchContainer(
                matchType: 'FRIENDLY MATCH',
                time: '2:00 P.M.',
                status: 'UPCOMING',
                statusColor: Color(0xFF7850BF),
                leftBatch: 'U-13',
                rightBatch: 'U-13',
              ),
              MatchContainer(
                matchType: 'FRIENDLY MATCH',
                time: '2:00 P.M.',
                status: 'U-13 WON',
                statusColor: Color(0xFF512DA8), // Darker purple
                leftBatch: 'U-13',
                rightBatch: 'U-13',
              ),
              MatchContainer(
                matchType: 'FRIENDLY MATCH',
                time: '2:00 P.M.',
                status: 'U-13 WON',
                statusColor: Color(0xFF512DA8),
                leftBatch: 'U-13',
                rightBatch: 'U-13',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MatchContainer extends StatelessWidget {
  final String matchType;
  final String time;
  final String status;
  final Color statusColor;
  final String leftBatch;
  final String rightBatch;

  const MatchContainer({
    required this.matchType,
    required this.time,
    required this.status,
    required this.statusColor,
    required this.leftBatch,
    required this.rightBatch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            matchType,
            style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0xFF7850BF), // Purple color
                    child: Text(
                      leftBatch,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    leftBatch,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    time,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey.shade300,
                  ),
                  SizedBox(height: 4),
                  Text(
                    rightBatch,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
