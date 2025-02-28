import 'package:flutter/material.dart';
import 'package:coachui/screen2/recentapplication/recentapplicationdat.dart';
class RecentApplicationEdit1 extends StatelessWidget {
  final List<Map<String, String>> users = [
    {
      'name': 'Abhishek Singh',
      'batch': 'U-19',
      'date': 'Aug 24, 2022',
      'email': 'abhishek@gmail.com',
      'phone': '+91 91202112210',
      'status': 'ACTIVE',
    },
    {
      'name': 'Avish Yadav',
      'batch': 'U-23',
      'date': 'Apr 12, 2020',
      'email': 'triston.bode@example.com',
      'phone': '(444) 342-763',
      'status': 'ENQUIRY',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Center(
          child: Text(
            'Recent Applications',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: users
                .map((user) =>
                    UserContainer(user: user, screenWidth: screenWidth))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class UserContainer extends StatefulWidget {
  final Map<String, String> user;
  final double screenWidth;

  UserContainer({required this.user, required this.screenWidth});

  @override
  _UserContainerState createState() => _UserContainerState();
}

class _UserContainerState extends State<UserContainer> {
  late String status;
  bool isApproved = false; // Track if "Approve" button has been clicked

  @override
  void initState() {
    super.initState();
    status = widget.user['status']!;
  }

  void toggleStatus() {
    setState(() {
      status = status == 'ACTIVE' ? 'ENQUIRY' : 'ACTIVE';
    });
  }

  void approveApplication() {
    setState(() {
      isApproved = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.screenWidth,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.user['name'] ?? 'Name Here',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: status == 'ACTIVE'
                          ? Colors.green[100]
                          : Colors.blue[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: status == 'ACTIVE' ? Colors.green : Colors.blue,
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'Toggle Status') {
                        toggleStatus();
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return {'Toggle Status'}.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                    icon: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Date of Register',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Text(
            widget.user['date'] ?? 'Date',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user['email'] ?? 'email@example.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Divider(
                  color: Colors.grey[400],
                  thickness: 1,
                ),
                Text(
                  widget.user['phone'] ?? '+91 234 567 890',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          if (!isApproved) // Show "View" and "Approve" buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecentApplicationData(), // Specify your page here
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    minimumSize: Size(widget.screenWidth * 0.4, 0),
                  ),
                  child: Text(
                    'View',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: approveApplication,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    minimumSize: Size(widget.screenWidth * 0.4, 0),
                  ),
                  child: Text(
                    'Approve',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          else // Show "Approved" button
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  minimumSize: Size(widget.screenWidth * 0.8, 0),
                ),
                child: Text(
                  'Approved',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

