import 'package:flutter/material.dart';

class MyBatchPage2 extends StatefulWidget {
  @override
  _MyBatchPage2State createState() => _MyBatchPage2State();
}

class _MyBatchPage2State extends State<MyBatchPage2> {
  bool isCurrentSelected = true; // Current is selected by default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back action
            Navigator.pop(context);
          },
        ),
        title: Text('My Batch'),
        centerTitle: true, // Ensures the title is centered
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ToggleButton(
                text: 'Current',
                isSelected: !isCurrentSelected, // Selected when previous is not
                onTap: () {
                  setState(() {
                    isCurrentSelected = false; // Select Current
                  });
                  Navigator.pop(context); // Navigate back to current page
                },
                width: MediaQuery.of(context).size.width * 0.4,
              ),
              ToggleButton(
                text: 'Previous',
                isSelected: isCurrentSelected, // Previous selected when true
                onTap: () {
                  setState(() {
                    isCurrentSelected = true; // Select Previous
                  });
                },
                width: MediaQuery.of(context).size.width * 0.4,
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: 10, // Number of containers
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // Slightly darker shade of white
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Batch Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Small grey text',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          // Replacing purple with linear gradient
                          gradient: LinearGradient(
                            colors: [Color(0xFF7850BF), Color(0xFF512DA8)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                );
              },
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
          // Replacing purple with linear gradient
          gradient: isSelected
              ? LinearGradient(
                  colors: [Color(0xFF7850BF), Color(0xFF512DA8)],
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
