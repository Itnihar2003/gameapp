import 'package:flutter/material.dart';
import 'package:coachui/features/calenderhorizontal/calenderhori.dart';
import 'package:intl/intl.dart';
import 'package:coachui/screens/notify/notification.dart';

class DashboardScreen extends StatelessWidget {
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
              Text(
                'Good Morning',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 16),
              HorizontalCalendar(),
              SizedBox(height: 16),
              Text(
                'Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16),
              // Grid of Containers for Summary
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _summaryCard('Enquiries', '25', Colors.green[100]!, Colors.green),
                  _summaryCard('New Admission', '25', Colors.orange[100]!, Colors.orange),
                  _summaryCard('Total Students', '250', Colors.purple[100]!, Colors.purple),
                  _summaryCard('Amount Received', '₹25,00,000', Colors.green[100]!, Colors.green),
                  _summaryCard('Amount Pending', '₹5,00,000', Colors.orange[100]!, Colors.orange),
                  _summaryCard('Expenses', '₹25,000', Colors.purple[100]!, Colors.purple),
                  _summaryCard('Enquiries', '25', Colors.blue[100]!, Colors.blue),
                  _summaryCard('Enquiries', '25', Colors.blue[100]!, Colors.blue),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryCard(String title, String value, Color bgColor, Color barColor) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                color: barColor,
              ),
              SizedBox(width: 8),
              Text(
                value,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}