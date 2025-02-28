import 'package:flutter/material.dart';
import 'package:coachui/screen2/creatematchpage/selecteam2.dart';

class SelectTeam1Page extends StatefulWidget {
  @override
  _SelectTeam1PageState createState() => _SelectTeam1PageState();
}

class _SelectTeam1PageState extends State<SelectTeam1Page> {
  final List<Student> students = [
    Student("Abhishek Singh", "Batsman", "assets/u11.png", false),
    Student("Avish Yadav", "All-Rounder", "assets/u11.png", false),
    Student("Anurag Mishra", "Wicket Keeper Batsman", "assets/u12.png", false),
    Student("Sami", "Fast Bowler", "assets/u13.png", false),
  ];

  void resetSelections() {
    setState(() {
      for (var student in students) {
        student.isSelected = false;
      }
    });
  }

  void navigateToNextPage() {
    bool isAnySelected = students.any((student) => student.isSelected);

    if (isAnySelected) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectTeam2Page(), // Replace with actual page
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select at least one student."),
        ),
      );
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
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Create Match",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Select Team 1",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: students.length,
              itemBuilder: (context, index) {
                return _buildStudentCard(students[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton("Discard", Colors.white, const Color(0xFF512DA8), resetSelections),
                _buildButton("Save", const Color(0xFF512DA8), Colors.white, navigateToNextPage),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentCard(Student student) {
    return GestureDetector(
      onTap: () {
        setState(() {
          student.isSelected = !student.isSelected;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Checkbox(
              value: student.isSelected,
              onChanged: (bool? value) {
                setState(() {
                  student.isSelected = value!;
                });
              },
              activeColor: const Color(0xFF512DA8),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    student.role,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Image.asset(
                student.imagePath,
                width: 40.0,
                height: 40.0,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String label, Color bgColor, Color textColor, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        minimumSize: Size(150, 50),
        side: BorderSide(color: const Color(0xFF512DA8)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      ),
      child: Text(
        label,
        style: TextStyle(color: textColor),
      ),
    );
  }
}

class Student {
  final String name;
  final String role;
  final String imagePath;
  bool isSelected;

  Student(this.name, this.role, this.imagePath, this.isSelected);
}
