import 'package:flutter/material.dart';

class HeightSelectionPage extends StatefulWidget {
  const HeightSelectionPage({Key? key}) : super(key: key);

  @override
  _HeightSelectionPageState createState() => _HeightSelectionPageState();
}

class _HeightSelectionPageState extends State<HeightSelectionPage> {
  bool isFeetSelected = true;
  String heightValue = '0';

  void _showInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Height'),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                heightValue = value;
              });
            },
            decoration: InputDecoration(hintText: 'Enter Height'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

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
  height: MediaQuery.of(context).size.height * 0.185, 
),
              Text(
                'Select Height',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Feet'),
                  Switch(
                    value: isFeetSelected,
                    onChanged: (value) {
                      setState(() {
                        isFeetSelected = value;
                      });
                    },
                  ),
                  Text('Centimeter'),
                ],
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 140),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => _showInputDialog(context),
                      child: Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey[200],
                        alignment: Alignment.center,
                        child: Text(
                          heightValue,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      isFeetSelected ? 'ft' : 'cm',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20), // Adjust the space between content and button
              ElevatedButton(
                onPressed: () {
                  // Implement your continue action here
                },
                style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.purple,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
