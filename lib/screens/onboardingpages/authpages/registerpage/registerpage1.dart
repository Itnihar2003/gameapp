import 'package:flutter/material.dart';
import 'registerpage2.dart'; // Import your second registration page

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = (screenWidth * 0.9 - 16.0 * 2) / 3;

    List<Color> buttonColors = [
      Colors.grey[100]!,
      Colors.grey[200]!,
      Colors.grey[300]!,
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            'Registration',
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: [Container(width: 48)],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  width: buttonWidth,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.0),
                    color: selectedIndex == index ? Colors.yellow : buttonColors[index],
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Basic Information',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    _buildInputField('Full Name', 'Student Name'),
                    _buildInputField('Gender', 'Gender'),
                    _buildInputField('Birthday', 'Select the student date of birth'),
                    _buildInputField('Phone Number', '+91 000000000000'),
                    _buildInputField('Email Address', '@example.com'),
                    _buildInputField('Education', 'School, College, Graduated, Post Graduation'),
                    _buildInputField('Reference', 'Name of the Person, None'),
                    _buildInputField('Player Profile', 'Batsman, Bowler, Wicket Keeper, All Rounder'),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          SizedBox(
            width: screenWidth * 0.9,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF6A41B8)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationPage2()),
                );
              },
              child: Text('Next',
              style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Widget _buildInputField(String label, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
            ),
          ),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}
