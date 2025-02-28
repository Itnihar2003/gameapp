// pie_chart_widget.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LegendItem(color: Colors.blue, label: "Senior"),
            LegendItem(color: Colors.purple, label: "U-16"),
            LegendItem(color: Colors.red, label: "U-19"),
            LegendItem(color: Colors.pinkAccent, label: "Women"),
            LegendItem(color: Colors.orange, label: "U-13"),
            LegendItem(color: Colors.blueAccent, label: "U-23"),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: AspectRatio(
            aspectRatio: 1.5,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(value: 25, color: Colors.blue, title: ''),
                  PieChartSectionData(value: 25, color: Colors.purple, title: ''),
                  PieChartSectionData(value: 25, color: Colors.red, title: ''),
                  PieChartSectionData(value: 25, color: Colors.pinkAccent, title: ''),
                  PieChartSectionData(value: 25, color: Colors.orange, title: ''),
                  PieChartSectionData(value: 25, color: Colors.blueAccent, title: ''),
                ],
                centerSpaceRadius: 40,
                sectionsSpace: 3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const LegendItem({Key? key, required this.color, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
