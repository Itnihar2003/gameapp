import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'previous.dart'; // Import the previous page

class Activityupcoming extends StatefulWidget {
  @override
  _ActivityupcomingState createState() => _ActivityupcomingState();
}

class _ActivityupcomingState extends State<Activityupcoming> {
  bool isCurrentSelected = true; // Upcoming is selected by default

  final List<DateTime> dates = [
    DateTime(2024, 7, 1, 10, 30),
    DateTime(2024, 7, 2, 12, 00),
    DateTime(2024, 7, 3, 14, 15),
  ];

  final List<String> batchNames = ['U-12', 'U-14', 'U-16']; // List of batch names

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.9;

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
                  setState(() {
                    isCurrentSelected = true; // Already on upcoming, no navigation
                  });
                },
                width: MediaQuery.of(context).size.width * 0.4,
              ),
              ToggleButton(
                text: 'Previous',
                isSelected: !isCurrentSelected,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Activityprev(), // Navigate to previous.dart
                    ),
                  );
                },
                width: MediaQuery.of(context).size.width * 0.4,
              ),
            ],
          ),
          SizedBox(height: 20),
          for (int i = 0; i < dates.length; i++) ...[
            // Date above each container
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  DateFormat('MMMM d, y').format(dates[i]), // Date in black color
                  style: TextStyle(
                    color: Colors.black, // Dark black color
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Container
            Container(
              width: containerWidth,
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.all(10),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    batchNames[i], // Batch name on the left side
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('MMMM d, y').format(dates[i]), // Date at the center
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'V/S', // "V/S" below the date
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        DateFormat('h:mm a').format(dates[i]), // Time below "V/S"
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    batchNames[i], // Batch name on the right side
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
