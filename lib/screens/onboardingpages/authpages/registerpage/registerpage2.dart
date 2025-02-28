import 'package:flutter/material.dart';
import 'registerpage3.dart'; // Import your third registration page

class RegistrationPage2 extends StatefulWidget {
  @override
  _RegistrationPage2State createState() => _RegistrationPage2State();
}

class _RegistrationPage2State extends State<RegistrationPage2> {
  int selectedIndex = 1;

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
                      'Personal Info',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    _buildInputField('Any disease?', 'Add if any, None'),
                    _buildInputField('Any injuries?', 'Add if any, None'),
                    _buildInputField('Parent’s Details', 'Add Parent’s Name'),
                    _buildInputField('Contact', '+91 000000000000'),
                    _buildInputField('OCCUPATION', 'Business, Salaried, Other, Self Employed'),
                    _buildInputField('Address', 'Add Address max 100 Characters'),
                    _buildInputField('REMARKS', 'Add Remarks max 100 Characters'),
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
                  MaterialPageRoute(builder: (context) => RegistrationPage3()),
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
