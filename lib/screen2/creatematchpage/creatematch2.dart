import 'package:flutter/material.dart';
import 'package:coachui/screen2/creatematchpage/selecteam1.dart';
class CreateMatch2Page extends StatefulWidget {
  @override
  _CreateMatch2PageState createState() => _CreateMatch2PageState();
}

class _CreateMatch2PageState extends State<CreateMatch2Page> {
  String selectedTeam1 = "Choose Team";
  String selectedTeam2 = "Choose Team";
  String selectedVenue = "Select Ground";
  TimeOfDay selectedTime = TimeOfDay(hour: 10, minute: 0);
  String selectedMatchType = "Friendly";

  final List<String> teams = ["Team A", "Team B", "Team C", "Team D"];
  final List<String> venues = ["Ground 1", "Ground 2", "Ground 3"];

  void _resetFields() {
    setState(() {
      selectedTeam1 = "Choose Team";
      selectedTeam2 = "Choose Team";
      selectedVenue = "Select Ground";
      selectedTime = TimeOfDay(hour: 10, minute: 0);
      selectedMatchType = "Friendly";
    });
  }

  void _navigateToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectTeam1Page()), // Replace `NextPage` with your page widget
    );
  }

  void _selectTeam(String teamType) async {
    String? selected = await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("Select Team"),
          children: teams
              .map((team) => SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, team);
                    },
                    child: Text(team),
                  ))
              .toList(),
        );
      },
    );

    if (selected != null) {
      setState(() {
        if (teamType == "team1") {
          selectedTeam1 = selected;
        } else {
          selectedTeam2 = selected;
        }
      });
    }
  }

  void _selectVenue() async {
    String? selected = await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("Select Ground"),
          children: venues
              .map((venue) => SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, venue);
                    },
                    child: Text(venue),
                  ))
              .toList(),
        );
      },
    );

    if (selected != null) {
      setState(() {
        selectedVenue = selected;
      });
    }
  }

  void _selectTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _selectMatchType() async {
    String? selected = await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("Select Match Type"),
          children: ["Friendly", "Competitive"]
              .map((type) => SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, type);
                    },
                    child: Text(type),
                  ))
              .toList(),
        );
      },
    );

    if (selected != null) {
      setState(() {
        selectedMatchType = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Create Match",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "New Match",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildSelectionContainer("Select Team 1", selectedTeam1, () => _selectTeam("team1")),
            _buildSelectionContainer("Select Team 2", selectedTeam2, () => _selectTeam("team2")),
            _buildSelectionContainer("Select Venue", selectedVenue, _selectVenue),
            _buildSelectionContainer("Select Time", "${selectedTime.format(context)}", _selectTime),
            _buildSelectionContainer("Type of Match", selectedMatchType, _selectMatchType),
            _buildInputField("Remarks", "Remarks"),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton("Discard", Colors.white, const Color(0xFF512DA8), _resetFields),
                _buildButton("Save", const Color(0xFF512DA8), Colors.white, _navigateToNextPage),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionContainer(String title, String value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hintText) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildButton(String label, Color bgColor, Color textColor, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        minimumSize: Size(150, 50),
        side: BorderSide(color: const Color(0xFF512DA8)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      ),
      child: Text(
        label,
        style: TextStyle(color: textColor),
      ),
    );
  }
}


