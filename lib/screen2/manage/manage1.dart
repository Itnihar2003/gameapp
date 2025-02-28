import 'package:flutter/material.dart';
import 'package:coachui/screen2/expensepages/expense.dart';
import 'package:coachui/screen2/createbatchpage/createbatchpage1.dart'; // Batch creation page
import 'package:coachui/screen2/creatematchpage/creatematchpage1.dart'; // Match creation page
import 'package:coachui/screen2/FeeDashboardCode/feedashboard.dart';
import 'package:coachui/screen2/recentapplication/recentapplication.dart';
import 'package:coachui/screen2/detailedfeehistorypages/batch_list_page.dart';

class ManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            'Manage',
            style: TextStyle(color: Colors.black),
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildContainer(context, 'Expense Tracker', ExpensePage()),
            SizedBox(height: 20),
            _buildContainer(context, 'Generate Invoice', DashboardScreen()),
            SizedBox(height: 20),
            _buildContainer(context, 'Create Batch', CreateBatchAndViewPage()), // Navigate to Batch Page
            SizedBox(height: 20),
            _buildContainer(context, 'Create Match', CreateMatchPage()), // Navigate to Match Page
            SizedBox(height: 20),
            _buildContainer(context, 'Recent Application', RecentApplicationPage()),
            SizedBox(height: 20),
            _buildContainer(context, 'Batches and Student', BatchListPage()),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer(
      BuildContext context, String title, Widget targetPage) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetPage),
          );
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            // Apply the LinearGradient instead of a solid color
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 100, 51, 186),
                Color.fromARGB(255, 120, 91, 188),
              ],
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
