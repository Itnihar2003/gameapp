import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentHistoryPage extends StatelessWidget {
  // Sample list of transactions with dates and times for demonstration
  final List<Map<String, String>> transactions = [
    {'date': '2023-06-01', 'time': '10:00 AM'},
    {'date': '2023-06-02', 'time': '11:30 AM'},
    {'date': '2023-06-03', 'time': '01:15 PM'},
    {'date': '2023-06-04', 'time': '02:45 PM'},
    {'date': '2023-06-05', 'time': '03:30 PM'},
    {'date': '2023-06-06', 'time': '04:00 PM'},
    {'date': '2023-06-07', 'time': '05:15 PM'},
    {'date': '2023-06-08', 'time': '06:00 PM'},
    {'date': '2023-06-09', 'time': '07:30 PM'},
    {'date': '2023-06-10', 'time': '08:45 PM'},
  ];

  String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('MMMM d, yyyy').format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Payment'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length, 
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                formatDate(transactions[index]['date']!), // Display the formatted date
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '₹ Amount',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                transactions[index]['time']!, // Display the time
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Balance: AMOUNT',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
