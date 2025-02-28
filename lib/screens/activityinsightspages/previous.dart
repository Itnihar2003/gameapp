import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'upcoming.dart'; // Import the upcoming page

class Activityprev extends StatefulWidget {
  @override
  _ActivityprevState createState() => _ActivityprevState();
}

class _ActivityprevState extends State<Activityprev> {
  bool isCurrentSelected = false; // Previous is selected by default

  final List<DateTime> dates = [
    DateTime(2024, 7, 1),
    DateTime(2024, 7, 2),
    DateTime(2024, 7, 3),
  ];

  // List of batch names for the "Batch Name V/S Batch Name" display
  final List<String> batchMatches = [
    'U-12 V/S U-14',
    'U-16 V/S U-18',
    'U-14 V/S U-19',
  ];

  // List of results for "won by XX runs" display
  final List<String> matchResults = [
    'U-12 won by 20 runs',
    'U-16 won by 15 runs',
    'U-14 won by 5 runs',
  ];

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('My Batch'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ToggleButton(
                text: 'Upcoming',
                isSelected: isCurrentSelected,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Activityupcoming(), // Navigate to upcoming.dart
                    ),
                  );
                },
                width: MediaQuery.of(context).size.width * 0.4,
              ),
              ToggleButton(
                text: 'Previous',
                isSelected: !isCurrentSelected,
                onTap: () {
                  setState(() {
                    isCurrentSelected = false; // Already on previous, so no navigation
                  });
                },
                width: MediaQuery.of(context).size.width * 0.4,
              ),
            ],
          ),
          SizedBox(height: 20),
          for (int i = 0; i < dates.length; i++)
            Container(
              width: containerWidth,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('MMMM d, y').format(dates[i]),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Stack(
                    children: [
                      Container(
                        height: 70, // Increased height to accommodate the result text
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF7850BF),
                              Color(0xFF512DA8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                batchMatches[i], // Display batch names like 'U-12 V/S U-14'
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5), // Space between batch and result
                              Text(
                                matchResults[i], // Display match results like 'U-12 won by 20 runs'
                                style: TextStyle(
                                  color: Colors.white70, // Light white color for the match results
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.check,
                              color: Color(0xFF6A41B8), // Kept the check icon color
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class ToggleButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final double width;

  ToggleButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    Color(0xFF7850BF),
                    Color(0xFF512DA8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
