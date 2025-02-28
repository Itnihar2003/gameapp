import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:coachui/screens/activityinsightspages/previous.dart';

class CircularPercentageIndicator extends StatefulWidget {
  final double defaultPercentage;

  const CircularPercentageIndicator({Key? key, this.defaultPercentage = 70.0}) : super(key: key);

  @override
  _CircularPercentageIndicatorState createState() => _CircularPercentageIndicatorState();
}

class _CircularPercentageIndicatorState extends State<CircularPercentageIndicator> {
  late double _percentage;

  @override
  void initState() {
    super.initState();
    _percentage = widget.defaultPercentage;
  }

  void updatePercentage(double newPercentage) {
    setState(() {
      _percentage = newPercentage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0x80786CFF), // 50% opacity
              Color(0x805AC8FA)  // 50% opacity
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Your Winning \n Percentage",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              SizedBox(height: 20.0),
              CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 20.0,
                percent: _percentage / 100,
                center: Text(
                  "${_percentage.toInt()}%",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                // Replacing purple with linear gradient
                progressColor: const Color(0xFF6A41B8),
                backgroundColor: Colors.white,
                circularStrokeCap: CircularStrokeCap.round,
              ),
              SizedBox(height: 20.0),
              Text(
                "Total number of times you have won\n the game",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.0,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width * 0.9, // 90% width of the screen
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  // Replacing purple color with linear gradient
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF7850BF), 
                      Color(0xFF512DA8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    // Navigate to the new page when Insights button is clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Activityprev()),
                    );
                  },
                  child: Text(
                    "Insights",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
