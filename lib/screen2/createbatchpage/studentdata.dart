import 'package:flutter/material.dart';

class StudentListPage extends StatelessWidget {
  final List<Map<String, dynamic>> students;

  StudentListPage({required this.students});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: students.isEmpty
          ? Center(child: Text('No students found'))
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.sports_cricket, color: Colors.orange),
                  title: Text(students[index]['name']),
                  subtitle: Text(students[index]['role']),
                  trailing: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      students[index]['playerType'] ?? 'No type',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                );
              },
            ),
    );
  }
}