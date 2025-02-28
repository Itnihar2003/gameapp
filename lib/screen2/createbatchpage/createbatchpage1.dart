import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coachui/apifolder/getuser.dart'; // Correct import for the UserService
import 'BatchesPage.dart';  // Import BatchesPage

class CreateBatchAndViewPage extends StatefulWidget {
  @override
  _CreateBatchAndViewPageState createState() => _CreateBatchAndViewPageState();
}

class _CreateBatchAndViewPageState extends State<CreateBatchAndViewPage> {
  List<Map<String, dynamic>> subBatches = [];
  TextEditingController batchNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<String> selectedSubBatches = ['Morning']; // Default selection as Morning
  String? creatorId; // Store the creatorId here
  bool isLoading = true; // Loading indicator
  String? userId; // To store user ID

  @override
  void initState() {
    super.initState();
    _getCreatorId(); // Fetch the creatorId when the page is initialized
    _getUserAndBatches(); // Fetch batches for the user
  }

  // Fetch the current user's creatorId (Firebase UID) using getUser
  void _getCreatorId() async {
    try {
      User? firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        final userData = await UserService.getUser(firebaseUser.uid);
        if (userData != null) {
          setState(() {
            creatorId = userData['_id']; // Store the _id of the creator
          });
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  // Fetch user and batches
  void _getUserAndBatches() async {
    try {
      User? firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        final userData = await UserService.getUser(firebaseUser.uid);
        if (userData != null) {
          setState(() {
            userId = userData['_id']; // Store the creatorId
          });

          if (userId != null) {
            final batches = await UserService.getAllBatches(userId!);
            if (batches != null) {
              setState(() {
                subBatches = batches;
                isLoading = false;
              });
            } else {
              setState(() {
                isLoading = false;
              });
            }
          }
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Show dialog for adding a batch
  void _showAddBatchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: EdgeInsets.all(16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add Batch',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: batchNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: 'Batch Name',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Sub-Batch Multi-Select (Morning / Evening)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CheckboxListTile(
                      title: Text('Morning'),
                      value: selectedSubBatches.contains('Morning'),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedSubBatches.add('Morning');
                          } else {
                            selectedSubBatches.remove('Morning');
                          }
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Evening'),
                      value: selectedSubBatches.contains('Evening'),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedSubBatches.add('Evening');
                          } else {
                            selectedSubBatches.remove('Evening');
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: 'Add Description',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.purple),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: Size(
                        MediaQuery.of(context).size.width * 0.2,
                        40,
                      ),
                    ),
                    child: Text(
                      'Discard',
                      style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (creatorId != null) {
                        UserService.createBatch(
                          batchName: batchNameController.text,
                          subBatches: selectedSubBatches
                              .map((subBatch) => {
                                    'name': subBatch,
                                    'users': [],
                                  })
                              .toList(),
                          creatorId: creatorId!,
                          description: descriptionController.text,
                        ).then((response) {
                          if (response != null) {
                            setState(() {
                              subBatches.add({
                                'name': batchNameController.text,
                                'subBatch': selectedSubBatches,
                                'description': descriptionController.text,
                              });
                            });
                            Navigator.pop(context);
                          }
                        });
                      } else {
                        print('Creator ID not available');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: Size(
                        MediaQuery.of(context).size.width * 0.2,
                        40,
                      ),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Batch',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                _showAddBatchDialog(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create Batch',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${subBatches.length} Batch${subBatches.length == 1 ? '' : 'es'}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            // View all batches
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BatchesPage(subBatches: subBatches),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'View All',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${subBatches.length} Batch${subBatches.length == 1 ? '' : 'es'}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}