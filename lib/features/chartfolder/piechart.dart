// pie_chart_widget.dart
import 'package:coachui/screen2/dashboardpages/dashboard.dart';
import 'package:coachui/screen2/manage/manage1.dart';
import 'package:coachui/screen2/paymentpages/payment.dart';
import 'package:coachui/screens/notify/notification.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class PieChartWidget extends StatefulWidget {
  const PieChartWidget({super.key});

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PaymentHistoryPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>ManagePage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>PieChartWidget()),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Payments'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:  SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hello Coach!',
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
                            builder: (context) =>
                                NotificationScreen(), // Replace with your NotificationPage
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
                
                SizedBox(height: 16),
                Container(decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 3),borderRadius: BorderRadius.circular(15),color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'Monthly Report',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                           
                                   Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Piedeco(),
                                SizedBox(height: 20),
                                Text(
                                  "25L",
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
            
                Text(
                      'Summery',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                     GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _summaryCard(
                        'Amount Received', '25,00,000', Colors.green[100]!, Colors.green),
                    _summaryCard('Amount Received', '25,00,000', Colors.orange[100]!,
                        Colors.orange),
                   
                  ],
                ),
                        Container(width: MediaQuery.of(context).size.width*0.9,child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),onPressed: (){}, child: Text("Add Transactions",style: TextStyle(color: Colors.white),))),
        Container(width: MediaQuery.of(context).size.width*0.9,child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),onPressed: (){}, child: Text("View All Payments",style: TextStyle(color: Colors.white)))),
              ],
            ),
        ),
    ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Payment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            label: 'Manage',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
   Widget _summaryCard(
      String title, String value, Color bgColor, Color barColor) {
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
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class Piedeco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: PieChart(
        PieChartData(
          sections: getSections(),
          centerSpaceRadius: 50,
          sectionsSpace: 2,
        ),
      ),
    );
  }

  List<PieChartSectionData> getSections() {
    return [
      PieChartSectionData(
        color: Colors.green,
        value: 20,
        title: 'U-23',
        radius: 40,
      ),
      PieChartSectionData(
        color: Colors.orange,
        value: 20,
        title: 'U-13',
        radius: 40,
      ),
      PieChartSectionData(
        color: Colors.red,
        value: 20,
        title: 'U-19',
        radius: 40,
      ),
      PieChartSectionData(
        color: Colors.purple,
        value: 20,
        title: 'U-16',
        radius: 40,
      ),
      PieChartSectionData(
        color: Colors.blue,
        value: 20,
        title: 'Senior',
        radius: 40,
      ),
    ];
  }
  
}
