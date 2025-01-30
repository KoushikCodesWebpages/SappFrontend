import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StuTimetable extends StatefulWidget {
  const StuTimetable({super.key});

  @override
  StuTimetableState createState() => StuTimetableState();
}

class StuTimetableState extends State<StuTimetable> {
  Map<String, dynamic>? timetable;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadTimetable();
  }

  Future<void> loadTimetable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedTimetable = prefs.getString('timetable');

    if (storedTimetable != null) {
      setState(() {
        timetable = json.decode(storedTimetable);
        isLoading = false;
      });
    } else {
      setState(() {
        timetable = defaultTimetable();
        isLoading = false;
      });
      saveTimetable(); // Save default timetable initially
    }
  }

  Future<void> saveTimetable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('timetable', json.encode(timetable));
  }

  // Default timetable (like the API data)
  Map<String, dynamic> defaultTimetable() {
    return {
      "Monday": ["Math", "Physics", "Chemistry"],
      "Tuesday": ["Biology", "History", "Art"],
      "Wednesday": ["PE", "Math", "Computer Science"],
      "Thursday": ["English", "Geography", "Biology"],
      "Friday": ["Chemistry", "Physics", "Math"]
    };
  }

  // Simulating an update (you can modify this as needed)
  void updateTimetable() {
    setState(() {
      timetable = {
        "Monday": ["Updated Math", "Updated Physics", "Updated Chemistry"],
        "Tuesday": ["New Biology", "New History", "New Art"],
        "Wednesday": ["New PE", "New Math", "New Computer Science"],
        "Thursday": ["New English", "New Geography", "New Biology"],
        "Friday": ["New Chemistry", "New Physics", "New Math"]
      };
    });
    saveTimetable(); // Save updated timetable
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Student Time Table"),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: updateTimetable, // Simulating new data
            )
          ],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : timetable == null
                ? const Center(child: Text("Failed to load timetable"))
                : ListView.builder(
                    itemCount: timetable!.keys.length,
                    itemBuilder: (context, index) {
                      String day = timetable!.keys.elementAt(index);
                      List<String> subjects =
                          List<String>.from(timetable![day]);
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ExpansionTile(
                          title: Text(day),
                          children: subjects
                              .map((subject) => ListTile(
                                    title: Text(subject),
                                  ))
                              .toList(),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
