import 'package:flutter/material.dart';
import 'package:coachui/features/calenderhorizontal/calenderhori.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coachui/apifolder/getuser.dart'; // Import the service to get user data
import 'package:coachui/apifolder/markattendance.dart'; // Import the service to mark attendance
import 'package:coachui/screens/notify/notification.dart';
class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? userName;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  void _getUserData() async {
    try {
      // Get the current logged-in user
      User? firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        // Fetch user data from backend using firebaseUid
        final userData = await UserService.getUser(firebaseUser.uid);
        if (userData != null) {
          setState(() {
            userName = userData['name'];
          });
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  // Method to determine the greeting based on the current time
  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  void _markAttendance() async {
    try {
      User? firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        // You can use real-time location here
        double latitude = 21.4974; // Example latitude (use geolocator for real values)
        double longitude = 83.9040; // Example longitude (use geolocator for real values)

        // Mark attendance using the attendance service
        final response = await AttendanceService.markAttendance(
          firebaseUser.uid,
          latitude,
          longitude,
        );

        if (response != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response['message'])),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to mark attendance')),
          );
        }
      }
    } catch (e) {
      print('Error marking attendance: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred while marking attendance')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('MMM dd, yyyy').format(DateTime.now());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dashboard',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  // Notification icon using Image.asset
                  GestureDetector(
                    onTap: () {
                       Navigator.push(
                       context,
                       MaterialPageRoute(
                       builder: (context) => NotificationScreen(), // Replace with your NotificationPage
                       ),
                    );
                    },
                    child: Image.asset(
                      'assets/u4.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              // Display the dynamic greeting based on the time
              Text(
                getGreeting(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 16),
              HorizontalCalendar(),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.height * 0.13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF7850BF),
                        Color(0xFF512DA8),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'U-12',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: 4),
                              // Replace the dummy text with actual user name
                              Text(
                                userName ?? 'Loading...',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color.fromARGB(255, 100, 51, 186),
                                      Color.fromARGB(255, 120, 91, 188),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month_outlined,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      formattedDate,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF7850BF),
                        Color(0xFF512DA8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30.0),
                      ),
                      elevation: 0,
                    ),
                    onPressed: _markAttendance, // Mark Attendance Button
                    child: Text(
                      'Mark your Attendance',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Summary',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      _buildSummaryBox(
                        title: 'Attendance',
                        percent: 0.75,
                        label: '75%',
                        subLabel: 'Attended',
                      ),
                      SizedBox(height: 8),
                      _buildSummaryBox(
                        title: 'Upcoming Matches',
                        label: '2',
                        subLabel: 'matches',
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      _buildSummaryBox(
                        title: 'Fee Status',
                        percent: 0.5,
                        label: '50%',
                        subLabel: 'Paid',
                      ),
                      SizedBox(height: 8),
                      _buildSummaryBox(
                        title: 'Previous Matches',
                        label: '3',
                        subLabel: 'matches',
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryBox({
    required String title,
    double? percent,
    required String label,
    required String subLabel,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          percent != null
              ? CircularPercentIndicator(
                  circularStrokeCap: CircularStrokeCap.round,
                  radius: 40.0,
                  lineWidth: 8.0,
                  percent: percent,
                  center: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          label,
                          style:
                              TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          subLabel,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  progressColor: Color(0xFF6A41B8),
                  backgroundColor: Colors.grey.shade200,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      subLabel,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}