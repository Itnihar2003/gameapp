import 'package:flutter/material.dart';
import 'package:coachui/screen2/detailedfeehistorypages/student_list_page.dart';

class SubBatchListPage extends StatelessWidget {
  final String selectedBatch;

  SubBatchListPage({required this.selectedBatch});

  List<String> getSubBatches() {
    if (selectedBatch == 'All Students') {
      return [
        'U-12 Batch (Morning)',
        'U-12 Batch (Evening)',
        'U-14 Batch (Morning)',
        'U-14 Batch (Evening)',
        'U-16 Batch (Morning)',
        'U-16 Batch (Evening)',
        'U-19 Batch (Morning)',
        'U-19 Batch (Evening)',
        'U-23 Batch (Morning)',
        'U-23 Batch (Evening)',
        'Senior Batch (Morning)',
        'Senior Batch (Evening)',
        'Women Batch (Morning)',
        'Women Batch (Evening)',
      ];
    } else {
      return [
        '$selectedBatch (Morning)',
        '$selectedBatch (Evening)',
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> subBatches = getSubBatches();

    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: subBatches.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(subBatches[index]),
            subtitle: Text('2 Batch 30 Students'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentListPage(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
