import 'package:flutter/material.dart';
import 'package:coachui/screens/onboardingpages/authpages/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool? _agreeToTerms = false;
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),
              _buildInputField(screenWidth, 'Phone', controller: _phoneController),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  children: [
                    Radio<bool>(
                      value: true,
                      groupValue: _agreeToTerms,
                      onChanged: (bool? value) {
                        setState(() {
                          _agreeToTerms = value;
                        });
                      },
                    ),
                    const Text('I agree to the terms and conditions'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF7850BF),
                      Color(0xFF512DA8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ElevatedButton(
                  onPressed: _agreeToTerms == true
                      ? () async {
                          try {
                            await _auth.verifyPhoneNumber(
                              phoneNumber: _phoneController.text,
                              verificationCompleted: (PhoneAuthCredential credential) async {
                                await _auth.signInWithCredential(credential);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('User created successfully')),
                                );
                              },
                              verificationFailed: (FirebaseAuthException e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Verification failed: ${e.message}')),
                                );
                              },
                              codeSent: (String verificationId, int? resendToken) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OTPPage(
                                      fromSignIn: false,
                                      phoneNumber: _phoneController.text,
                                      verificationId: verificationId,
                                    ),
                                  ),
                                );
                              },
                              codeAutoRetrievalTimeout: (String verificationId) {},
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: ${e.toString()}')),
                            );
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(double screenWidth, String hintText, {TextEditingController? controller}) {
    return Container(
      width: screenWidth * 0.8,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}



