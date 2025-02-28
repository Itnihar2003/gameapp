import 'package:flutter/material.dart';
import 'package:coachui/screens/onboardingpages/authpages/otp.dart';
import 'package:coachui/screens/onboardingpages/authpages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:coachui/features/bottomnavigationbar/bottomnavigation.dart';
import 'package:coachui/features/bottomnavigationbar/bottomnavigationbar2.dart'; // Make sure this is the correct import
import 'package:coachui/apifolder/getuser.dart'; // Import your UserService

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Widget _buildInputContainer(Widget child) {
    return Container(
      width: 400,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }

  Future<void> _handleNavigation(BuildContext context, User user) async {
    // Fetch user data from backend
    final userData = await UserService.getUser(user.uid);

    if (userData != null) {
      String role = userData['role'];
      if (role == 'Player') {
        // Navigate to Navigation()
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Navigation()),
        );
      } else if (role == 'Coach') {
        // Navigate to BottomNavigationBar2()
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Navigation2()),
        );
      } else {
        // Handle other roles or default case
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unknown role: $role')),
        );
      }
    } else {
      // Handle the case where user data could not be fetched
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch user data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          // Added to prevent overflow
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),
              _buildInputContainer(
                TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    prefix: Text("+91 "),
                    hintText: 'Phone',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
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
                  onPressed: () async {
                    try {
                      String phoneNumber = _phoneController.text.trim();

                      // Validate phone number format
                      if (!RegExp(r'^\d{10}$').hasMatch(phoneNumber)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Invalid phone number format')),
                        );
                        return;
                      }

                      await FirebaseAuth.instance
                          .setLanguageCode('en'); // Set locale explicitly

                      await _auth.verifyPhoneNumber(
                       phoneNumber: '+91' + phoneNumber,
                        verificationCompleted:
                            (PhoneAuthCredential credential) async {
                          try {
                            UserCredential userCredential =
                                await _auth.signInWithCredential(credential);
                            User? user = userCredential.user;

                            if (user != null) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Sign in successful')),
                                );

                                // await _callHelloWorldEndpoint();
                                // await _createUserInBackend(user);

                                // Handle navigation based on role
                                await _handleNavigation(context, user);
                              }
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Error: ${e.toString()}')),
                              );
                            }
                          }
                        },
                        verificationFailed: (FirebaseAuthException e) {
                          if (context.mounted) {
                            String errorMsg = e.message ??
                                'Verification failed due to an unknown error';
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Verification failed: $errorMsg')),
                            );
                          }
                        },
                        codeSent: (String verificationId, int? resendToken) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OTPPage(
                                fromSignIn: true,
                                phoneNumber: _phoneController.text,
                                verificationId: verificationId,
                              ),
                            ),
                          );
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {
                          // Handle auto-retrieval timeout logic if needed
                        },
                      );
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${e.toString()}')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Sign In with Phone',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              //google authentication

              ElevatedButton(
                onPressed: () async {
                  try {
                    final GoogleSignInAccount? googleUser =
                        await _googleSignIn.signIn();
                    if (googleUser != null) {
                      final GoogleSignInAuthentication googleAuth =
                          await googleUser.authentication;
                      final AuthCredential credential =
                          GoogleAuthProvider.credential(
                        accessToken: googleAuth.accessToken,
                        idToken: googleAuth.idToken,
                      );

                      UserCredential userCredential =
                          await _auth.signInWithCredential(credential);
                      final user = userCredential.user;

                      if (user != null && context.mounted) {
                        await _callHelloWorldEndpoint();
                        await _createUserInBackend(user);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Sign in with Google successful')),
                        );

                        // New code: Handle navigation based on role
                        await _handleNavigation(context, user);
                      }
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${e.toString()}')),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                ),
                child: const Text(
                  'Sign In with Google',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(height: MediaQuery.of(context).size.height * 0.28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 90.0),
                child: Row(
                  children: [
                    const Text(
                      'Have an account? ',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()),
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xFF7850BF),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _callHelloWorldEndpoint() async {
    const String helloUrl =
        'https://8216-2409-40e2-121a-ca8e-4ced-ead6-c091-b0fc.ngrok-free.app/api/users/hello';

    try {
      final response = await http.get(Uri.parse(helloUrl));

      if (response.statusCode == 200) {
        print('Hello World request successful');
      } else {
        print('Failed to call Hello World endpoint');
      }
    } catch (e) {
      print('Error calling Hello World endpoint: $e');
    }
  }

  Future<void> _createUserInBackend(User user) async {
    const String url =
        'https://8216-2409-40e2-121a-ca8e-4ced-ead6-c091-b0fc.ngrok-free.app/api/users/createUser';
    Map<String, String> headers = {"Content-Type": "application/json"};

    Map<String, dynamic> body = {
      "firebaseUid": user.uid,
      "name": user.displayName ?? "Default Name",
      "mobileNumber": user.phoneNumber ?? "0000000000",
      "email": user.email ?? "default@example.com",
      "gender": "Male"
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 201) {
        print('User created successfully in backend');
      } else {
        print('Failed to create user in backend');
      }
    } catch (e) {
      print('Error creating user in backend: $e');
    }
  }
}
