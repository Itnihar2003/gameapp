import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:coachui/apifolder/UserService.dart';  // Import UserService
import 'package:firebase_auth/firebase_auth.dart';  // Import FirebaseAuth to get firebaseUid
import 'package:flutter/services.dart';  // For TextInputFormatter
import 'package:intl/intl.dart';  // For DateFormat

class ProfileScreen extends StatefulWidget {
  final String name;
  final String weight;
  final String dob;
  final String height;

  ProfileScreen({
    required this.name,
    required this.weight,
    required this.dob,
    required this.height,
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _weightController;
  late TextEditingController _dobController;
  late TextEditingController _heightController;
  String? firebaseUid;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _weightController = TextEditingController(text: widget.weight);
    _dobController = TextEditingController(text: widget.dob);
    _heightController = TextEditingController(text: widget.height);
    _getFirebaseUid(); // Fetch the firebaseUid
  }

  // Get the current logged-in user's firebaseUid
  void _getFirebaseUid() async {
    try {
      User? firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        setState(() {
          firebaseUid = firebaseUser.uid; // Set firebaseUid
        });
      }
    } catch (e) {
      print('Error fetching firebaseUid: $e');
    }
  }

  void _saveProfile() async {
    // Ensure firebaseUid is available
    if (firebaseUid == null) {
      print('Firebase UID not found');
      return;
    }

    // Get updated values from controllers
    String name = _nameController.text;
    String weight = _weightController.text;
    String height = _heightController.text;
    String dob = _dobController.text;

    // Validate weight and height to make sure they are valid numbers
    double? parsedWeight = double.tryParse(weight);
    double? parsedHeight = double.tryParse(height);

    // Validate date of birth (ensure it's in valid format)
    DateTime? parsedDob = DateTime.tryParse(dob);
    
    if (parsedWeight == null || parsedHeight == null || parsedDob == null) {
      // If any of the fields are invalid, show an error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid values for weight, height, and birth date.')),
      );
      return;
    }

    // Call UserService to update user information
    var result = await UserService.updateUserInfo(
      firebaseUid: firebaseUid!,
      name: name,
      weight: parsedWeight,  // Convert to double
      height: parsedHeight,  // Convert to double
      birthDate: dob,  // Pass the dob as a string
    );

    if (result != null) {
      // Handle success response from the API
      print("Profile updated successfully: $result");

      // You can return the updated data back to the previous screen
      Navigator.pop(context, {
        'name': name,
        'weight': weight,
        'dob': dob,
        'height': height,
      });
    } else {
      // Handle failure response
      print("Failed to update profile.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile.')),
      );
    }
  }

  String _getInitials(String name) {
    final names = name.split(' ');
    return names.map((n) => n[0]).take(2).join().toUpperCase(); // Get initials from both first and last name
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(),
            Text(
              'Account Information',
              style: TextStyle(color: Colors.black),
            ),
            Spacer(),
            GestureDetector(
              onTap: _saveProfile, // Trigger _saveProfile when save is tapped
              child: Text(
                'Save',
                style: TextStyle(color: Colors.purple, fontSize: 16),
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: Container(
                alignment: Alignment.center,
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300],
                ),
                child: Text(
                  _getInitials(_nameController.text),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildProfileField("Name", _nameController),
            _buildProfileField("Weight", _weightController, isNumeric: true),
            _buildProfileField("Height", _heightController, isNumeric: true),
            _buildProfileField("Date of Birth", _dobController, isDate: true),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField(
    String label,
    TextEditingController controller, {
    bool isNumeric = false,
    bool isDate = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextField(
                controller: controller,
                keyboardType: isNumeric
                    ? TextInputType.numberWithOptions(decimal: true)
                    : isDate
                        ? TextInputType.datetime
                        : TextInputType.text,
                inputFormatters: isNumeric
                    ? [FilteringTextInputFormatter.digitsOnly]
                    : [],
                onTap: isDate
                    ? () => _selectDate(context)
                    : null, // Show date picker when tapping the DOB field
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: isDate
                      ? Icon(Icons.calendar_today, color: Colors.grey)
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}