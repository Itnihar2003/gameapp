import 'package:flutter/material.dart';
import 'package:coachui/features/timepickerscrollable/am_pm.dart';
import 'package:coachui/features/timepickerscrollable/hours.dart';
import 'package:coachui/features/timepickerscrollable/minutes.dart';

class WorkoutReminderPage extends StatefulWidget {
  @override
  _WorkoutReminderPageState createState() => _WorkoutReminderPageState();
}

class _WorkoutReminderPageState extends State<WorkoutReminderPage> {
  final FixedExtentScrollController _hoursController = FixedExtentScrollController();
  final FixedExtentScrollController _minutesController = FixedExtentScrollController();
  bool isAmSelected = true;
  int selectedHours = 0;
  int selectedMinutes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Workout Reminder'),
        actions: const [
          SizedBox(width: 48),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            const Text(
              'Select the days you want to exercise',
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hours wheel
                Container(
                  width: 70,
                  height: 150,
                  child: ListWheelScrollView.useDelegate(
                    controller: _hoursController,
                    itemExtent: 50,
                    perspective: 0.005,
                    diameterRatio: 1.2,
                    physics: FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedHours = index;
                      });
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 13,
                      builder: (context, index) {
                        return MyHours(
                          hours: index,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // Minutes wheel
                Container(
                  width: 70,
                  height: 150,
                  child: ListWheelScrollView.useDelegate(
                    controller: _minutesController,
                    itemExtent: 50,
                    perspective: 0.005,
                    diameterRatio: 1.2,
                    physics: FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedMinutes = index;
                      });
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 60,
                      builder: (context, index) {
                        return MyMinutes(
                          mins: index,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // AM or PM selection
                Container(
                  width: 70,
                  height: 150,
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 50,
                    perspective: 0.005,
                    diameterRatio: 1.2,
                    physics: FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        isAmSelected = index == 0;
                      });
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 2,
                      builder: (context, index) {
                        return AmPm(
                          isItAm: index == 0,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            const Text(
              'Select the times you want to exercise',
              style: TextStyle(fontSize: 32),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement your reminder button functionality here
                      // For example, save selected time or set a reminder
                      print('Reminder button pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, 
                      backgroundColor: Colors.purple,
                      
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      'Create a Remainder',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
