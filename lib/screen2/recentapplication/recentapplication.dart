import 'package:flutter/material.dart';
import 'package:coachui/features/searchbar/searchbar1.dart';
import 'package:coachui/features/filter/filter .dart';
import 'package:coachui/features/filter/applications.dart';
//import 'package:coachui/screen2/recentapplication/recentapplicationdat.dart';
import 'package:coachui/screen2/recentapplication/recentapplicationeit1.dart';
class RecentApplicationPage extends StatefulWidget {
  @override
  _RecentApplicationPageState createState() => _RecentApplicationPageState();
}

class _RecentApplicationPageState extends State<RecentApplicationPage> {
  String? _selectedBatch;

  void _onBatchSelected(String? batch) {
    setState(() {
      _selectedBatch = batch;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            'Recent Applications',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Container(
            width: 56.0,
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  buildSearchBar(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  SortByContainer(onBatchSelected: _onBatchSelected),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  RecentApplicationContainer(selectedBatch: _selectedBatch),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16.0,
            left: MediaQuery.of(context).size.width * 0.1, // Center the button horizontally
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecentApplicationEdit1(), // Placeholder for your specified page
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                   backgroundColor: Color(0xFF7850BF), // Button color
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                ),
                child: Text(
                  'See All Applications',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16, // Adjust font size as needed
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
