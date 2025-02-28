import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:coachui/features/chartfolder/piechart.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({Key? key}) : super(key: key);

  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  // List to store all expenses
  List<Map<String, String>> expenses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Center(
          child: Text(
            'Expenses',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _buildBarChart(),
              const SizedBox(height: 16),
              PieChartWidget(),
              const SizedBox(height: 32),
              _buildActionButton(
                'Add Expense',
                () {
                  _showAddExpenseDialog(context);
                },
              ),
              const SizedBox(height: 32),
              _buildActionButton(
                'View All Expenses',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExpenseListPage(expenses: expenses),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            '125',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 150,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 150,
                barTouchData: BarTouchData(
                  enabled: false,
                ),
                titlesData: FlTitlesData(
                  show: false,
                ),
                gridData: FlGridData(
                  show: false,
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: 70,
                        width: 12,
                        color: const Color(0xFF7850BF).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        toY: 50,
                        width: 12,
                        color: const Color(0xFF7850BF).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(
                        toY: 80,
                        width: 12,
                        color: const Color(0xFF7850BF).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [
                      BarChartRodData(
                        toY: 125,
                        width: 12,
                        color: const Color(0xFF7850BF),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 4,
                    barRods: [
                      BarChartRodData(
                        toY: 60,
                        width: 12,
                        color: const Color(0xFF7850BF).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 5,
                    barRods: [
                      BarChartRodData(
                        toY: 65,
                        width: 12,
                        color: const Color(0xFF7850BF).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                ],
                groupsSpace: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddExpenseDialog(BuildContext context) {
    final TextEditingController itemController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    DateTime? selectedDate;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Add Expense'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildInputField('Item', itemController),
                    const SizedBox(height: 8),
                    _buildInputField('Price', priceController, isNumeric: true),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                      child: _buildInputField(
                        'Date',
                        TextEditingController(
                          text: selectedDate != null
                              ? "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}"
                              : 'Select Date',
                        ),
                        isEnabled: false,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildInputField(
                      'Description',
                      descriptionController,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF512DA8),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                      ),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          expenses.add({
                            'item': itemController.text,
                            'price': priceController.text,
                            'date': selectedDate.toString(),
                            'description': descriptionController.text,
                          });
                        });
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF512DA8),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                      ),
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildInputField(String label, TextEditingController controller,
      {bool isNumeric = false, int maxLines = 1, bool isEnabled = true}) {
    return TextField(
      controller: controller,
      enabled: isEnabled,
      keyboardType:
          isNumeric ? TextInputType.number : TextInputType.text,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildActionButton(String text, VoidCallback onPressed) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8, // 80% of the screen width
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF7850BF), Color(0xFF512DA8)],
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class ExpenseListPage extends StatefulWidget {
  final List<Map<String, String>> expenses;

  const ExpenseListPage({Key? key, required this.expenses}) : super(key: key);

  @override
  _ExpenseListPageState createState() => _ExpenseListPageState();
}

class _ExpenseListPageState extends State<ExpenseListPage> {
  late List<Map<String, String>> expenses;

  @override
  void initState() {
    super.initState();
    expenses = widget.expenses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'All Expenses',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          final expense = expenses[index];

          return Dismissible(
            key: Key(expense['item'] ?? ''), // Unique key for each item
            direction: DismissDirection.endToStart, // Swipe from right to left
            onDismissed: (direction) {
              setState(() {
                expenses.removeAt(index); // Remove the item from the list
              });

              // Optionally, show a Snackbar or alert that the item is deleted
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${expense['item']} deleted')),
              );
            },
            background: Container(
              color: Colors.red, // Color for the swipe action (e.g., red for delete)
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20.0),
              child: const Icon(Icons.delete, color: Colors.white), // Delete icon
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: Text(expense['item'] ?? '', style: const TextStyle(color: Colors.white)),
                  subtitle: Text(expense['description'] ?? '', style: const TextStyle(color: Colors.white70)),
                  trailing: Text('₹${expense['price']}', style: const TextStyle(color: Colors.white)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
