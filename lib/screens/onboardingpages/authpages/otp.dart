import 'package:coachui/screen2/dashboardpages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:coachui/features/bottomnavigationbar/bottomnavigation.dart';
import 'package:coachui/screens/onboardingpages/authpages/registerpage/registerpage1.dart';
import 'package:pinput/pinput.dart';

class OTPPage extends StatefulWidget {
  final bool fromSignIn;
  final String phoneNumber;
  final String verificationId;

  OTPPage(
      {Key? key,
      required this.fromSignIn,
      required this.phoneNumber,
      required this.verificationId})
      : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _otpController = TextEditingController();
  var code = "";
  signin() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: code);
    try {
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        Get.offAll(DashboardScreen());
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error found", e.code);
    }catch(e){
Get.snackbar("Error found", e.toString());
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
                  child:
                  //  Pinput(
                  //   length: 6,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       code = value;
                  //     });
                  //   },
                  // )

                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    controller: _otpController,
                    onChanged: (value) {},
                    onCompleted: (value) async {
                      bool otpVerified = false;

                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                          verificationId: widget.verificationId,
                          smsCode: value,
                        );
                        UserCredential userCredential =
                            await _auth.signInWithCredential(credential);
                        String firebaseUid = userCredential.user!.uid;

                        otpVerified = true;

                        if (widget.fromSignIn) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Sign in successful')),
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Navigation()),
                          );
                        } else {
                          print("api fetch");
                          final response = await _createUserInBackend(
                              firebaseUid, widget.phoneNumber);

                          if (response.statusCode == 201) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('User created successfully')),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationPage()),
                            );
                          } else {
                            String errorMessage = 'Failed to create user';
                            if (response.body.isNotEmpty) {
                              var responseData = json.decode(response.body);
                              if (responseData.containsKey('error')) {
                                errorMessage = responseData['error'];
                              }
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(errorMessage)),
                            );
                          }
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Invalid OTP. Please try again.')),
                        );
                      } finally {
                        // Call Hello World endpoint regardless of OTP verification status
                        await _callHelloWorldEndpoint(context, otpVerified);
                      }
                    },
                    // pinTheme: PinTheme(
                    //   shape: PinCodeFieldShape.box,
                    //   borderRadius: BorderRadius.circular(10),
                    //   fieldHeight: 35,
                    //   fieldWidth: 35,
                    //   inactiveFillColor: Colors.grey[200],
                    //   activeFillColor: Colors.white,
                    //   selectedFillColor: Colors.white,
                    // ),
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
                  onPressed: () {}, child: Text("verify and proceed"))
            ],
          ),
        ),
      ),
    );
  }

  Future<http.Response> _createUserInBackend(
      String firebaseUid, String mobileNumber) async {
    const String url =
        'https://b9f0-2401-4900-1c84-f1e7-c46d-d9f1-b93e-96f5.ngrok-free.app/api/users/createUser';
    Map<String, String> headers = {"Content-Type": "application/json"};

    Map<String, dynamic> body = {
      "firebaseUid": firebaseUid,
      "name": "Default Name", // Update with actual name input if available
      "mobileNumber": mobileNumber,
      "gender": "Unknown" // Update with actual gender if available
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(body),
    );

    return response;
  }

  Future<void> _callHelloWorldEndpoint(
      BuildContext context, bool otpVerified) async {
    const String helloUrl =
        'https://3079-2401-4900-1c85-85af-a4d1-735d-89b5-345d.ngrok-free.app/api/users/hello';

    try {
      final response = await http.get(Uri.parse(helloUrl));

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Hello World request successful: OTP Verified - $otpVerified')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to call Hello World endpoint: OTP Verified - $otpVerified')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Error calling Hello World endpoint: OTP Verified - $otpVerified')),
      );
    }
  }
}
