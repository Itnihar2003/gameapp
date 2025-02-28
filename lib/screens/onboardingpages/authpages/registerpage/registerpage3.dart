import 'package:flutter/material.dart';
//import 'package:coachui/screens/homepage/navigation.dart'; // Import your Navigation screen
import 'package:coachui/features/bottomnavigationbar/bottomnavigation.dart';

class RegistrationPage3 extends StatefulWidget {
  @override
  _RegistrationPage3State createState() => _RegistrationPage3State();
}

class _RegistrationPage3State extends State<RegistrationPage3> {
  int selectedIndex = 2; // Default to the third toggle button

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
                  width: 80,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.0),
                    color: selectedIndex == index ? Colors.yellow : Colors.grey[300],
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
                      'Batch Info',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    _buildInputField('Coach Name', 'Choose Coach'),
                    _buildInputField('Date of Joining', 'Select the student’s date of joining'),
                    _buildInputField('SUPER Batch', 'Choose Super Batch'),
                    _buildInputField('Sub Batch', 'Sub Batch'),
                    _buildInputField('FEE AMOUNT', 'Add Fee'),
                    _buildInputField('FEE TENURE', 'Fee Tenure'),
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
                // Navigate to the Navigation screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Navigation()), // Change here
                );
              },
              child: Text('Register',
                style: TextStyle(color: Colors.white),),
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
