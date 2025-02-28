import 'package:flutter/material.dart';
import 'sub_batch_list_page.dart';

class BatchListPage extends StatefulWidget {
  @override
  _BatchListPageState createState() => _BatchListPageState();
}

class _BatchListPageState extends State<BatchListPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> batches = [
    'All Students',
    'U-12 Batch',
    'U-14 Batch',
    'U-16 Batch',
    'U-19 Batch',
    'U-23 Batch',
    'Senior Batch',
    'Women Batch'
  ];
  List<String> filteredBatches = [];

  @override
  void initState() {
    super.initState();
    filteredBatches = batches;
    _searchController.addListener(() {
      setState(() {
        filteredBatches = batches
            .where((batch) => batch
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
        leading: Icon(Icons.arrow_back),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search something',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredBatches.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredBatches[index]),
                  subtitle: Text('2 Batch 30 Students'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubBatchListPage(
                          selectedBatch: filteredBatches[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
