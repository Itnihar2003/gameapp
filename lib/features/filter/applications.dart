import 'package:flutter/material.dart';

class RecentApplicationContainer extends StatefulWidget {
  final String? selectedBatch;

  RecentApplicationContainer({this.selectedBatch});

  @override
  _RecentApplicationContainerState createState() => _RecentApplicationContainerState();
}

class _RecentApplicationContainerState extends State<RecentApplicationContainer> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Batch color mapping
    final Map<String, Color> batchColors = {
      'U-19': Colors.purple,
      'U-14': Colors.red,
      'U-16': Colors.grey,
      'Senior': Colors.black,
      'Summercamp': Colors.lightBlue,
    };

    // List of batch names
    final List<String> batchNames = ['U-14', 'U-16', 'U-19', 'Senior', 'Summercamp'];

    return Container(
      width: screenWidth * 0.9,
      height: screenHeight,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Application',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: batchNames.length, // Number of items in the list
              itemBuilder: (context, index) {
                String batchName = batchNames[index];

                // Filter based on selected batch
                if (widget.selectedBatch != null && widget.selectedBatch != batchName) {
                  return SizedBox.shrink(); // Skip the item if it doesn't match the selected batch
                }

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 4.0),
                  width: screenWidth * 0.8,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/avatar.png'),
                        radius: 25,
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Text(
                          'Name $index',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: batchColors[batchName],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          batchName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
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
