import 'package:flutter/material.dart';

class BatchSelectionPage extends StatefulWidget {
  const BatchSelectionPage({Key? key}) : super(key: key);

  @override
  _BatchSelectionPageState createState() => _BatchSelectionPageState();
}

class _BatchSelectionPageState extends State<BatchSelectionPage> {
  String selectedBatch = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Navigate to the next page
            },
            child: Text(
              'Skip',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Text(
                'Choose',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              _buildBatchContainer('Beginner', 'Description for Beginner'),
              _buildBatchContainer('Morning Batch', 'Description for Morning Batch'),
              _buildBatchContainer('Evening Batch', 'Description for Evening Batch'),
              _buildBatchContainer('Summer Camp Students', 'Description for Summer Camp Students'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement your continue action here
                },
                style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.purple,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBatchContainer(String batchName, String description) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedBatch = batchName;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: selectedBatch == batchName ? Colors.purple : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              batchName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
