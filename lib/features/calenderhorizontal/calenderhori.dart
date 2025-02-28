import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HorizontalCalendar extends StatefulWidget {
  @override
  _HorizontalCalendarState createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  final DateTime currentDate = DateTime.now();
  final DateFormat dayFormat = DateFormat('d');
  final DateFormat monthFormat = DateFormat('MMM');
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        double boxWidth = MediaQuery.of(context).size.width * 0.15;
        double initialScrollOffset = boxWidth * 182; 
        _scrollController.jumpTo(initialScrollOffset);
      }
    });

    
    double boxWidth = MediaQuery.of(context).size.width * 0.15;
    double boxHeight = MediaQuery.of(context).size.height * 0.1; 

    return Container(
      height: boxHeight, 
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: 365, 
        itemBuilder: (context, index) {
          DateTime date = currentDate.add(Duration(days: index - 182)); 
          bool isToday = DateTime(date.year, date.month, date.day) ==
              DateTime(currentDate.year, currentDate.month, currentDate.day);

          return Container(
            width: boxWidth,
            margin: EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: isToday ? Color(0xFF6A41B8) : Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey, width: 0.5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  dayFormat.format(date),
                  style: TextStyle(
                    fontSize: 24,
                    color: isToday ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  monthFormat.format(date),
                  style: TextStyle(
                    fontSize: 16,
                    color: isToday ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}