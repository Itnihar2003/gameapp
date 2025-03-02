import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:coachui/features/bottomnavigationbar/bottomnavigation.dart';
import 'package:coachui/features/bottomnavigationbar/bottomnavigationbar2.dart';
import 'package:coachui/screens/onboardingpages/authpages/registerpage/registerpage1.dart';
import 'package:coachui/apifolder/getuser.dart'; // Import your UserService

class OTPPage extends StatefulWidget {
  final bool fromSignIn;
  final String phoneNumber;
  final String verificationId;

  OTPPage({
    Key? key,
    required this.fromSignIn,
    required this.phoneNumber,
    required this.verificationId,
  }) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _otpController = TextEditingController();

  Future<void> _createUserInBackend(String firebaseUid, String mobileNumber) async {
    const String url = 'http://wswogwcs08gcw4c840s8wwsw.152.70.67.68.sslip.io/api/users/createUser';
    Map<String, String> headers = {"Content-Type": "application/json"};

    Map<String, dynamic> body = {
      "firebaseUid": firebaseUid,
      "mobileNumber": mobileNumber,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 201) {
        print('User created successfully in backend');
      } else if (response.statusCode == 400 && json.decode(response.body)['error'] == 'User already exists') {
        print('User already exists in backend');
      } else {
        throw Exception('Failed to create user: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Backend error: ${e.toString()}')),
      );
      rethrow; // Rethrow to handle navigation failure
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Phone Verification',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'We sent a code to your number',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  controller: _otpController,
                  onChanged: (value) {},
                  onCompleted: (value) async {
                    try {
                      PhoneAuthCredential credential = PhoneAuthProvider.credential(
                        verificationId: widget.verificationId,
                        smsCode: value,
                      );

                      UserCredential userCredential = await _auth.signInWithCredential(credential);
                      User? user = userCredential.user;

                      if (user != null) {
                        // Call backend API to create/sync user
                        await _createUserInBackend(user.uid, user.phoneNumber ?? widget.phoneNumber);

                        if (widget.fromSignIn) {
                          // Sign-in flow: Check role and navigate
                          final userData = await UserService.getUser(user.uid);
                          if (userData != null && userData.containsKey('role')) {
                            String role = userData['role'];
                            if (role == 'Player') {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Navigation()),
                              );
                            } else if (role == 'Coach') {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Navigation2()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Unknown role: $role')),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Failed to fetch user data or role not set')),
                            );
                          }
                        } else {
                          // Sign-up flow: Navigate to RegistrationPage
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => RegistrationPage()),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Authentication failed')),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${e.toString()}')),
                      );
                    }
                  },
                  textStyle: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  enablePinAutofill: true,
                  autoFocus: true,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 52.0),
                child: Row(
                  children: const [
                    Text(
                      'Not received the code?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Resend',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {}, // Optionally implement manual verification
                child: const Text("Verify and Proceed"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}