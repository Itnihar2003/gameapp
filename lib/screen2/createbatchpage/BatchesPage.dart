import 'package:flutter/material.dart';
import 'package:coachui/apifolder/getuser.dart';  // Import your UserService
import 'package:coachui/screen2/createbatchpage/studentdata.dart'; // StudentListPage

class BatchesPage extends StatefulWidget {
  final List<Map<String, dynamic>> subBatches;

  BatchesPage({required this.subBatches});

  @override
  _BatchesPageState createState() => _BatchesPageState();
}

class _BatchesPageState extends State<BatchesPage> {
  bool isLoading = false;
  List<Map<String, dynamic>> students = [];

  // Function to fetch user details for the given user IDs
  void _getStudents(List<String> userIds) async {
    setState(() {
      isLoading = true;
    });

    try {
      final userDetails = await UserService.getUserDetailsInSubBatch(userIds);
      if (userDetails != null) {
        setState(() {
          students = userDetails;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching students: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

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
          'Batches',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: widget.subBatches.isEmpty
          ? Center(child: Text('No batches found'))
          : ListView.builder(
              itemCount: widget.subBatches.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> batch = widget.subBatches[index];
                String batchName = batch['name'] ?? 'No name available';
                String batchDate = batch['date'] ?? 'No date available';
                String description = batch['description'] ?? 'No description';
                List<String> userIds = List<String>.from(batch['users'] ?? []);

                return GestureDetector(
                  onTap: () {
                    if (userIds.isNotEmpty) {
                      _getStudents(userIds); // Fetch student data when the batch is tapped

                      // Navigate to StudentListPage with user data
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentListPage(
                            students: students,  // Pass the student data
                          ),
                        ),
                      );
                    } else {
                      // If no users in the batch, show a message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('No players found in this batch')),
                      );
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          batchDate,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          batchName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}