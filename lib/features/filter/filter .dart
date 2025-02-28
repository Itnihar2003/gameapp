import 'package:flutter/material.dart';

class SortByContainer extends StatefulWidget {
  final Function(String?) onBatchSelected; // Callback to pass selected batch

  SortByContainer({required this.onBatchSelected});

  @override
  _SortByContainerState createState() => _SortByContainerState();
}

class _SortByContainerState extends State<SortByContainer> {
  int? _selectedButtonIndex;
  String? _selectedBatch;

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            double buttonWidth = (MediaQuery.of(context).size.width - 0) / 3.5; // Subtracting padding and margin

            // List of button labels
            List<String> buttonLabels = ['U-14', 'U-16', 'U-19', 'U-23', 'Senior', 'Summercamp', 'Women'];

            return Container(
              height: MediaQuery.of(context).size.height * 0.45, // 45% of the screen height
              width: MediaQuery.of(context).size.width, // Full width of the screen
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Filter',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Batch',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  // Displaying buttons with labels from the list
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(buttonLabels.length, (index) {
                      return Container(
                        width: buttonWidth,
                        height: 40, // Fixed height for rectangular shape
                        child: ElevatedButton(
                          onPressed: () {
                            setModalState(() {
                              _selectedButtonIndex = index;
                              _selectedBatch = buttonLabels[index];
                            });
                          },
                          style: ElevatedButton.styleFrom(
                             backgroundColor: _selectedButtonIndex == index
                                ? Colors.purple
                                : Colors.white,
                            foregroundColor: _selectedButtonIndex == index
                                ? Colors.white
                                : Colors.black,
                            side: BorderSide(color: Colors.grey),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0), // Less border radius for more rectangular shape
                            ),
                          ),
                          child: Text(
                            buttonLabels[index],
                            style: TextStyle(
                              color: _selectedButtonIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  Spacer(), // Pushes the buttons to the bottom
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          setModalState(() {
                            _selectedButtonIndex = null;
                            _selectedBatch = null;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                         foregroundColor: Colors.purple,
                          side: BorderSide(color: Colors.purple),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text('Reset'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          widget.onBatchSelected(_selectedBatch); // Pass selected batch to parent
                          Navigator.pop(context); // Close the bottom sheet
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text('Apply'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showFilterOptions(context),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.075,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Sort by',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
