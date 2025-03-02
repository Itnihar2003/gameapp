import 'package:flutter/material.dart';
import 'package:coachui/screens/onboardingpages/authpages/otp.dart';
import 'package:coachui/screens/onboardingpages/authpages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:coachui/features/bottomnavigationbar/bottomnavigation.dart';
import 'package:coachui/features/bottomnavigationbar/bottomnavigationbar2.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
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
                      if (!RegExp(r'^\d{10}$').hasMatch(phoneNumber)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid phone number format')),
                        );
                        return;
                      }

                      await _auth.setLanguageCode('en');
                      await _auth.verifyPhoneNumber(
                        phoneNumber: '+91$phoneNumber',
                        verificationCompleted: (PhoneAuthCredential credential) {
                          // Auto-verification is not handled here; leave empty or log for debugging
                        },
                        verificationFailed: (FirebaseAuthException e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Verification failed: ${e.message ?? "Unknown error"}')),
                          );
                        },
                        codeSent: (String verificationId, int? resendToken) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OTPPage(
                                fromSignIn: true,
                                phoneNumber: '+91$phoneNumber',
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
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
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
              ElevatedButton(
                onPressed: () async {
                  try {
                    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
                    if (googleUser != null) {
                      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
                      final AuthCredential credential = GoogleAuthProvider.credential(
                        accessToken: googleAuth.accessToken,
                        idToken: googleAuth.idToken,
                      );

                      UserCredential userCredential = await _auth.signInWithCredential(credential);
                      final user = userCredential.user;

                      if (user != null && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Sign in with Google successful')),
                        );
                        await _handleNavigation(context, user);
                      }
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${e.toString()}')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
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
                          MaterialPageRoute(builder: (context) => const SignUpPage()),
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
}